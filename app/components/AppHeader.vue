<template>
  <header class="h-16 bg-gradient-to-r from-orange-600 to-orange-400 flex items-center justify-between px-6 shrink-0">
    <!-- Logo -->
    <div class="flex items-center gap-2">
      <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" stroke-width="1.75" viewBox="0 0 24 24" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" d="M12 2C8.5 2 5 5.5 5 9.5c0 3 1.7 5.6 4.3 6.9L11 21h2l1.7-4.6C17.3 15.1 19 12.5 19 9.5 19 5.5 15.5 2 12 2zm0 0v10"/></svg>
      <span class="text-xl font-bold text-white">PetFlow</span>
    </div>

    <!-- Ações -->
    <div class="flex items-center gap-3">
      <span class="text-sm text-orange-100 hidden sm:block">Olá, {{ displayName }}</span>
      <div class="w-9 h-9 rounded-full bg-white flex items-center justify-center text-orange-500 font-semibold text-sm select-none">
        {{ initials }}
      </div>
      <button
        type="button"
        class="flex items-center gap-1.5 text-sm text-orange-100 hover:text-white transition-colors px-3 py-1.5 rounded-lg hover:bg-orange-700"
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
import { createSupabaseClient } from '~/lib/supabase'

defineOptions({ name: 'AppHeader' })

const router = useRouter()
const { logout } = useAuth()
const supabase = createSupabaseClient()

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

