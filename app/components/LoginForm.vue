<template>
  <div class="w-full max-w-md bg-white rounded-2xl shadow-2xl p-8">
    <!-- Marca -->
    <div class="flex items-center justify-center gap-2 mb-8">
      <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" stroke-width="1.75" viewBox="0 0 24 24" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" d="M12 2C8.5 2 5 5.5 5 9.5c0 3 1.7 5.6 4.3 6.9L11 21h2l1.7-4.6C17.3 15.1 19 12.5 19 9.5 19 5.5 15.5 2 12 2zm0 0v10"/></svg>
      <span class="text-2xl font-bold text-primary">Sistema PetFlow</span>
    </div>

    <!-- Abas -->
    <div class="flex rounded-xl bg-orange-50 p-1 mb-6">
      <button
        v-for="tab in tabs"
        :key="tab.key"
        type="button"
        :class="[
          'flex-1 py-2 text-sm font-semibold rounded-lg transition-colors duration-200',
          activeTab === tab.key
            ? 'bg-bg-surface text-secondary shadow-sm'
            : 'text-content-muted hover:text-content',
        ]"
        @click="activeTab = tab.key"
      >
        {{ tab.label }}
      </button>
    </div>

    <!-- Título dinâmico -->
    <h1 class="text-2xl font-bold text-content text-center mb-6">
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
          <button type="button" class="text-content-muted hover:text-content transition-colors" @click="showPassword = !showPassword">
            <span v-if="showPassword">�YT^</span>
            <span v-else>�Y'�️</span>
          </button>
        </template>
      </AppInput>
      <p v-if="authError" class="text-sm text-red-600 bg-red-50 border border-red-200 rounded-lg px-4 py-2.5 text-center">
        {{ authError }}
      </p>
      <AppButton variant="secondary" size="lg" type="submit" :loading="authLoading" class="mt-2 w-full">
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
          <button type="button" class="text-content-muted hover:text-content transition-colors" @click="showRegisterPassword = !showRegisterPassword">
            <span v-if="showRegisterPassword">�YT^</span>
            <span v-else>�Y'�️</span>
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
      <p v-if="authError" class="text-sm text-red-600 bg-red-50 border border-red-200 rounded-lg px-4 py-2.5 text-center">
        {{ authError }}
      </p>
      <p v-if="registerSuccess" class="text-sm text-green-700 bg-green-50 border border-green-200 rounded-lg px-4 py-2.5 text-center">
        Cadastro realizado! Verifique seu e-mail para confirmar a conta.
      </p>
      <AppButton variant="secondary" size="lg" type="submit" :loading="authLoading" class="mt-2 w-full">
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
const register = reactive({ name: '', email: '', password: '', confirmPassword: '' })

const formErrors = reactive({ email: '', password: '' })
const registerErrors = reactive({ name: '', email: '', password: '', confirmPassword: '' })

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
  registerErrors.email = ''
  registerErrors.password = ''
  registerErrors.confirmPassword = ''

  if (!register.name.trim()) {
    registerErrors.name = 'O nome é obrigatório.'
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

  return !registerErrors.name && !registerErrors.email && !registerErrors.password && !registerErrors.confirmPassword
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
  const { ok, needsConfirmation } = await authRegister(register.name, register.email, register.password)
  if (ok) {
    if (needsConfirmation) {
      registerSuccess.value = true
    } else {
      await router.push('/')
    }
  }
}
</script>
