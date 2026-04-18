import { useState } from '#app'
import { createSupabaseClient } from '~/lib/supabase'

export function useEmpresa() {
  const empresaId      = useState<number | null>('empresa_id',          () => null)
  const userPerfil     = useState<string | null>('user_perfil',         () => null)
  const loadedForUser  = useState<string | null>('empresa_loaded_user', () => null)
  const empresaError   = useState<string | null>('empresa_error',       () => null)

  async function loadEmpresa() {
    const supabase = createSupabaseClient()
    const { data: { session } } = await supabase.auth.getSession()
    if (!session?.user) return

    // Só usa o cache se for o mesmo usuário logado
    if (empresaId.value !== null && loadedForUser.value === session.user.id) return

    loadedForUser.value = session.user.id

    // Lê o profile do banco — fonte de verdade
    const { data: profile } = await supabase
      .from('profiles')
      .select('empresa_id, perfil')
      .eq('id', session.user.id)
      .maybeSingle()

    if (profile?.empresa_id) {
      // Profile correto no banco — usa direto
      empresaId.value  = profile.empresa_id
      userPerfil.value = profile.perfil ?? 'funcionario'
      return
    }

    // Profile existe mas empresa_id é null, ou profile ainda não existe.
    // Isso só deve ocorrer se o trigger handle_new_user falhou ou
    // se este é um usuário legado. Tenta recuperar pelo metadata do JWT.
    const metaEmpresaId = session.user.user_metadata?.empresa_id as number | null | undefined
    const metaPerfil    = (session.user.user_metadata?.perfil as string | undefined) ?? 'funcionario'

    if (metaEmpresaId) {
      // Funcionário: usa empresa e perfil do metadata (definidos pelo admin no signUp)
      // Chama RPC SECURITY DEFINER para garantir que o profile será salvo sem bloqueio de RLS
      await supabase.rpc('create_employee_profile', {
        p_user_id:    session.user.id,
        p_empresa_id: metaEmpresaId,
        p_email:      session.user.email ?? '',
        p_nome:       session.user.user_metadata?.full_name ?? null,
        p_perfil:     metaPerfil === 'admin' ? 'funcionario' : metaPerfil,
      })
      empresaId.value  = metaEmpresaId
      userPerfil.value = metaPerfil === 'admin' ? 'funcionario' : metaPerfil
      return
    }

    // Sem empresa_id no metadata e sem profile → apenas admin novo (sem empresa ainda)
    // Somente admin chega aqui; funcionários sempre têm empresa_id no metadata
    if (profile?.perfil && profile.perfil !== 'admin') {
      // Funcionário sem empresa vinculada — erro de cadastro, não criar nova empresa
      console.error('[useEmpresa] Funcionário sem empresa_id. Contate o administrador.')
      userPerfil.value = profile.perfil
      return
    }

    // Último recurso: admin novo, cria empresa via RPC SECURITY DEFINER
    const nomeEmpresa: string =
      (session.user.user_metadata?.empresa_nome as string | undefined) ??
      (session.user.user_metadata?.full_name as string | undefined) ??
      session.user.email?.split('@')[0] ??
      'Minha Empresa'

    const { data: rpcResult, error: rpcError } = await supabase.rpc('setup_admin_account', {
      p_empresa_nome: nomeEmpresa,
    })

    if (rpcError) {
      console.error('[useEmpresa] setup_admin_account error:', rpcError.message)
      empresaError.value = 'Não foi possível configurar sua empresa. Execute o SQL de setup no Supabase e faça login novamente.'
      return
    }

    if (rpcResult?.empresa_id) {
      await supabase.auth.updateUser({
        data: { empresa_id: rpcResult.empresa_id, perfil: 'admin' },
      })
      await supabase.auth.refreshSession()
      empresaId.value    = rpcResult.empresa_id
      userPerfil.value   = 'admin'
      empresaError.value = null
    }
  }

  return { empresaId, userPerfil, empresaError, loadEmpresa }
}

