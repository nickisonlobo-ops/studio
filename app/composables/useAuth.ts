import { ref } from 'vue'
import { createSupabaseClient } from '~/lib/supabase'

export function useAuth() {
  const supabase = createSupabaseClient()
  const loading = ref(false)
  const error = ref<string | null>(null)

  async function login(email: string, password: string) {
    loading.value = true
    error.value = null

    const { error: authError } = await supabase.auth.signInWithPassword({ email, password })

    loading.value = false

    if (authError) {
      if (authError.message === 'Email not confirmed') {
        error.value = 'Confirme seu e-mail antes de entrar. Verifique sua caixa de entrada.'
      } else if (authError.message === 'Invalid login credentials') {
        error.value = 'E-mail ou senha incorretos.'
      } else {
        error.value = authError.message
      }
      return false
    }

    return true
  }

  async function register(name: string, email: string, password: string) {
    loading.value = true
    error.value = null

    const { data, error: authError } = await supabase.auth.signUp({
      email,
      password,
      options: {
        data: { full_name: name },
      },
    })

    loading.value = false

    if (authError) {
      error.value = authError.message
      return { ok: false, needsConfirmation: false }
    }

    // Se não há sessão, o Supabase requer confirmação por e-mail
    const needsConfirmation = !data.session
    return { ok: true, needsConfirmation }
  }

  async function logout() {
    await supabase.auth.signOut()
  }

  return { login, register, logout, loading, error }
}
