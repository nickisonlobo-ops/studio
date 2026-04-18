import { ref } from 'vue'
import { createSupabaseClient } from '~/lib/supabase'

export function useAuth() {
  const supabase = createSupabaseClient()
  const loading = ref(false)
  const error = ref<string | null>(null)

  async function login(email: string, password: string) {
    loading.value = true
    error.value = null

    const { data, error: authError } = await supabase.auth.signInWithPassword({ email, password })

    if (authError) {
      loading.value = false
      if (authError.message === 'Email not confirmed') {
        error.value = 'Confirme seu e-mail antes de entrar. Verifique sua caixa de entrada.'
      } else if (authError.message === 'Invalid login credentials') {
        error.value = 'E-mail ou senha incorretos.'
      } else {
        error.value = authError.message
      }
      return false
    }

    // Sempre sincroniza empresa_id e perfil do banco para o JWT.
    // Garante que funcionários criados pelo admin nunca recebam perfil errado.
    if (data.user) {
      const { data: profile } = await supabase
        .from('profiles')
        .select('empresa_id, perfil')
        .eq('id', data.user.id)
        .maybeSingle()

      if (profile?.empresa_id) {
        const perfilDB = profile.perfil ?? 'funcionario'
        const metaEmpresaId = data.user.user_metadata?.empresa_id
        const metaPerfil    = data.user.user_metadata?.perfil

        // Só atualiza o JWT se algum valor estiver desatualizado
        if (String(metaEmpresaId) !== String(profile.empresa_id) || metaPerfil !== perfilDB) {
          await supabase.auth.updateUser({
            data: { empresa_id: profile.empresa_id, perfil: perfilDB },
          })
          await supabase.auth.refreshSession()
        }
      }
    }

    loading.value = false
    return true
  }

  async function register(name: string, email: string, password: string, nomeEmpresa: string) {
    loading.value = true
    error.value = null

    const { data, error: authError } = await supabase.auth.signUp({
      email,
      password,
      options: {
        data: { full_name: name, perfil: 'admin', empresa_nome: nomeEmpresa.trim() },
      },
    })

    if (authError) {
      loading.value = false
      error.value = authError.message
      return { ok: false, needsConfirmation: false }
    }

    const needsConfirmation = !data.session

    // Enquanto a sessão está ativa, cria a empresa e vincula o profile imediatamente.
    // Não depende do loadEmpresa() para fazer isso.
    if (data.session && data.user) {
      const { data: rpcResult, error: rpcError } = await supabase.rpc('setup_admin_account', {
        p_empresa_nome: nomeEmpresa.trim(),
      })

      if (rpcError) {
        console.error('[register] setup_admin_account error:', rpcError.message)
        loading.value = false
        error.value = `Erro ao configurar empresa: ${rpcError.message}`
        return { ok: false, needsConfirmation: false }
      }

      if (rpcResult?.empresa_id) {
        await supabase.auth.updateUser({
          data: { empresa_id: rpcResult.empresa_id, perfil: 'admin', empresa_nome: nomeEmpresa.trim() },
        })
        await supabase.auth.refreshSession()
      }
    }

    loading.value = false
    return { ok: true, needsConfirmation }
  }

  async function logout() {
    const empresaId     = useState<number | null>('empresa_id',          () => null)
    const userPerfil    = useState<string | null>('user_perfil',         () => null)
    const loadedForUser = useState<string | null>('empresa_loaded_user', () => null)
    empresaId.value     = null
    userPerfil.value    = null
    loadedForUser.value = null
    await supabase.auth.signOut()
  }

  return { login, register, logout, loading, error }
}


