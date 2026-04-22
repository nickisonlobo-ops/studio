import { createSupabaseClient } from '~/lib/supabase'

// Rotas bloqueadas para funcionario (somente admin/gerente)
const MANAGER_ROUTES = ['/contas-pagar', '/produtos', '/funcionarios']
// Rotas públicas (sem login)
const PUBLIC_ROUTES = ['/catalogo', '/loja', '/agendar']

export default defineNuxtRouteMiddleware(async (to) => {
  const supabase = createSupabaseClient()
  const { data: { session } } = await supabase.auth.getSession()

  // Permite acesso sem login para catálogo e páginas de detalhe de veículo
  if (PUBLIC_ROUTES.some(r => to.path === r || to.path.startsWith(r + '/'))) {
    return
  }

  if (to.path === '/login') {
    if (session) {
      // Redireciona para /atividades se for funcionario, senão para /
      const { data: profile } = await supabase
        .from('profiles')
        .select('perfil')
        .eq('id', session.user.id)
        .maybeSingle()
      const perfil = profile?.perfil ?? session.user.user_metadata?.perfil ?? null
      if (perfil === 'funcionario') return navigateTo('/atividades')
      return navigateTo('/')
    }
    return
  }

  if (!session) {
    return navigateTo('/login')
  }

  // Lê perfil para todas as rotas restritas
  const needsCheck = MANAGER_ROUTES.includes(to.path)
  if (needsCheck) {
    const { data: profile } = await supabase
      .from('profiles')
      .select('perfil')
      .eq('id', session.user.id)
      .maybeSingle()

    const perfil: string | null =
      profile?.perfil ??
      (session.user.user_metadata?.perfil as string | undefined) ??
      null

    // Só bloqueia se SOUBER que é funcionario — se perfil for null, deixa passar
    if (perfil === 'funcionario') {
      return navigateTo('/atividades')
    }
  }
})
