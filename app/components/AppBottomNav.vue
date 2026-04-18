<template>
  <nav class="fixed bottom-0 inset-x-0 z-40 md:hidden bg-white border-t border-pink-100 flex items-stretch h-16 shadow-2xl">
    <NuxtLink
      v-for="item in navItems"
      :key="item.to"
      :to="item.to"
      exact-active-class="text-pink-600 bg-pink-100"
      class="flex-1 flex flex-col items-center justify-center gap-0.5 text-gray-400 hover:text-pink-700 hover:bg-pink-50 transition-colors text-[10px] font-semibold"
    >
      <AppNavIcon :name="item.icon" class="w-5 h-5" />
      <span>{{ item.label }}</span>
    </NuxtLink>
  </nav>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useAdmin } from '~/composables/useAdmin'
import AppNavIcon from '~/components/AppNavIcon.vue'

defineOptions({ name: 'AppBottomNav' })

const { isAdminOrGerente } = useAdmin()

const allNavItems = [
  { to: '/',              icon: 'home',           label: 'Início',        minPerfil: 'all' },
  { to: '/agendamentos',  icon: 'calendar',       label: 'Agenda',        minPerfil: 'all' },
  { to: '/servicos',      icon: 'sparkles',       label: 'Serviços',      minPerfil: 'all' },
  { to: '/clientes',      icon: 'identification', label: 'Clientes',      minPerfil: 'all' },
  { to: '/estoque',       icon: 'package',        label: 'Estoque',       minPerfil: 'all' },
  { to: '/funcionarios',  icon: 'users',          label: 'Equipe',        minPerfil: 'manager' },
  { to: '/contas-pagar',  icon: 'wallet',         label: 'Contas',        minPerfil: 'manager' },
  { to: '/configuracoes', icon: 'settings',       label: 'Config',        minPerfil: 'manager' },
]

const navItems = computed(() =>
  allNavItems.filter(item => item.minPerfil === 'all' || isAdminOrGerente.value)
)
</script>
