<template>
  <div v-if="config.logo_url" class="absolute top-4 right-4 sm:top-5 sm:right-6 z-10">
    <img
      :src="config.logo_url"
      alt="Logo"
      class="object-contain rounded-xl bg-white/15 backdrop-blur-sm border border-white/20 shadow-lg p-1"
      :class="sizeClass"
    />
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { usePersonalizacao } from '~/composables/usePersonalizacao'
const { config } = usePersonalizacao()

const sizeClass = computed(() => {
  switch (config.value.logo_size) {
    case 'sm': return 'w-7 h-7 sm:w-8 sm:h-8'
    case 'lg': return 'w-12 h-12 sm:w-14 sm:h-14'
    case 'xl': return 'w-16 h-16 sm:w-20 sm:h-20'
    default:   return 'w-8 h-8 sm:w-10 sm:h-10'
  }
})
</script>
