<template>
  <div class="h-screen bg-white flex items-center justify-center px-4">
    <LoginForm />
  </div>
</template>

<script setup lang="ts">
import LoginForm from '~/components/LoginForm.vue'

definePageMeta({ layout: false })
</script>
