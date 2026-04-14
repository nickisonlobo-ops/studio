<template>
  <aside
    class="shrink-0 bg-gradient-to-b from-green-900 via-green-700 to-green-600 flex flex-col min-h-0 overflow-hidden transition-all duration-300 ease-in-out"
    :class="expanded ? 'w-64' : 'w-16'"
    @mouseenter="expanded = true"
    @mouseleave="expanded = false"
  >
    <!-- Marca lateral -->
    <div class="px-4 py-5 border-b border-green-600 flex items-center gap-3 overflow-hidden">
      <AppNavIcon name="leaf" class="w-5 h-5 text-green-300 shrink-0" />
      <p
        class="text-xs font-semibold uppercase tracking-widest text-green-200 whitespace-nowrap transition-opacity duration-200"
        :class="expanded ? 'opacity-100' : 'opacity-0'"
      >
        Menu
      </p>
    </div>

    <!-- Links -->
    <nav class="flex-1 px-2 py-4 flex flex-col gap-3 overflow-y-auto overflow-x-hidden">
      <div v-for="section in navSections" :key="section.title" class="flex flex-col gap-1">
        <p
          class="px-3 text-[10px] font-semibold uppercase tracking-widest text-green-200/80 whitespace-nowrap transition-opacity duration-200"
          :class="expanded ? 'opacity-100' : 'opacity-0 h-0 overflow-hidden'"
        >
          {{ section.title }}
        </p>
        <NuxtLink
          v-for="item in section.items"
          :key="item.to"
          :to="item.to"
          class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-white hover:bg-green-600 transition-colors overflow-hidden"
          active-class="bg-green-800 text-white"
        >
          <AppNavIcon :name="item.icon" class="w-5 h-5 shrink-0" />
          <span
            class="whitespace-nowrap transition-opacity duration-200"
            :class="expanded ? 'opacity-100' : 'opacity-0'"
          >
            {{ item.label }}
          </span>
        </NuxtLink>
      </div>
    </nav>

    <!-- Rodapé da sidebar -->
    <div class="px-4 py-4 border-t border-green-600 overflow-hidden">
      <p
        class="text-xs text-green-300 whitespace-nowrap transition-opacity duration-200"
        :class="expanded ? 'opacity-100' : 'opacity-0'"
      >
        v1.0.0
      </p>
    </div>
  </aside>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useAdmin } from '~/composables/useAdmin'
import AppNavIcon from '~/components/AppNavIcon.vue'

defineOptions({ name: 'AppSidebar' })

const expanded = ref(false)
const { isAdmin } = useAdmin()

const allNavSections = [
  {
    title: 'Geral',
    items: [
      { to: '/', icon: 'home', label: 'Início', adminOnly: false },
    ],
  },
  {
    title: 'Comercial',
    items: [
      { to: '/clientes', icon: 'identification', label: 'Clientes', adminOnly: false },
      { to: '/vendas', icon: 'receipt', label: 'Vendas', adminOnly: false },
    ],
  },
  {
    title: 'Operação',
    items: [
      { to: '/produtos', icon: 'package', label: 'Produtos', adminOnly: false },
      { to: '/funcionarios', icon: 'users', label: 'Funcionários', adminOnly: true },
      { to: '/atividades', icon: 'clipboard', label: 'Atividades', adminOnly: true },
    ],
  },
  {
    title: 'Financeiro',
    items: [
      { to: '/contas-pagar', icon: 'wallet', label: 'Contas a Pagar', adminOnly: true },
    ],
  },
]

const navSections = computed(() =>
  allNavSections
    .map(section => ({
      ...section,
      items: section.items.filter(item => !item.adminOnly || isAdmin.value),
    }))
    .filter(section => section.items.length > 0)
)
</script>
