<template>
  <aside
    class="shrink-0 border-r flex flex-col min-h-0 overflow-hidden transition-all duration-300 ease-in-out"
    :class="expanded ? 'w-64' : 'w-16'"
    :style="{ background: 'var(--color-sidebar, #ffffff)', borderColor: 'var(--color-primary-border, rgba(236,72,153,0.3))' }"
    @mouseenter="expanded = true"
    @mouseleave="expanded = false"
  >
    <!-- Marca lateral -->
    <div class="px-4 py-5 border-b flex items-center gap-3 overflow-hidden" :style="{ borderColor: 'var(--color-primary-border, rgba(236,72,153,0.3))' }">
      <div class="w-7 h-7 rounded-lg flex items-center justify-center shrink-0" :style="{ background: 'var(--color-primary, #ec4899)' }">
        <img v-if="config.logo_url" :src="config.logo_url" alt="Logo" class="w-5 h-5 object-contain rounded" />
        <AppNavIcon v-else name="sparkles" class="w-4 h-4" :style="{ color: 'var(--color-primary-text, #ffffff)' }" />
      </div>
      <p
        class="text-xs font-black uppercase tracking-widest whitespace-nowrap transition-opacity duration-200"
        :class="expanded ? 'opacity-100' : 'opacity-0'"
        :style="{ color: 'var(--color-primary, #ec4899)' }"
      >
        {{ config.nome_empresa || 'UpStudio' }}
      </p>
    </div>

    <!-- Links -->
    <nav class="flex-1 px-2 py-4 flex flex-col gap-3 overflow-y-auto overflow-x-hidden">
      <div v-for="section in navSections" :key="section.title" class="flex flex-col gap-1">
        <p
          class="px-3 text-[10px] font-semibold uppercase tracking-widest text-gray-400 whitespace-nowrap transition-opacity duration-200"
          :class="expanded ? 'opacity-100' : 'opacity-0 h-0 overflow-hidden'"
        >
          {{ section.title }}
        </p>
        <NuxtLink
          v-for="item in section.items"
          :key="item.to"
          :to="item.to"
          class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 transition-colors overflow-hidden nav-link"
          active-class="nav-link-active"
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
    <div class="px-4 py-4 border-t overflow-hidden" :style="{ borderColor: 'var(--color-primary-border, rgba(236,72,153,0.3))' }">
      <p
        class="text-xs text-gray-400 whitespace-nowrap transition-opacity duration-200"
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
import { usePersonalizacao } from '~/composables/usePersonalizacao'
import AppNavIcon from '~/components/AppNavIcon.vue'

defineOptions({ name: 'AppSidebar' })

const expanded = ref(false)
const { isAdminOrGerente } = useAdmin()
const { config } = usePersonalizacao()

const allNavSections = [
  {
    title: 'Geral',
    items: [
      { to: '/', icon: 'home', label: 'Início', minPerfil: 'all' },
    ],
  },
  {
    title: 'Studio',
    items: [
      { to: '/agendamentos', icon: 'calendar', label: 'Agendamentos', minPerfil: 'all' },
      { to: '/servicos', icon: 'sparkles', label: 'Serviços', minPerfil: 'all' },
      { to: '/clientes', icon: 'identification', label: 'Clientes', minPerfil: 'all' },
      { to: '/estoque', icon: 'package', label: 'Estoque', minPerfil: 'all' },
    ],
  },
  {
    title: 'Operação',
    items: [
      { to: '/funcionarios', icon: 'users', label: 'Funcionários', minPerfil: 'manager' },
      { to: '/atividades', icon: 'clipboard', label: 'Atividades', minPerfil: 'all' },
    ],
  },
  {
    title: 'Financeiro',
    items: [
      { to: '/contas-pagar', icon: 'wallet', label: 'Contas a Pagar', minPerfil: 'manager' },
    ],
  },
  {
    title: 'Sistema',
    items: [
      { to: '/configuracoes', icon: 'settings', label: 'Configurações', minPerfil: 'manager' },
    ],
  },
]

const navSections = computed(() =>
  allNavSections
    .map(section => ({
      ...section,
      items: section.items.filter(item => item.minPerfil === 'all' || isAdminOrGerente.value),
    }))
    .filter(section => section.items.length > 0)
)
</script>

<style scoped>
.nav-link:hover {
  background: var(--color-primary-light, rgba(236,72,153,0.12));
  color: var(--color-primary, #ec4899);
}
.nav-link-active {
  background: var(--color-primary-light, rgba(236,72,153,0.12)) !important;
  color: var(--color-primary, #ec4899) !important;
  border: 1px solid var(--color-primary-border, rgba(236,72,153,0.3));
}
</style>

