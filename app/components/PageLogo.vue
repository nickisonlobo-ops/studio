<template>
  <div v-if="config.logo_url" class="absolute top-4 right-4 sm:top-5 sm:right-6 z-10">
    <img
      :src="config.logo_url"
      alt="Logo"
      class="object-contain rounded-xl bg-white/15 backdrop-blur-sm border border-white/20 shadow-lg p-1"
      :style="{ width: logoSizePx + 'px', height: logoSizePx + 'px' }"
    />
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { usePersonalizacao } from '~/composables/usePersonalizacao'
const { config } = usePersonalizacao()

const logoSizePx = computed(() => {
  const s = config.value.logo_size
  const num = parseInt(s)
  if (!isNaN(num)) return num
  switch (s) {
    case 'sm':  return 28
    case 'lg':  return 44
    case 'xl':  return 56
    case '2xl': return 72
    default:    return 32
  }
})
</script>
