<template>
  <nav class="fixed bottom-0 inset-x-0 z-40 md:hidden bg-green-900 border-t border-green-700 flex items-stretch h-16 shadow-2xl">
    <NuxtLink
      v-for="item in navItems"
      :key="item.to"
      :to="item.to"
      exact-active-class="text-white bg-green-800"
      class="flex-1 flex flex-col items-center justify-center gap-0.5 text-green-300 hover:text-white hover:bg-green-800 transition-colors text-[10px] font-semibold"
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

const { isAdmin } = useAdmin()

const allNavItems = [
  { to: '/',             icon: 'home',    label: 'Início',       adminOnly: false },
  { to: '/clientes',     icon: 'identification', label: 'Clientes',     adminOnly: false },
  { to: '/produtos',     icon: 'package',        label: 'Produtos',     adminOnly: false },
  { to: '/funcionarios', icon: 'users',   label: 'Funcionários', adminOnly: true  },
  { to: '/atividades',   icon: 'clipboard', label: 'Atividades',   adminOnly: true  },
  { to: '/contas-pagar', icon: 'wallet',  label: 'Contas',       adminOnly: true  },
  { to: '/vendas',       icon: 'receipt',        label: 'Vendas',       adminOnly: false },
]

const navItems = computed(() =>
  allNavItems.filter(item => !item.adminOnly || isAdmin.value)
)
</script>
