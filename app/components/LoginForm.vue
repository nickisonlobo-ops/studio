<template>
  <div class="w-full max-w-md bg-gray-900 border border-white/[0.07] rounded-2xl shadow-2xl p-8">
    <!-- Marca -->
    <div class="flex items-center justify-center gap-3 mb-8">
      <div class="w-9 h-9 rounded-xl bg-gradient-to-br from-amber-400 to-amber-600 flex items-center justify-center shadow-md shadow-amber-900/40">
        <svg class="w-[18px] h-[18px] text-gray-950" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" d="M8.25 18.75a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m3 0h6m-9 0H3.375a1.125 1.125 0 01-1.125-1.125V14.25m17.25 4.5a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m3 0h1.125c.621 0 1.129-.504 1.09-1.124a17.902 17.902 0 00-3.213-9.193 2.056 2.056 0 00-1.58-.86H14.25M16.5 18.75h-2.25m0-11.177v-.958c0-.568-.422-1.048-.987-1.106a48.554 48.554 0 00-10.026 0 1.106 1.106 0 00-.987 1.106v7.635m12-6.677v6.677m0 4.5v-4.5m0 0h-12"/></svg>
      </div>
      <span class="text-2xl font-black text-white tracking-tight">AutoFlow</span>
    </div>

    <!-- Abas -->
    <div class="flex rounded-xl bg-white/[0.05] p-1 mb-6">
      <button
        v-for="tab in tabs"
        :key="tab.key"
        type="button"
        :class="[
          'flex-1 py-2 text-sm font-semibold rounded-lg transition-colors duration-200',
          activeTab === tab.key
            ? 'bg-amber-500 text-gray-950 shadow-sm'
            : 'text-gray-400 hover:text-white',
        ]"
        @click="activeTab = tab.key"
      >
        {{ tab.label }}
      </button>
    </div>

    <!-- Título dinâmico -->
    <h1 class="text-xl font-bold text-white text-center mb-6">
      {{ activeTab === 'login' ? 'Entre na sua conta' : 'Crie sua conta' }}
    </h1>

    <!-- Entrar -->
    <form v-if="activeTab === 'login'" class="flex flex-col gap-5" @submit.prevent="handleLogin">
      <AppInput
        v-model="login.email"
        label="E-mail"
        type="email"
        placeholder="Digite seu e-mail"
        :error="formErrors.email"
        required
      />
      <AppInput
        v-model="login.password"
        :type="showPassword ? 'text' : 'password'"
        label="Senha"
        placeholder="Digite sua senha"
        :error="formErrors.password"
        required
      >
        <template #trailing>
          <button type="button" class="text-gray-500 hover:text-gray-300 transition-colors" @click="showPassword = !showPassword">
            <svg v-if="showPassword" class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 001.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.45 10.45 0 0112 4.5c4.756 0 8.773 3.162 10.065 7.498a10.523 10.523 0 01-4.293 5.774M6.228 6.228L3 3m3.228 3.228l3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 10-4.243-4.243m4.242 4.242L9.88 9.88"/></svg>
            <svg v-else class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
          </button>
        </template>
      </AppInput>
      <p v-if="authError" class="text-sm text-red-400 bg-red-500/10 border border-red-500/20 rounded-lg px-4 py-2.5 text-center">
        {{ authError }}
      </p>
      <AppButton variant="secondary" size="lg" type="submit" :loading="authLoading" class="mt-2 w-full !bg-amber-500 !text-gray-950 !border-amber-500 hover:!bg-amber-400 font-bold">
        Entrar
      </AppButton>
    </form>

    <!-- Criar conta -->
    <form v-else class="flex flex-col gap-5" @submit.prevent="handleRegister">
      <AppInput
        v-model="register.name"
        label="Nome"
        type="text"
        placeholder="Digite seu nome completo"
        :error="registerErrors.name"
        required
      />
      <AppInput
        v-model="register.nomeEmpresa"
        label="Nome da empresa / revendedora"
        type="text"
        placeholder="Ex: AutoFlow Veículos"
        :error="registerErrors.nomeEmpresa"
        required
      />
      <AppInput
        v-model="register.email"
        label="E-mail"
        type="email"
        placeholder="Digite seu e-mail"
        :error="registerErrors.email"
        required
      />
      <AppInput
        v-model="register.password"
        :type="showRegisterPassword ? 'text' : 'password'"
        label="Senha"
        placeholder="Digite sua senha"
        :error="registerErrors.password"
        required
      >
        <template #trailing>
          <button type="button" class="text-gray-500 hover:text-gray-300 transition-colors" @click="showRegisterPassword = !showRegisterPassword">
            <svg v-if="showRegisterPassword" class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 001.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.45 10.45 0 0112 4.5c4.756 0 8.773 3.162 10.065 7.498a10.523 10.523 0 01-4.293 5.774M6.228 6.228L3 3m3.228 3.228l3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 10-4.243-4.243m4.242 4.242L9.88 9.88"/></svg>
            <svg v-else class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
          </button>
        </template>
      </AppInput>
      <AppInput
        v-model="register.confirmPassword"
        :type="showRegisterPassword ? 'text' : 'password'"
        label="Confirmar Senha"
        placeholder="Confirme sua senha"
        :error="registerErrors.confirmPassword"
        required
      />
      <p v-if="authError" class="text-sm text-red-400 bg-red-500/10 border border-red-500/20 rounded-lg px-4 py-2.5 text-center">
        {{ authError }}
      </p>
      <p v-if="registerSuccess" class="text-sm text-amber-400 bg-amber-500/10 border border-amber-500/20 rounded-lg px-4 py-2.5 text-center">
        Cadastro realizado! Verifique seu e-mail para confirmar a conta.
      </p>
      <AppButton variant="secondary" size="lg" type="submit" :loading="authLoading" class="mt-2 w-full !bg-amber-500 !text-gray-950 !border-amber-500 hover:!bg-amber-400 font-bold">
        Criar conta
      </AppButton>
    </form>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import AppInput from '~/components/AppInput.vue'
import AppButton from '~/components/AppButton.vue'
import { useAuth } from '~/composables/useAuth'

defineOptions({ name: 'LoginForm' })

const router = useRouter()
const { login: authLogin, register: authRegister, loading: authLoading, error: authError } = useAuth()

const tabs: { key: 'login' | 'register'; label: string }[] = [
  { key: 'login',    label: 'Entrar' },
  { key: 'register', label: 'Criar conta' },
]

const activeTab = ref<'login' | 'register'>('login')
const showPassword = ref(false)
const showRegisterPassword = ref(false)

const login = reactive({ email: '', password: '' })
const register = reactive({ name: '', nomeEmpresa: '', email: '', password: '', confirmPassword: '' })

const formErrors = reactive({ email: '', password: '' })
const registerErrors = reactive({ name: '', nomeEmpresa: '', email: '', password: '', confirmPassword: '' })

const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

function validateLogin(): boolean {
  formErrors.email = ''
  formErrors.password = ''

  if (!login.email) {
    formErrors.email = 'O e-mail é obrigatório.'
  } else if (!emailRegex.test(login.email)) {
    formErrors.email = 'Informe um e-mail válido.'
  }

  if (!login.password) {
    formErrors.password = 'A senha é obrigatória.'
  }

  return !formErrors.email && !formErrors.password
}

function validateRegister(): boolean {
  registerErrors.name = ''
  registerErrors.nomeEmpresa = ''
  registerErrors.email = ''
  registerErrors.password = ''
  registerErrors.confirmPassword = ''

  if (!register.name.trim()) {
    registerErrors.name = 'O nome é obrigatório.'
  }

  if (!register.nomeEmpresa.trim()) {
    registerErrors.nomeEmpresa = 'O nome da empresa é obrigatório.'
  }

  if (!register.email) {
    registerErrors.email = 'O e-mail é obrigatório.'
  } else if (!emailRegex.test(register.email)) {
    registerErrors.email = 'Informe um e-mail válido.'
  }

  if (!register.password) {
    registerErrors.password = 'A senha é obrigatória.'
  } else if (register.password.length < 6) {
    registerErrors.password = 'A senha deve ter no mínimo 6 caracteres.'
  }

  if (!register.confirmPassword) {
    registerErrors.confirmPassword = 'Confirme sua senha.'
  } else if (register.password !== register.confirmPassword) {
    registerErrors.confirmPassword = 'As senhas não coincidem.'
  }

  return !registerErrors.name && !registerErrors.nomeEmpresa && !registerErrors.email && !registerErrors.password && !registerErrors.confirmPassword
}

async function handleLogin() {
  if (!validateLogin()) return
  const ok = await authLogin(login.email, login.password)
  if (ok) {
    await router.push('/')
  }
}

const registerSuccess = ref(false)

async function handleRegister() {
  if (!validateRegister()) return
  const { ok, needsConfirmation } = await authRegister(register.name, register.email, register.password, register.nomeEmpresa)
  if (ok) {
    if (needsConfirmation) {
      registerSuccess.value = true
    } else {
      await router.push('/')
    }
  }
}
</script>
