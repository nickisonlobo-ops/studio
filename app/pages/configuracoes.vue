<template>
  <div class="max-w-3xl mx-auto space-y-8">
    <!-- Cabeçalho -->
    <div>
      <h1 class="text-2xl font-black text-gray-900">Personalização</h1>
      <p class="text-sm text-gray-500 mt-1">Customize as cores, logo e nome da sua empresa no sistema.</p>
    </div>

    <!-- Alerta de erro -->
    <div v-if="error" class="bg-red-50 border border-red-200 rounded-xl p-4 text-sm text-red-700">
      {{ error }}
    </div>

    <!-- Loading inicial -->
    <div v-if="loading" class="flex items-center justify-center py-20">
      <svg class="animate-spin w-8 h-8 text-[var(--color-primary)]" fill="none" viewBox="0 0 24 24">
        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8H4z"/>
      </svg>
    </div>

    <template v-else>
      <!-- Logo da Empresa -->
      <section class="bg-white rounded-2xl border border-pink-100 shadow-sm p-6 space-y-4">
        <h2 class="text-base font-bold text-gray-800">Logo da Empresa</h2>

        <div class="flex flex-col sm:flex-row gap-6 items-start sm:items-center">
          <!-- Preview do logo -->
          <div class="w-24 h-24 rounded-2xl border-2 border-dashed border-pink-200 bg-pink-50 flex items-center justify-center overflow-hidden shrink-0">
            <img v-if="form.logo_url" :src="form.logo_url" alt="Logo" class="w-full h-full object-contain p-2" />
            <svg v-else class="w-10 h-10 text-pink-300" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 15.75l5.159-5.159a2.25 2.25 0 013.182 0l5.159 5.159m-1.5-1.5l1.409-1.409a2.25 2.25 0 013.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 001.5-1.5V6a1.5 1.5 0 00-1.5-1.5H3.75A1.5 1.5 0 002.25 6v12a1.5 1.5 0 001.5 1.5zm10.5-11.25h.008v.008h-.008V8.25zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
            </svg>
          </div>

          <!-- Ações -->
          <div class="flex flex-col gap-3">
            <label class="cursor-pointer">
              <span
                class="inline-flex items-center gap-2 px-4 py-2 rounded-xl text-sm font-semibold border-2 transition-colors"
                :class="uploadingLogo ? 'opacity-60 cursor-not-allowed bg-gray-50 border-gray-200 text-gray-400' : 'bg-white border-pink-200 text-pink-700 hover:bg-pink-50'"
              >
                <svg v-if="uploadingLogo" class="animate-spin w-4 h-4" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8H4z"/>
                </svg>
                <svg v-else class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75V16.5m-13.5-9L12 3m0 0l4.5 4.5M12 3v13.5" />
                </svg>
                {{ uploadingLogo ? 'Enviando…' : 'Enviar logo' }}
              </span>
              <input
                type="file"
                accept="image/png,image/jpeg,image/webp,image/svg+xml"
                class="hidden"
                :disabled="uploadingLogo"
                @change="handleLogoUpload"
              />
            </label>
            <button
              v-if="form.logo_url"
              type="button"
              class="text-sm text-gray-400 hover:text-red-500 transition-colors text-left"
              @click="handleRemoveLogo"
            >
              Remover logo
            </button>
            <p class="text-xs text-gray-400">PNG, JPG, WebP ou SVG. Máximo 2MB.</p>
          </div>
        </div>

        <!-- Tamanho do logo -->
        <div v-if="form.logo_url" class="space-y-2 pt-2 border-t border-gray-100">
          <label class="text-sm font-medium text-gray-700">Tamanho do logo nas páginas</label>
          <div class="flex flex-wrap gap-2">
            <button
              v-for="size in logoSizes"
              :key="size.value"
              type="button"
              class="px-4 py-2 rounded-xl text-sm font-medium border-2 transition-all"
              :class="form.logo_size === size.value ? 'border-gray-800 bg-gray-100' : 'border-gray-200 hover:border-gray-300'"
              @click="form.logo_size = size.value"
            >
              {{ size.label }}
            </button>
          </div>
        </div>
      </section>

      <!-- Nome da empresa -->
      <section class="bg-white rounded-2xl border border-pink-100 shadow-sm p-6 space-y-4">
        <h2 class="text-base font-bold text-gray-800">Nome Exibido</h2>
        <div class="space-y-1">
          <label class="text-sm font-medium text-gray-700">Nome da empresa no sistema</label>
          <input
            v-model="form.nome_empresa"
            type="text"
            maxlength="60"
            class="w-full max-w-sm border border-pink-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-pink-300"
            placeholder="UpStudio"
          />
        </div>
      </section>

      <!-- Cores -->
      <section class="bg-white rounded-2xl border border-pink-100 shadow-sm p-6 space-y-6">
        <h2 class="text-base font-bold text-gray-800">Esquema de Cores</h2>

        <!-- Temas pré-definidos -->
        <div class="space-y-4">
          <p class="text-sm font-medium text-gray-600">Temas prontos</p>
          <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-3">
            <button
              v-for="tema in temasProntos"
              :key="tema.nome"
              type="button"
              class="group relative rounded-xl border-2 overflow-hidden transition-all text-left"
              :class="isTemaSelecionado(tema) ? 'border-gray-800 shadow-lg ring-1 ring-gray-800/20' : 'border-gray-200 hover:border-gray-300 hover:shadow-md'"
              @click="aplicarTema(tema)"
            >
              <!-- Mini preview -->
              <div class="h-8 w-full" :style="{ background: tema.cor_primaria_grad ? `linear-gradient(90deg, ${tema.cor_primaria}, ${tema.cor_primaria_grad})` : tema.cor_primaria }" />
              <div class="p-2.5 space-y-1.5" :style="{ background: tema.cor_fundo }">
                <div class="flex gap-1.5">
                  <div class="w-8 h-5 rounded" :style="{ background: tema.cor_sidebar_grad ? `linear-gradient(135deg, ${tema.cor_sidebar}, ${tema.cor_sidebar_grad})` : tema.cor_sidebar, border: '1px solid rgba(0,0,0,0.06)' }" />
                  <div class="flex-1 h-5 rounded" :style="{ background: tema.cor_card_grad ? `linear-gradient(135deg, ${tema.cor_card}, ${tema.cor_card_grad})` : tema.cor_card, border: '1px solid rgba(0,0,0,0.06)' }" />
                </div>
                <p class="text-[10px] font-bold truncate" :style="{ color: tema.cor_card_texto }">{{ tema.nome }}</p>
              </div>
              <div v-if="isTemaSelecionado(tema)" class="absolute top-1.5 right-1.5 w-4 h-4 rounded-full bg-white shadow flex items-center justify-center">
                <svg class="w-2.5 h-2.5 text-gray-800" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" /></svg>
              </div>
            </button>
          </div>
        </div>

        <div class="border-t border-gray-100 pt-4 grid grid-cols-1 sm:grid-cols-2 gap-5">
          <!-- Cor primária -->
          <div class="space-y-2">
            <label class="text-sm font-medium text-gray-700">Cor principal</label>
            <p class="text-xs text-gray-400">Botões, links ativos e destaques</p>
            <div class="flex items-center gap-2 mt-2 flex-wrap">
              <input v-model="form.cor_primaria" type="color" class="w-12 h-10 rounded-lg border border-gray-200 cursor-pointer p-0.5" />
              <input v-model="form.cor_primaria" type="text" class="w-24 border border-gray-200 rounded-lg px-3 py-2 text-sm font-mono focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="7" @input="sanitizeHex('cor_primaria')" />
              <!-- Degradê -->
              <label class="flex items-center gap-1.5 text-xs text-gray-500 cursor-pointer select-none">
                <input v-model="usarGradPrimaria" type="checkbox" class="rounded" />
                Degradê
              </label>
              <template v-if="usarGradPrimaria">
                <input v-model="form.cor_primaria_grad" type="color" class="w-10 h-10 rounded-lg border border-gray-200 cursor-pointer p-0.5" />
                <input v-model="form.cor_primaria_grad" type="text" class="w-24 border border-gray-200 rounded-lg px-3 py-2 text-sm font-mono focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="7" @input="sanitizeHex('cor_primaria_grad')" />
                <div class="h-5 w-20 rounded-full border border-gray-200" :style="{ background: `linear-gradient(90deg, ${form.cor_primaria}, ${form.cor_primaria_grad ?? form.cor_primaria})` }" />
              </template>
            </div>
          </div>

          <!-- Cor do texto sobre primária -->
          <div class="space-y-2">
            <label class="text-sm font-medium text-gray-700">Texto sobre cor principal</label>
            <p class="text-xs text-gray-400">Texto em botões e badges coloridos</p>
            <div class="flex items-center gap-2 mt-2">
              <input v-model="form.cor_primaria_texto" type="color" class="w-12 h-10 rounded-lg border border-gray-200 cursor-pointer p-0.5" />
              <input v-model="form.cor_primaria_texto" type="text" class="w-28 border border-gray-200 rounded-lg px-3 py-2 text-sm font-mono focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="7" @input="sanitizeHex('cor_primaria_texto')" />
            </div>
          </div>

          <!-- Cor de fundo -->
          <div class="space-y-2">
            <label class="text-sm font-medium text-gray-700">Cor de fundo</label>
            <p class="text-xs text-gray-400">Background geral do sistema</p>
            <div class="flex items-center gap-2 mt-2 flex-wrap">
              <input v-model="form.cor_fundo" type="color" class="w-12 h-10 rounded-lg border border-gray-200 cursor-pointer p-0.5" />
              <input v-model="form.cor_fundo" type="text" class="w-24 border border-gray-200 rounded-lg px-3 py-2 text-sm font-mono focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="7" @input="sanitizeHex('cor_fundo')" />
              <label class="flex items-center gap-1.5 text-xs text-gray-500 cursor-pointer select-none">
                <input v-model="usarGradFundo" type="checkbox" class="rounded" />
                Degradê
              </label>
              <template v-if="usarGradFundo">
                <input v-model="form.cor_fundo_grad" type="color" class="w-10 h-10 rounded-lg border border-gray-200 cursor-pointer p-0.5" />
                <input v-model="form.cor_fundo_grad" type="text" class="w-24 border border-gray-200 rounded-lg px-3 py-2 text-sm font-mono focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="7" @input="sanitizeHex('cor_fundo_grad')" />
                <div class="h-5 w-20 rounded-full border border-gray-200" :style="{ background: `linear-gradient(90deg, ${form.cor_fundo}, ${form.cor_fundo_grad ?? form.cor_fundo})` }" />
              </template>
            </div>
          </div>

          <!-- Cor da sidebar -->
          <div class="space-y-2">
            <label class="text-sm font-medium text-gray-700">Cor da sidebar / header</label>
            <p class="text-xs text-gray-400">Fundo do menu lateral e cabeçalho</p>
            <div class="flex items-center gap-2 mt-2 flex-wrap">
              <input v-model="form.cor_sidebar" type="color" class="w-12 h-10 rounded-lg border border-gray-200 cursor-pointer p-0.5" />
              <input v-model="form.cor_sidebar" type="text" class="w-24 border border-gray-200 rounded-lg px-3 py-2 text-sm font-mono focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="7" @input="sanitizeHex('cor_sidebar')" />
              <label class="flex items-center gap-1.5 text-xs text-gray-500 cursor-pointer select-none">
                <input v-model="usarGradSidebar" type="checkbox" class="rounded" />
                Degradê
              </label>
              <template v-if="usarGradSidebar">
                <input v-model="form.cor_sidebar_grad" type="color" class="w-10 h-10 rounded-lg border border-gray-200 cursor-pointer p-0.5" />
                <input v-model="form.cor_sidebar_grad" type="text" class="w-24 border border-gray-200 rounded-lg px-3 py-2 text-sm font-mono focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="7" @input="sanitizeHex('cor_sidebar_grad')" />
                <div class="h-5 w-20 rounded-full border border-gray-200" :style="{ background: `linear-gradient(90deg, ${form.cor_sidebar}, ${form.cor_sidebar_grad ?? form.cor_sidebar})` }" />
              </template>
            </div>
          </div>

          <!-- Cor do card -->
          <div class="space-y-2">
            <label class="text-sm font-medium text-gray-700">Cor do card</label>
            <p class="text-xs text-gray-400">Fundo das tabelas, listas e painéis</p>
            <div class="flex items-center gap-2 mt-2 flex-wrap">
              <input v-model="form.cor_card" type="color" class="w-12 h-10 rounded-lg border border-gray-200 cursor-pointer p-0.5" />
              <input v-model="form.cor_card" type="text" class="w-24 border border-gray-200 rounded-lg px-3 py-2 text-sm font-mono focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="7" @input="sanitizeHex('cor_card')" />
              <label class="flex items-center gap-1.5 text-xs text-gray-500 cursor-pointer select-none">
                <input v-model="usarGradCard" type="checkbox" class="rounded" />
                Degradê
              </label>
              <template v-if="usarGradCard">
                <input v-model="form.cor_card_grad" type="color" class="w-10 h-10 rounded-lg border border-gray-200 cursor-pointer p-0.5" />
                <input v-model="form.cor_card_grad" type="text" class="w-24 border border-gray-200 rounded-lg px-3 py-2 text-sm font-mono focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="7" @input="sanitizeHex('cor_card_grad')" />
                <div class="h-5 w-20 rounded-full border border-gray-200" :style="{ background: `linear-gradient(90deg, ${form.cor_card}, ${form.cor_card_grad ?? form.cor_card})` }" />
              </template>
            </div>
          </div>

          <!-- Cor do texto do card -->
          <div class="space-y-2">
            <label class="text-sm font-medium text-gray-700">Texto dos cards</label>
            <p class="text-xs text-gray-400">Cor dos textos dentro de tabelas e painéis</p>
            <div class="flex items-center gap-2 mt-2">
              <input v-model="form.cor_card_texto" type="color" class="w-12 h-10 rounded-lg border border-gray-200 cursor-pointer p-0.5" />
              <input v-model="form.cor_card_texto" type="text" class="w-28 border border-gray-200 rounded-lg px-3 py-2 text-sm font-mono focus:outline-none focus:ring-2 focus:ring-pink-300" maxlength="7" @input="sanitizeHex('cor_card_texto')" />
            </div>
          </div>
        </div>

        <!-- Direção do degradê -->
        <div v-if="usarGradPrimaria || usarGradFundo || usarGradSidebar || usarGradCard" class="border-t border-gray-100 pt-4 space-y-2">
          <label class="text-sm font-medium text-gray-700">Direção do degradê</label>
          <div class="flex flex-wrap gap-2">
            <button
              v-for="dir in direcoes"
              :key="dir.value"
              type="button"
              class="px-3 py-1.5 rounded-lg text-xs font-medium border-2 transition-all"
              :class="form.grad_direction === dir.value ? 'border-gray-800 bg-gray-100' : 'border-gray-200 hover:border-gray-300'"
              @click="form.grad_direction = dir.value"
            >
              {{ dir.label }}
            </button>
          </div>
        </div>
      </section>

      <!-- Preview -->
      <section class="bg-white rounded-2xl border border-pink-100 shadow-sm p-6 space-y-4">
        <h2 class="text-base font-bold text-gray-800">Preview</h2>
        <div class="rounded-xl overflow-hidden border border-gray-200 shadow-md">
          <!-- Mini header -->
          <div class="h-10 flex items-center justify-between px-4" :style="{ background: previewSidebarBg }">
            <div class="flex items-center gap-2">
              <img v-if="form.logo_url" :src="form.logo_url" class="w-5 h-5 object-contain rounded" alt="Logo" />
              <div v-else class="w-5 h-5 rounded-md flex items-center justify-center" :style="{ background: previewPrimaryBg }">
                <svg class="w-3 h-3" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" :style="{ color: form.cor_primaria_texto }">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M9.813 15.904L9 18.75l-.813-2.846a4.5 4.5 0 00-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 003.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 003.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 00-3.09 3.09z" />
                </svg>
              </div>
              <span class="text-xs font-bold" :style="{ color: form.cor_card_texto }">{{ form.nome_empresa || 'UpStudio' }}</span>
            </div>
            <div class="w-6 h-6 rounded-full flex items-center justify-center text-[10px] font-black" :style="{ background: previewPrimaryBg, color: form.cor_primaria_texto }">A</div>
          </div>

          <!-- Mini conteúdo -->
          <div class="flex" :style="{ background: previewFundoBg }">
            <div class="w-10 shrink-0 flex flex-col items-center py-3 gap-2.5 border-r" :style="{ background: previewSidebarBg, borderColor: 'rgba(128,128,128,0.1)' }">
              <div v-for="i in 4" :key="i" class="w-4 h-4 rounded" :style="{ background: i === 1 ? previewPrimaryBg : 'rgba(128,128,128,0.15)' }" />
            </div>
            <div class="flex-1 p-3 space-y-2.5">
              <!-- Mini banner -->
              <div class="h-7 rounded-lg" :style="{ background: previewPrimaryBg }" />
              <!-- Mini cards -->
              <div class="grid grid-cols-3 gap-2">
                <div v-for="i in 3" :key="i" class="rounded-lg p-2 space-y-1" :style="{ background: previewCardBg, border: '1px solid rgba(128,128,128,0.1)' }">
                  <div class="h-1.5 rounded-full w-10" :style="{ background: 'rgba(128,128,128,0.2)' }" />
                  <div class="h-3 rounded w-8 font-black text-[8px] flex items-center" :style="{ color: form.cor_card_texto }">{{ ['R$ 400', '12', '3'][i-1] }}</div>
                  <div class="h-1 rounded-full w-12" :style="{ background: 'rgba(128,128,128,0.12)' }" />
                </div>
              </div>
              <!-- Mini botões -->
              <div class="flex gap-2">
                <div class="px-3 py-1.5 rounded-lg text-[10px] font-bold" :style="{ background: previewPrimaryBg, color: form.cor_primaria_texto }">Salvar</div>
                <div class="px-3 py-1.5 rounded-lg text-[10px] font-bold" :style="{ background: 'rgba(128,128,128,0.1)', color: form.cor_card_texto }">Cancelar</div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Ações -->
      <div class="flex items-center justify-between pb-6">
        <button
          type="button"
          class="text-sm text-gray-400 hover:text-gray-600 transition-colors underline"
          @click="handleReset"
        >
          Restaurar padrões
        </button>

        <div class="flex items-center gap-3">
          <span v-if="savedFeedback" class="text-sm text-green-600 font-medium">✓ Salvo!</span>
          <button
            type="button"
            :disabled="saving"
            class="flex items-center gap-2 px-6 py-2.5 rounded-xl text-sm font-bold transition-colors disabled:opacity-60"
            :style="{ background: form.cor_primaria, color: form.cor_primaria_texto }"
            @click="handleSave"
          >
            <svg v-if="saving" class="animate-spin w-4 h-4" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8H4z"/>
            </svg>
            {{ saving ? 'Salvando…' : 'Salvar personalização' }}
          </button>
        </div>
      </div>
    </template>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted, watch, nextTick } from 'vue'
import { usePersonalizacao, type PersonalizacaoConfig } from '~/composables/usePersonalizacao'

defineOptions({ name: 'ConfiguracoesPage' })

const { config, loading, saving, uploadingLogo, error, loadPersonalizacao, savePersonalizacao, uploadLogo, applyTheme, DEFAULTS } = usePersonalizacao()

const savedFeedback = ref(false)
const formLoaded = ref(false)

const form = reactive<PersonalizacaoConfig>({ ...DEFAULTS })

// Controles de toggle para degradê
const usarGradPrimaria = ref(false)
const usarGradFundo    = ref(false)
const usarGradSidebar  = ref(false)
const usarGradCard     = ref(false)

const direcoes = [
  { label: '↘ Diagonal', value: '135deg' },
  { label: '→ Direita',  value: '90deg'  },
  { label: '↓ Baixo',    value: '180deg' },
  { label: '↗ Diagonal', value: '45deg'  },
  { label: '← Esquerda', value: '270deg' },
]

const logoSizes = [
  { label: 'Pequeno', value: 'sm' },
  { label: 'Médio',   value: 'md' },
  { label: 'Grande',  value: 'lg' },
  { label: 'Extra G', value: 'xl' },
]

// Computed para preview — usa degradê se ativado
const previewPrimaryBg = computed(() =>
  usarGradPrimaria.value && form.cor_primaria_grad
    ? `linear-gradient(${form.grad_direction}, ${form.cor_primaria}, ${form.cor_primaria_grad})`
    : form.cor_primaria
)
const previewFundoBg = computed(() =>
  usarGradFundo.value && form.cor_fundo_grad
    ? `linear-gradient(${form.grad_direction}, ${form.cor_fundo}, ${form.cor_fundo_grad})`
    : form.cor_fundo
)
const previewSidebarBg = computed(() =>
  usarGradSidebar.value && form.cor_sidebar_grad
    ? `linear-gradient(${form.grad_direction}, ${form.cor_sidebar}, ${form.cor_sidebar_grad})`
    : form.cor_sidebar
)
const previewCardBg = computed(() =>
  usarGradCard.value && form.cor_card_grad
    ? `linear-gradient(${form.grad_direction}, ${form.cor_card}, ${form.cor_card_grad})`
    : form.cor_card
)

const temasProntos = [
  { nome: 'Aurora',       cor_primaria: '#ec4899', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: '#a855f7', cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '135deg' },
  { nome: 'Oceano',       cor_primaria: '#0ea5e9', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: '#6366f1', cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '135deg' },
  { nome: 'Esmeralda',    cor_primaria: '#10b981', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: '#06b6d4', cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '135deg' },
  { nome: 'Sunset',       cor_primaria: '#f43f5e', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: '#f97316', cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '90deg' },
  { nome: 'Lavanda',      cor_primaria: '#8b5cf6', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: '#d946ef', cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '135deg' },
  { nome: 'Dourado',      cor_primaria: '#d97706', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: '#ea580c', cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '135deg' },
  { nome: 'Royal',        cor_primaria: '#4f46e5', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: '#7c3aed', cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '135deg' },
  { nome: 'Coral',        cor_primaria: '#fb7185', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: '#f472b6', cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '135deg' },
  { nome: 'Turquesa',     cor_primaria: '#14b8a6', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: '#0ea5e9', cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '135deg' },
  { nome: 'Cereja',       cor_primaria: '#e11d48', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: '#db2777', cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '135deg' },
  { nome: 'Menta',        cor_primaria: '#34d399', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: '#a3e635', cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '135deg' },
  { nome: 'Safira',       cor_primaria: '#2563eb', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: '#0891b2', cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '135deg' },
  { nome: 'Uva',          cor_primaria: '#7c3aed', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: '#c026d3', cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '135deg' },
  { nome: 'Canela',       cor_primaria: '#b45309', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: '#dc2626', cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '135deg' },
  { nome: 'Petróleo',     cor_primaria: '#0d9488', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: '#4f46e5', cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '135deg' },
  { nome: 'Clean',        cor_primaria: '#3b82f6', cor_primaria_texto: '#ffffff', cor_fundo: '#ffffff', cor_sidebar: '#ffffff', cor_card: '#ffffff', cor_card_texto: '#374151', cor_primaria_grad: null, cor_fundo_grad: null, cor_sidebar_grad: null, cor_card_grad: null, grad_direction: '135deg' },
]

onMounted(async () => {
  loading.value = true
  await loadPersonalizacao(false)
  loading.value = false
  Object.assign(form, config.value)
  // Inicializa toggles com base nos dados salvos
  usarGradPrimaria.value = !!form.cor_primaria_grad
  usarGradFundo.value    = !!form.cor_fundo_grad
  usarGradSidebar.value  = !!form.cor_sidebar_grad
  usarGradCard.value     = !!form.cor_card_grad
  // Só habilita o watcher de preview depois de carregar os dados salvos
  nextTick(() => { formLoaded.value = true })
})

// Limpa campos de gradiente quando toggle é desligado
watch(usarGradPrimaria, (v) => { if (!v) form.cor_primaria_grad = null })
watch(usarGradFundo,    (v) => { if (!v) form.cor_fundo_grad    = null })
watch(usarGradSidebar,  (v) => { if (!v) form.cor_sidebar_grad  = null })
watch(usarGradCard,     (v) => { if (!v) form.cor_card_grad     = null })

// Preview em tempo real — só aplica depois que os dados salvos foram carregados
watch(form, (val) => {
  if (!formLoaded.value) return
  applyTheme(val)
}, { deep: true })

function aplicarTema(tema: typeof temasProntos[0]) {
  form.cor_primaria       = tema.cor_primaria
  form.cor_primaria_texto = tema.cor_primaria_texto
  form.cor_fundo          = tema.cor_fundo
  form.cor_sidebar        = tema.cor_sidebar
  form.cor_card           = tema.cor_card
  form.cor_card_texto     = tema.cor_card_texto
  form.cor_primaria_grad  = tema.cor_primaria_grad  ?? null
  form.cor_fundo_grad     = tema.cor_fundo_grad     ?? null
  form.cor_sidebar_grad   = tema.cor_sidebar_grad   ?? null
  form.cor_card_grad      = tema.cor_card_grad      ?? null
  form.grad_direction     = tema.grad_direction     ?? '135deg'
  usarGradPrimaria.value  = !!tema.cor_primaria_grad
  usarGradFundo.value     = !!tema.cor_fundo_grad
  usarGradSidebar.value   = !!tema.cor_sidebar_grad
  usarGradCard.value      = !!tema.cor_card_grad
}

function isTemaSelecionado(tema: typeof temasProntos[0]): boolean {
  return form.cor_primaria === tema.cor_primaria
    && form.cor_fundo === tema.cor_fundo
    && (form.cor_primaria_grad ?? null) === (tema.cor_primaria_grad ?? null)
}

function sanitizeHex(field: keyof PersonalizacaoConfig) {
  const val = form[field] as string
  if (val && !/^#[0-9A-Fa-f]{0,6}$/.test(val)) {
    ;(form as any)[field] = val.replace(/[^#0-9A-Fa-f]/g, '')
  }
}

async function handleLogoUpload(event: Event) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0]
  if (!file) return
  const url = await uploadLogo(file)
  if (url) {
    form.logo_url = url
    // Salva automaticamente para persistir o logo no banco
    await handleSave()
  }
  input.value = ''
}

async function handleSave() {
  const ok = await savePersonalizacao({ ...form })
  if (ok) {
    savedFeedback.value = true
    setTimeout(() => { savedFeedback.value = false }, 2500)
  } else if (!error.value) {
    error.value = 'Não foi possível salvar. Tente novamente.'
  }
}

function handleReset() {
  Object.assign(form, DEFAULTS)
  usarGradPrimaria.value = false
  usarGradFundo.value    = false
  usarGradSidebar.value  = false
  usarGradCard.value     = false
}

async function handleRemoveLogo() {
  form.logo_url = null
  await handleSave()
}
</script>
