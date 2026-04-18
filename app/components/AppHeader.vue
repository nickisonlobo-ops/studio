<template>
  <header class="border-b flex items-center justify-between px-6 shrink-0 shadow-lg" :class="headerHeight" :style="{ background: 'var(--color-sidebar, #ffffff)', borderColor: 'var(--color-primary-border, rgba(236,72,153,0.3))' }">
    <!-- Logo -->
    <div class="flex items-center gap-2.5">
      <div
        v-if="!config.logo_url"
        class="w-8 h-8 rounded-xl flex items-center justify-center shadow-md"
        :style="{ background: 'var(--color-primary, #ec4899)' }"
      >
        <svg class="w-[18px] h-[18px]" fill="none" stroke="currentColor" stroke-width="1.75" viewBox="0 0 24 24" aria-hidden="true" :style="{ color: 'var(--color-primary-text, #ffffff)' }"><path stroke-linecap="round" stroke-linejoin="round" d="M9.813 15.904L9 18.75l-.813-2.846a4.5 4.5 0 00-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 003.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 003.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 00-3.09 3.09zM18.259 8.715L18 9.75l-.259-1.035a3.375 3.375 0 00-2.455-2.456L14.25 6l1.036-.259a3.375 3.375 0 002.455-2.456L18 2.25l.259 1.035a3.375 3.375 0 002.456 2.456L21.75 6l-1.035.259a3.375 3.375 0 00-2.456 2.456zM16.894 20.567L16.5 21.75l-.394-1.183a2.25 2.25 0 00-1.423-1.423L13.5 18.75l1.183-.394a2.25 2.25 0 001.423-1.423l.394-1.183.394 1.183a2.25 2.25 0 001.423 1.423l1.183.394-1.183.394a2.25 2.25 0 00-1.423 1.423z"/></svg>
      </div>
      <img v-else :src="config.logo_url" alt="Logo" class="object-contain rounded-xl" :class="headerLogoSize" />
      <span class="text-lg font-black text-gray-900 tracking-tight">{{ config.nome_empresa || 'UpStudio' }}</span>
    </div>

    <!-- Ações -->
    <div class="flex items-center gap-3">
      <span class="text-sm text-gray-500 hidden sm:block">Olá, {{ displayName }}</span>
      <div
        class="w-9 h-9 rounded-full flex items-center justify-center font-black text-sm select-none shadow"
        :style="{ background: 'var(--color-primary, #ec4899)', color: 'var(--color-primary-text, #ffffff)' }"
      >
        {{ initials }}
      </div>
      <button
        type="button"
        class="flex items-center gap-1.5 text-sm text-gray-500 hover:text-gray-800 transition-colors px-3 py-1.5 rounded-lg hover:bg-black/5"
        @click="handleLogout"
      >
        <span>Sair</span>
        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6a2.25 2.25 0 00-2.25 2.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15m3 0l3-3m0 0l-3-3m3 3H9"/></svg>
      </button>
    </div>
  </header>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuth } from '~/composables/useAuth'
import { usePersonalizacao } from '~/composables/usePersonalizacao'
import { createSupabaseClient } from '~/lib/supabase'

defineOptions({ name: 'AppHeader' })

const router = useRouter()
const { logout } = useAuth()
const supabase = createSupabaseClient()
const { config } = usePersonalizacao()

const headerLogoSize = computed(() => {
  switch (config.value.logo_size) {
    case 'sm': return 'w-7 h-7'
    case 'lg': return 'w-11 h-11'
    case 'xl': return 'w-14 h-14'
    default:   return 'w-8 h-8'
  }
})

const headerHeight = computed(() => {
  if (!config.value.logo_url) return 'h-16'
  switch (config.value.logo_size) {
    case 'sm': return 'h-14'
    case 'lg': return 'h-[4.5rem]'
    case 'xl': return 'h-20'
    default:   return 'h-16'
  }
})

const userName = ref('')

onMounted(async () => {
  const { data: { user } } = await supabase.auth.getUser()
  userName.value = user?.user_metadata?.full_name ?? user?.email ?? ''
})

const displayName = computed(() => {
  if (!userName.value) return ''
  return userName.value.split('@')[0]
})

const initials = computed(() => {
  const name = userName.value
  if (!name) return 'U'
  const parts = name.split(' ').filter(Boolean)
  if (parts.length >= 2) return ((parts[0]?.[0] ?? '') + (parts[1]?.[0] ?? '')).toUpperCase()
  return (name[0] ?? 'U').toUpperCase()
})

async function handleLogout() {
  await logout()
  await router.push('/login')
}
</script>

