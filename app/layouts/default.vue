<template>
  <div class="flex flex-col h-screen overflow-hidden" :style="{ background: 'var(--color-bg, #f9fafb)' }">
    <AppHeader />

    <div class="flex flex-1 min-h-0">
      <AppSidebar class="hidden md:flex" />

      <main class="flex-1 overflow-y-auto p-3 sm:p-6 pb-20 md:pb-6">
        <slot />
      </main>
    </div>

    <AppBottomNav />
  </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue'
import AppHeader from '~/components/AppHeader.vue'
import AppSidebar from '~/components/AppSidebar.vue'
import AppBottomNav from '~/components/AppBottomNav.vue'
import { usePersonalizacao } from '~/composables/usePersonalizacao'

const { loadPersonalizacao } = usePersonalizacao()

onMounted(async () => {
  await loadPersonalizacao()
})
</script>
