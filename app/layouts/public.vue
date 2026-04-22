<template>
  <div class="min-h-screen bg-gray-50 flex flex-col">
    <!-- Barra superior simples -->
    <header class="px-4 sm:px-8 py-3 flex items-center gap-3 shadow-sm" :style="{ background: 'var(--color-primary-bg, #6b7280)' }">
      <span class="text-sm font-black uppercase tracking-widest" :style="{ color: 'var(--color-primary-text, #ffffff)' }">{{ nomeEmpresa }}</span>
    </header>

    <main class="flex-1 p-3 sm:p-8">
      <slot />
    </main>

    <footer class="text-center text-xs text-gray-400 py-6 border-t border-gray-200">
      {{ nomeEmpresa }}
    </footer>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { usePersonalizacao } from '~/composables/usePersonalizacao'

const route = useRoute()
const { config: tema, loadPersonalizacaoPublic } = usePersonalizacao()

const nomeEmpresa = computed(() => tema.value.nome_empresa || '')

onMounted(async () => {
  // Suporta ?e=1 (loja/catálogo) e /agendar/[empresa_id] (parâmetro de rota)
  const eId = Number(route.params.empresa_id ?? route.query.e ?? 0)
  if (eId) {
    await loadPersonalizacaoPublic(eId)
  }
})
</script>
