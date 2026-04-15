<template>
  <div class="h-screen bg-gray-950 flex items-center justify-center px-4">
    <LoginForm />
  </div>
</template>

<script setup lang="ts">
import LoginForm from '~/components/LoginForm.vue'

definePageMeta({ layout: false })
</script>
