<template>
  <div class="flex flex-col gap-1.5 w-full">
    <label
      v-if="label"
      :for="inputId"
      class="text-sm font-medium text-white"
    >
      {{ label }}
      <span v-if="required" class="text-error ml-0.5">*</span>
    </label>

    <div class="relative">
      <span v-if="$slots.leading" class="absolute left-3 top-1/2 -translate-y-1/2 text-content-muted">
        <slot name="leading" />
      </span>

      <input
        :id="inputId"
        v-bind="$attrs"
        :type="type"
        :value="modelValue"
        :placeholder="placeholder"
        :disabled="disabled"
        :required="required"
        :class="[
          baseClasses,
          stateClasses,
          $slots.leading ? 'pl-10' : '',
          $slots.trailing ? 'pr-10' : '',
        ]"
        @input="$emit('update:modelValue', ($event.target as HTMLInputElement).value)"
      />

      <span v-if="$slots.trailing" class="absolute right-3 top-1/2 -translate-y-1/2 text-content-muted">
        <slot name="trailing" />
      </span>
    </div>

    <p v-if="hint && !error" class="text-xs text-content-muted">{{ hint }}</p>
    <p v-if="error" class="text-xs text-error">{{ error }}</p>
  </div>
</template>

<script setup lang="ts">
import { computed, useId } from 'vue'

defineOptions({ name: 'AppInput', inheritAttrs: false })

const props = withDefaults(
  defineProps<{
    modelValue?: string | number
    label?: string
    placeholder?: string
    hint?: string
    error?: string
    type?: string
    disabled?: boolean
    required?: boolean
  }>(),
  {
    modelValue: '',
    type: 'text',
    disabled: false,
    required: false,
  }
)

defineEmits<{
  (e: 'update:modelValue', value: string): void
}>()

const inputId = useId()

const baseClasses = 'w-full rounded-xl border bg-bg-surface px-4 py-2.5 text-base text-content placeholder:text-content-muted transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-offset-1 disabled:opacity-60 disabled:cursor-not-allowed'

const stateClasses = computed(() =>
  props.error
    ? 'border-error focus:ring-error'
    : 'border-border focus:border-primary focus:ring-primary'
)
</script>
