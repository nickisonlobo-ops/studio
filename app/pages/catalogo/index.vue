<template>
  <div class="min-h-full bg-gray-50/60 p-3 sm:p-8">

    <!-- ═══════════════════════════════ CABEÇALHO ═══════════════════════════════ -->
    <div class="relative rounded-3xl overflow-hidden mb-8 shadow-xl">
      <div class="absolute inset-0" :style="{ background: 'var(--color-primary-bg, linear-gradient(135deg, #ec4899, #f43f5e))' }" />
      <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_top_right,rgba(255,255,255,0.1),transparent_60%)]" />
      <div class="absolute -top-16 -right-16 w-72 h-72 rounded-full bg-white/[0.03] pointer-events-none" />
      <div class="absolute -bottom-20 left-1/4 w-96 h-96 rounded-full bg-white/[0.02] pointer-events-none" />

      <div class="relative px-4 sm:px-8 pt-5 sm:pt-7 pb-5 sm:pb-7">
        <div class="flex flex-wrap items-start justify-between gap-3 sm:gap-6">
          <div class="flex items-center gap-3 sm:gap-5">
            <div class="flex items-center justify-center w-10 sm:w-14 h-10 sm:h-14 rounded-2xl bg-white/[0.12] backdrop-blur-sm border border-white/20 shadow-lg">
              <svg class="w-5 sm:w-7 h-5 sm:h-7 text-white" fill="none" stroke="currentColor" stroke-width="1.75" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6A2.25 2.25 0 016 3.75h2.25A2.25 2.25 0 0110.5 6v2.25a2.25 2.25 0 01-2.25 2.25H6a2.25 2.25 0 01-2.25-2.25V6zM3.75 15.75A2.25 2.25 0 016 13.5h2.25a2.25 2.25 0 012.25 2.25V18a2.25 2.25 0 01-2.25 2.25H6A2.25 2.25 0 013.75 18v-2.25zM13.5 6a2.25 2.25 0 012.25-2.25H18A2.25 2.25 0 0120.25 6v2.25A2.25 2.25 0 0118 10.5h-2.25a2.25 2.25 0 01-2.25-2.25V6zM13.5 15.75a2.25 2.25 0 012.25-2.25H18a2.25 2.25 0 012.25 2.25V18A2.25 2.25 0 0118 20.25h-2.25A2.25 2.25 0 0113.5 18v-2.25z" />
              </svg>
            </div>
            <div>
              <div class="flex items-center gap-2 mb-1">
                <span class="text-xs font-semibold text-white/80 uppercase tracking-widest">Catálogo</span>
                <span class="w-1 h-1 rounded-full bg-white/40" />
                <span class="text-xs text-white/50 hidden sm:inline">AutoFlow</span>
              </div>
              <h1 class="text-xl sm:text-3xl font-bold text-white tracking-tight leading-none">Catálogo de Veículos</h1>
              <p class="text-sm text-gray-300/80 mt-1.5">
                {{ loading ? 'Carregando...' : `${veiculosFiltrados.length} de ${veiculos.length} veículo(s) disponível(is)` }}
              </p>
            </div>
          </div>

          <div class="flex items-center gap-2 shrink-0">
            <!-- Copiar link público para clientes -->
            <button
              type="button"
              class="inline-flex items-center gap-2 text-sm font-semibold px-3 sm:px-5 py-2.5 rounded-xl transition-all duration-200 border backdrop-blur-sm"
              :class="linkPublicoCopiado
                ? 'bg-green-500/20 border-green-400/40 text-green-300'
                : 'bg-white/10 text-white hover:bg-white/20 border-white/15'"
              @click="copiarLinkPublico"
            >
              <svg v-if="!linkPublicoCopiado" class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M7.217 10.907a2.25 2.25 0 100 2.186m0-2.186c.18.324.283.696.283 1.093s-.103.77-.283 1.093m0-2.186l9.566-5.314m-9.566 7.5l9.566 5.314m0 0a2.25 2.25 0 103.935 2.186 2.25 2.25 0 00-3.935-2.186zm0-12.814a2.25 2.25 0 103.933-2.185 2.25 2.25 0 00-3.933 2.185z"/></svg>
              <svg v-else class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"/></svg>
              <span class="hidden sm:inline">{{ linkPublicoCopiado ? 'Copiado!' : 'Link p/ cliente' }}</span>
            </button>
            <!-- Filtros -->
            <button
              type="button"
              class="inline-flex items-center gap-2 text-sm font-semibold px-3 sm:px-5 py-2.5 rounded-xl transition-all duration-200"
              :class="filtroAberto
                ? 'bg-amber-500 text-gray-950 shadow-lg scale-[1.02]'
                : 'bg-white/10 text-white hover:bg-white/20 border border-white/15 backdrop-blur-sm'"
              @click="filtroAberto = !filtroAberto"
            >
              <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2a1 1 0 01-.293.707L13 13.414V19a1 1 0 01-.553.894l-4 2A1 1 0 017 21v-7.586L3.293 6.707A1 1 0 013 6V4z"/></svg>
              <span class="hidden sm:inline">Filtros</span>
              <span v-if="filtrosAtivos > 0" class="inline-flex items-center justify-center min-w-[20px] h-5 px-1 rounded-full bg-gray-950 text-amber-400 text-xs font-black">{{ filtrosAtivos }}</span>
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- ═══════════════════════════════ FILTROS ═══════════════════════════════ -->
    <Transition name="slide-fade">
      <div v-show="filtroAberto" class="bg-white rounded-3xl border border-gray-100 shadow-md mb-6 overflow-hidden">
        <div class="flex items-center justify-between px-7 py-4 border-b border-gray-100 bg-gray-50/70">
          <span class="text-sm font-bold text-gray-700">Filtros</span>
          <button v-if="filtrosAtivos > 0" type="button" class="text-xs font-semibold text-amber-600 hover:underline" @click="limparFiltros">Limpar todos</button>
        </div>
        <div class="p-6 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
          <!-- Busca -->
          <div class="sm:col-span-2 flex flex-col gap-1.5">
            <label class="text-xs font-bold text-gray-500 uppercase tracking-widest">Busca</label>
            <div class="relative">
              <svg class="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"/><path stroke-linecap="round" d="m21 21-4.35-4.35"/></svg>
              <input v-model="filtros.busca" type="text" placeholder="Marca, modelo, cor, placa..." class="w-full rounded-xl border border-gray-200 pl-10 pr-4 py-2.5 text-sm text-gray-800 placeholder:text-gray-400 bg-gray-50/50 focus:outline-none focus:ring-2 focus:ring-amber-500 focus:border-amber-500" />
            </div>
          </div>
          <!-- Tipo -->
          <div class="flex flex-col gap-1.5">
            <label class="text-xs font-bold text-gray-500 uppercase tracking-widest">Tipo</label>
            <select v-model="filtros.tipo" class="w-full rounded-xl border border-gray-200 px-4 py-2.5 text-sm text-gray-800 bg-gray-50/50 focus:outline-none focus:ring-2 focus:ring-amber-500">
              <option value="">Todos</option>
              <option v-for="t in tiposUnicos" :key="t" :value="t">{{ t }}</option>
            </select>
          </div>
          <!-- Combustível -->
          <div class="flex flex-col gap-1.5">
            <label class="text-xs font-bold text-gray-500 uppercase tracking-widest">Combustível</label>
            <select v-model="filtros.combustivel" class="w-full rounded-xl border border-gray-200 px-4 py-2.5 text-sm text-gray-800 bg-gray-50/50 focus:outline-none focus:ring-2 focus:ring-amber-500">
              <option value="">Todos</option>
              <option v-for="c in combustiveisUnicos" :key="c" :value="c">{{ c }}</option>
            </select>
          </div>
          <!-- Faixa de preço -->
          <div class="sm:col-span-2 flex flex-col gap-1.5">
            <label class="text-xs font-bold text-gray-500 uppercase tracking-widest">Preço máximo: <span class="text-amber-600">{{ filtros.precoMax > 0 ? formatCurrency(filtros.precoMax) : 'Sem limite' }}</span></label>
            <input
              v-model.number="filtros.precoMax"
              type="range"
              :min="0"
              :max="precoMaxTotal"
              :step="stepPreco"
              class="w-full accent-amber-500 cursor-pointer"
            />
            <div class="flex justify-between text-[10px] text-gray-400">
              <span>R$ 0</span>
              <span>{{ formatCurrency(precoMaxTotal) }}</span>
            </div>
          </div>
          <!-- Status -->
          <div class="sm:col-span-2 flex flex-col gap-1.5">
            <label class="text-xs font-bold text-gray-500 uppercase tracking-widest">Status</label>
            <div class="flex gap-2 flex-wrap">
              <button
                v-for="op in [
                  { label: 'Todos', value: '' },
                  { label: 'Disponível', value: 'disponivel' },
                  { label: 'Reservado', value: 'reservado' },
                  { label: 'Vendido', value: 'vendido' },
                  { label: 'Manutenção', value: 'manutencao' },
                ]"
                :key="op.value"
                type="button"
                class="flex-1 text-xs font-bold py-2 rounded-xl border transition-colors"
                :class="filtros.status === op.value
                  ? statusBadgeClass(op.value || null) + ' border-transparent'
                  : 'border-gray-200 text-gray-500 hover:border-gray-400 bg-white'"
                @click="filtros.status = op.value"
              >
                {{ op.label }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </Transition>

    <!-- ═══════════════════════════════ LOADING ═══════════════════════════════ -->
    <div v-if="loading" class="flex flex-col items-center justify-center gap-4 py-32">
      <span class="inline-block w-12 h-12 border-4 border-amber-500 border-t-transparent rounded-full animate-spin" />
      <span class="text-sm text-gray-400 font-medium">Carregando catálogo...</span>
    </div>

    <!-- ═══════════════════════════════ ERRO ═══════════════════════════════ -->
    <div v-else-if="error" class="flex items-center gap-3 text-sm text-red-700 bg-red-50 border border-red-200 rounded-2xl px-6 py-4">
      <svg class="w-5 h-5 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><path stroke-linecap="round" d="M12 8v4m0 4h.01"/></svg>
      {{ error }}
    </div>

    <!-- ═══════════════════════════════ GRID ═══════════════════════════════ -->
    <div v-else>
      <div v-if="veiculosFiltrados.length === 0" class="flex flex-col items-center justify-center gap-3 py-24">
        <svg class="w-16 h-16 text-gray-300" fill="none" stroke="currentColor" stroke-width="1.25" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M8.25 18.75a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m3 0h6m-9 0H3.375a1.125 1.125 0 01-1.125-1.125V14.25m17.25 4.5a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m3 0h1.125c.621 0 1.129-.504 1.09-1.124a17.902 17.902 0 00-3.213-9.193 2.056 2.056 0 00-1.58-.86H14.25M16.5 18.75h-2.25m0-11.177v-.958c0-.568-.422-1.048-.987-1.106a48.554 48.554 0 00-10.026 0 1.106 1.106 0 00-.987 1.106v7.635m12-6.677v6.677m0 4.5v-4.5m0 0h-12"/></svg>
        <span class="text-base font-semibold text-gray-400">Nenhum veículo encontrado</span>
        <button v-if="filtrosAtivos > 0" type="button" class="text-sm text-amber-600 font-semibold hover:underline" @click="limparFiltros">Limpar filtros</button>
      </div>

      <div v-else class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
        <NuxtLink
          v-for="v in veiculosFiltrados"
          :key="v.id"
          :to="`/catalogo/${v.id}`"
          class="group bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all duration-300 overflow-hidden flex flex-col"
        >
          <!-- Foto -->
          <div class="relative h-44 bg-gradient-to-br from-gray-100 to-gray-200 overflow-hidden">
            <img
              v-if="v.fotos && v.fotos.length > 0"
              :src="v.fotos[0]"
              :alt="`${v.marca} ${v.modelo}`"
              class="absolute inset-0 w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
            />
            <div v-else class="absolute inset-0 flex items-center justify-center">
              <svg class="w-16 h-16 text-gray-300" fill="none" stroke="currentColor" stroke-width="1" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M8.25 18.75a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m3 0h6m-9 0H3.375a1.125 1.125 0 01-1.125-1.125V14.25m17.25 4.5a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m3 0h1.125c.621 0 1.129-.504 1.09-1.124a17.902 17.902 0 00-3.213-9.193 2.056 2.056 0 00-1.58-.86H14.25M16.5 18.75h-2.25m0-11.177v-.958c0-.568-.422-1.048-.987-1.106a48.554 48.554 0 00-10.026 0 1.106 1.106 0 00-.987 1.106v7.635m12-6.677v6.677m0 4.5v-4.5m0 0h-12"/></svg>
            </div>
            <!-- Status badge -->
            <span
              class="absolute top-3 left-3 text-[10px] font-black px-2.5 py-1 rounded-full uppercase tracking-wide shadow"
              :class="statusBadgeClass(v.status)"
            >
              {{ statusLabel(v.status) }}
            </span>
            <!-- Tipo badge -->
            <span v-if="v.tipo" class="absolute top-3 right-3 text-[10px] font-semibold bg-gray-900/70 text-white px-2 py-0.5 rounded-full">
              {{ v.tipo }}
            </span>
            <!-- Contador de fotos -->
            <span v-if="v.fotos && v.fotos.length > 1" class="absolute bottom-2.5 right-2.5 flex items-center gap-1 text-[10px] font-bold bg-black/60 text-white px-2 py-0.5 rounded-full">
              <svg class="w-3 h-3" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 15.75l5.159-5.159a2.25 2.25 0 013.182 0l5.159 5.159m-1.5-1.5l1.409-1.409a2.25 2.25 0 013.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 001.5-1.5V6a1.5 1.5 0 00-1.5-1.5H3.75A1.5 1.5 0 002.25 6v12a1.5 1.5 0 001.5 1.5zm10.5-11.25h.008v.008h-.008V8.25zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z"/></svg>
              {{ v.fotos.length }}
            </span>
          </div>

          <!-- Info -->
          <div class="flex flex-col gap-2 p-4 flex-1">
            <div>
              <p class="font-black text-gray-900 text-base leading-tight group-hover:text-amber-600 transition-colors">
                {{ v.marca }} {{ v.modelo }}
              </p>
              <p class="text-xs text-gray-400 mt-0.5">
                {{ v.ano_fabricacao }}{{ v.ano_modelo && v.ano_modelo !== v.ano_fabricacao ? `/${v.ano_modelo}` : '' }}
                <span v-if="v.cor"> • {{ v.cor }}</span>
              </p>
            </div>

            <!-- Specs -->
            <div class="flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-500">
              <span v-if="v.km != null" class="flex items-center gap-1">
                <svg class="w-3.5 h-3.5 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6l4 2m6-2a10 10 0 11-20 0 10 10 0 0120 0z"/></svg>
                {{ v.km.toLocaleString('pt-BR') }} km
              </span>
              <span v-if="v.combustivel" class="flex items-center gap-1">
                <svg class="w-3.5 h-3.5 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15.362 5.214A8.252 8.252 0 0112 21 8.25 8.25 0 016.038 7.048 8.287 8.287 0 009 9.6a8.983 8.983 0 013.361-6.867 8.21 8.21 0 003 2.48z"/></svg>
                {{ v.combustivel }}
              </span>
              <span v-if="v.cambio" class="flex items-center gap-1">
                <svg class="w-3.5 h-3.5 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M10.5 6h9.75M10.5 6a1.5 1.5 0 11-3 0m3 0a1.5 1.5 0 10-3 0M3.75 6H7.5m3 12h9.75m-9.75 0a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m-3.75 0H7.5m9-6h3.75m-3.75 0a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m-9.75 0h9.75"/></svg>
                {{ v.cambio }}
              </span>
            </div>

            <!-- Preço + CTA -->
            <div class="mt-auto pt-3 border-t border-gray-50 flex items-end justify-between">
              <div>
                <p class="text-[10px] text-gray-400 uppercase tracking-widest font-semibold">Preço</p>
                <p class="text-lg font-black text-gray-900">{{ formatCurrency(v.preco_venda) }}</p>
              </div>
              <span class="inline-flex items-center gap-1 text-xs font-bold text-amber-600 group-hover:gap-2 transition-all">
                Ver mais
                <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3"/></svg>
              </span>
            </div>
          </div>
        </NuxtLink>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted } from 'vue'
import { createSupabaseClient } from '~/lib/supabase'
import { useEmpresa } from '~/composables/useEmpresa'

const linkCopiado = ref(false)
const linkPublicoCopiado = ref(false)

function copiarLink() {
  copiarParaAreaDeTransferencia(window.location.href).then(() => {
    linkCopiado.value = true
    setTimeout(() => { linkCopiado.value = false }, 2500)
  })
}
function copiarLinkPublico() {
  const url = `${window.location.origin}/loja?e=${empresaId.value}`
  copiarParaAreaDeTransferencia(url).then(() => {
    linkPublicoCopiado.value = true
    setTimeout(() => { linkPublicoCopiado.value = false }, 2500)
  })
}

function copiarParaAreaDeTransferencia(texto: string): Promise<void> {
  if (navigator.clipboard?.writeText) {
    return navigator.clipboard.writeText(texto)
  }
  return new Promise((resolve) => {
    const el = document.createElement('textarea')
    el.value = texto
    el.setAttribute('readonly', '')
    el.style.cssText = 'position:fixed;top:-9999px;left:-9999px;opacity:0'
    document.body.appendChild(el)
    el.focus()
    el.select()
    el.setSelectionRange(0, el.value.length)
    document.execCommand('copy')
    document.body.removeChild(el)
    resolve()
  })
}

interface Veiculo {
  id: number
  marca: string
  modelo: string
  ano_fabricacao: number | null
  ano_modelo: number | null
  tipo: string | null
  placa: string | null
  cor: string | null
  km: number | null
  combustivel: string | null
  cambio: string | null
  preco_venda: number
  status: string | null
  fotos: string[] | null
}

const supabase = createSupabaseClient()
const { empresaId, loadEmpresa } = useEmpresa()

const veiculos = ref<Veiculo[]>([])
const loading  = ref(true)
const error    = ref<string | null>(null)

const filtroAberto = ref(false)
const filtros = reactive({ busca: '', tipo: '', combustivel: '', status: 'disponivel', precoMax: 0 })

onMounted(async () => {
  await loadEmpresa()
  if (!empresaId.value) {
    error.value = 'Faça login para visualizar o catálogo.'
    loading.value = false
    return
  }
  await fetchVeiculos()
})

async function fetchVeiculos() {
  loading.value = true
  const { data, error: fetchError } = await supabase
    .from('veiculos')
    .select('id,marca,modelo,ano_fabricacao,ano_modelo,tipo,placa,cor,km,combustivel,cambio,preco_venda,status,fotos')
    .eq('empresa_id', empresaId.value!)
    .in('status', ['disponivel', 'reservado', 'vendido', 'manutencao'])
    .order('created_at', { ascending: false })
  loading.value = false
  if (fetchError) { error.value = fetchError.message; return }
  veiculos.value = (data ?? []) as Veiculo[]
  if (filtros.precoMax === 0 && veiculos.value.length > 0) {
    filtros.precoMax = precoMaxTotal.value
  }
}

// ── Filtros ────────────────────────────────────────────────────────────────────
const tiposUnicos = computed(() => {
  const set = new Set(veiculos.value.map(v => v.tipo).filter(Boolean) as string[])
  return Array.from(set).sort()
})
const combustiveisUnicos = computed(() => {
  const set = new Set(veiculos.value.map(v => v.combustivel).filter(Boolean) as string[])
  return Array.from(set).sort()
})
const precoMaxTotal = computed(() => {
  if (!veiculos.value.length) return 500000
  return Math.ceil(Math.max(...veiculos.value.map(v => v.preco_venda)) / 1000) * 1000
})
const stepPreco = computed(() => {
  const max = precoMaxTotal.value
  if (max <= 50000)  return 1000
  if (max <= 200000) return 5000
  return 10000
})
const filtrosAtivos = computed(() =>
  [filtros.busca, filtros.tipo, filtros.combustivel, filtros.status !== 'disponivel' ? filtros.status : '', filtros.precoMax < precoMaxTotal.value ? String(filtros.precoMax) : ''].filter(Boolean).length
)
const veiculosFiltrados = computed(() => {
  return veiculos.value.filter(v => {
    if (filtros.tipo && v.tipo !== filtros.tipo) return false
    if (filtros.combustivel && v.combustivel !== filtros.combustivel) return false
    if (filtros.status && v.status !== filtros.status) return false
    if (filtros.precoMax > 0 && v.preco_venda > filtros.precoMax) return false
    if (filtros.busca.trim()) {
      const q = filtros.busca.toLowerCase()
      return (
        v.marca.toLowerCase().includes(q) ||
        v.modelo.toLowerCase().includes(q) ||
        (v.cor ?? '').toLowerCase().includes(q) ||
        (v.placa ?? '').toLowerCase().includes(q) ||
        String(v.ano_fabricacao ?? '').includes(q)
      )
    }
    return true
  })
})
function limparFiltros() {
  filtros.busca = ''; filtros.tipo = ''; filtros.combustivel = ''; filtros.status = 'disponivel'; filtros.precoMax = precoMaxTotal.value
}

// ── Helpers ────────────────────────────────────────────────────────────────────
function formatCurrency(val: number | null | undefined) {
  if (val == null) return '—'
  return val.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })
}
function statusLabel(s: string | null) {
  const map: Record<string, string> = { disponivel: 'Disponível', vendido: 'Vendido', reservado: 'Reservado', manutencao: 'Manutenção' }
  return map[s ?? ''] ?? s ?? '—'
}
function statusBadgeClass(s: string | null) {
  if (s === 'disponivel') return 'bg-emerald-500 text-white'
  if (s === 'reservado')  return 'bg-blue-500 text-white'
  if (s === 'vendido')    return 'bg-red-500 text-white'
  if (s === 'manutencao') return 'bg-orange-500 text-white'
  return 'bg-gray-400 text-white'
}
</script>

<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.2s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }
.slide-fade-enter-active { transition: all 0.22s ease; }
.slide-fade-leave-active { transition: all 0.15s ease; }
.slide-fade-enter-from, .slide-fade-leave-to { transform: translateY(-8px); opacity: 0; }
</style>
