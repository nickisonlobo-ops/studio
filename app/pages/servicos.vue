<template>
  <div class="min-h-full bg-transparent p-3 sm:p-8">

    <!-- CABEÇALHO -->
    <div class="relative rounded-3xl overflow-hidden mb-8 shadow-xl">
      <div class="absolute inset-0" :style="{ background: 'var(--color-primary-bg, linear-gradient(135deg, #ec4899, #f43f5e))' }" />
      <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_top_right,rgba(255,255,255,0.1),transparent_60%)]" />
      <div class="absolute -top-16 -right-16 w-72 h-72 rounded-full bg-white/[0.03] pointer-events-none" />
      <PageLogo />

      <div class="relative px-4 sm:px-8 pt-5 sm:pt-7 pb-5 sm:pb-7">
        <div class="flex flex-wrap items-start justify-between gap-3 sm:gap-6">
          <div class="flex items-center gap-3 sm:gap-5">
            <div class="flex items-center justify-center w-10 sm:w-14 h-10 sm:h-14 rounded-2xl bg-white/[0.12] backdrop-blur-sm border border-white/20 shadow-lg">
              <AppNavIcon name="sparkles" class="w-5 sm:w-7 h-5 sm:h-7 text-white" />
            </div>
            <div>
              <div class="flex items-center gap-2 mb-1">
                <span class="text-xs font-semibold text-white/80 uppercase tracking-widest">Catálogo</span>
              </div>
              <h1 class="text-xl sm:text-3xl font-bold text-white tracking-tight leading-none">Serviços</h1>
              <p class="text-sm text-white/80 mt-1.5">
                {{ loading ? 'Carregando...' : `${servicosFiltrados.length} de ${servicos.length} serviço(s)` }}
              </p>
            </div>
          </div>

          <div class="flex items-center gap-2 shrink-0">
            <button
              type="button"
              class="inline-flex items-center gap-2 text-sm font-semibold px-3 sm:px-5 py-2.5 rounded-xl transition-all duration-200"
              :class="filtroAberto ? 'bg-white text-[#ff46a2] shadow-lg scale-[1.02]' : 'bg-white/10 text-white hover:bg-white/20 border border-white/15 backdrop-blur-sm'"
              @click="filtroAberto = !filtroAberto"
            >
              <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2a1 1 0 01-.293.707L13 13.414V19a1 1 0 01-.553.894l-4 2A1 1 0 017 21v-7.586L3.293 6.707A1 1 0 013 6V4z"/></svg>
              <span class="hidden sm:inline">Filtros</span>
            </button>
            <button
              v-if="isAdminOrGerente"
              type="button"
              class="inline-flex items-center gap-2 text-sm font-bold px-3 sm:px-5 py-2.5 rounded-xl bg-white text-[#ff46a2] hover:bg-pink-50 shadow-lg shadow-pink-200/40 transition-all duration-200 hover:scale-[1.02]"
              @click="abrirAdicionar"
            >
              <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
              <span class="hidden sm:inline">Novo Serviço</span>
            </button>
          </div>
        </div>

        <div class="h-px bg-white/10 my-4 sm:my-6" />

        <!-- Stats -->
        <div v-if="!loading" class="grid grid-cols-2 sm:grid-cols-4 gap-3">
          <div class="flex flex-col gap-1 bg-white/10 backdrop-blur-sm rounded-2xl px-5 py-4 border border-white/10">
            <span class="text-xs font-semibold text-white/70 uppercase tracking-widest">Total</span>
            <span class="text-2xl font-black text-white">{{ servicos.length }}</span>
          </div>
          <div class="flex flex-col gap-1 bg-white/10 backdrop-blur-sm rounded-2xl px-5 py-4 border border-white/10">
            <span class="text-xs font-semibold text-white/70 uppercase tracking-widest">Ativos</span>
            <span class="text-2xl font-black text-white">{{ servicos.filter(s => s.ativo).length }}</span>
          </div>

        </div>
      </div>
    </div>

    <!-- FILTROS -->
    <div v-if="filtroAberto" class="bg-white rounded-2xl shadow-sm border border-gray-200/80 p-4 sm:p-6 mb-6 flex flex-wrap gap-4">
      <div class="flex-1 min-w-[200px]">
        <label class="block text-xs font-semibold text-gray-500 uppercase tracking-widest mb-1.5">Buscar</label>
        <input
          v-model="filtro.busca"
          type="text"
          placeholder="Nome do serviço..."
          class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-pink-400"
        />
      </div>
      <div class="min-w-[160px]">
        <label class="block text-xs font-semibold text-gray-500 uppercase tracking-widest mb-1.5">Categoria</label>
        <select v-model="filtro.categoria" class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-pink-400">
          <option value="">Todas</option>
          <option value="cilios">Cílios</option>
          <option value="unhas">Unhas</option>
          <option value="combo">Combo</option>
          <option value="outro">Outro</option>
        </select>
      </div>
      <div class="min-w-[140px]">
        <label class="block text-xs font-semibold text-gray-500 uppercase tracking-widest mb-1.5">Status</label>
        <select v-model="filtro.ativo" class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-pink-400">
          <option value="">Todos</option>
          <option value="true">Ativo</option>
          <option value="false">Inativo</option>
        </select>
      </div>
    </div>

    <!-- ERRO -->
    <div v-if="error" class="bg-red-50 border border-red-200 text-red-700 rounded-2xl px-5 py-4 mb-6 text-sm">{{ error }}</div>

    <!-- LOADING -->
    <div v-if="loading" class="flex justify-center py-20">
      <svg class="animate-spin w-8 h-8 text-pink-400" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"/></svg>
    </div>

    <!-- LISTA DE SERVIÇOS -->
    <div v-else-if="servicosFiltrados.length" class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-4">
      <div
        v-for="s in servicosFiltrados"
        :key="s.id"
        class="bg-white rounded-2xl border border-gray-200/80 shadow-sm hover:shadow-md transition-shadow overflow-hidden"
      >
        <!-- Faixa de categoria -->
        <div class="h-1.5 w-full" :class="categoriaCor(s.categoria)" />

        <div class="p-5">
          <div class="flex items-start justify-between gap-2 mb-3">
            <div class="flex-1">
              <h3 class="font-bold text-gray-900 text-base leading-tight">{{ s.nome }}</h3>
              <p v-if="s.descricao" class="text-xs text-gray-500 mt-1 line-clamp-2">{{ s.descricao }}</p>
            </div>
            <span
              class="shrink-0 inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold"
              :class="s.ativo ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'"
            >{{ s.ativo ? 'Ativo' : 'Inativo' }}</span>
          </div>

          <div class="flex items-center gap-3 flex-wrap">
            <span class="inline-flex items-center gap-1 text-xs font-medium px-2.5 py-1 rounded-lg" :class="categoriaBadge(s.categoria)">
              {{ categoriaLabel(s.categoria) }}
            </span>
            <span class="inline-flex items-center gap-1 text-xs text-gray-500">
              <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6l4 2m6-2a10 10 0 11-20 0 10 10 0 0120 0z"/></svg>
              {{ s.duracao_min }}min
            </span>
            <span class="ml-auto text-lg font-black text-gray-900">{{ formatPreco(s.preco) }}</span>
          </div>

          <div v-if="isAdminOrGerente" class="flex gap-2 mt-4 pt-4 border-t border-gray-100">
            <button
              type="button"
              class="flex-1 text-xs font-semibold py-2 rounded-xl bg-gray-100 text-gray-700 hover:bg-gray-200 transition-colors"
              @click="editServico(s)"
            >Editar</button>
            <button
              type="button"
              class="flex-1 text-xs font-semibold py-2 rounded-xl bg-red-50 text-red-600 hover:bg-red-100 transition-colors"
              @click="confirmarExclusao(s)"
            >Excluir</button>
          </div>
        </div>
      </div>
    </div>

    <div v-else class="bg-white rounded-3xl shadow-md border border-gray-100 overflow-hidden">
      <div class="flex flex-col items-center justify-center py-20 text-gray-400">
        <AppNavIcon name="sparkles" class="w-14 h-14 mb-4 text-gray-300" />
        <p class="text-base font-semibold text-gray-400">Nenhum serviço encontrado</p>
        <p class="text-sm text-gray-400 mt-1">Adicione o primeiro serviço do studio</p>
      </div>
    </div>

    <!-- MODAL ADICIONAR / EDITAR -->
    <Teleport to="body">
      <div v-if="adicionando || editando" class="fixed inset-0 z-50 flex items-center justify-center p-4">
        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" @click="fecharModal" />
        <div class="relative bg-white rounded-3xl shadow-2xl w-full max-w-lg max-h-[90vh] overflow-y-auto">
          <div class="px-6 pt-6 pb-4 border-b border-gray-100 flex items-center justify-between">
            <h2 class="text-lg font-bold text-gray-900">{{ editando ? 'Editar Serviço' : 'Novo Serviço' }}</h2>
            <button type="button" class="text-gray-400 hover:text-gray-600 transition-colors" @click="fecharModal">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
            </button>
          </div>

          <form class="px-6 py-5 flex flex-col gap-4" @submit.prevent="editando ? salvarEdicao() : salvarAdicao()">
            <div v-if="modalError" class="bg-red-50 border border-red-200 text-red-600 rounded-xl px-4 py-3 text-sm">{{ modalError }}</div>

            <div>
              <label class="block text-xs font-semibold text-gray-600 uppercase tracking-widest mb-1.5">Nome <span class="text-red-500">*</span></label>
              <input
                v-model="form.nome"
                type="text"
                placeholder="Nome do Serviço"
                class="w-full rounded-xl border px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-pink-400"
                :class="formErrors.nome ? 'border-red-400 bg-red-50' : 'border-gray-200 bg-gray-50'"
              />
              <p v-if="formErrors.nome" class="text-xs text-red-500 mt-1">{{ formErrors.nome }}</p>
            </div>

            <div>
              <label class="block text-xs font-semibold text-gray-600 uppercase tracking-widest mb-1.5">Descrição</label>
              <textarea
                v-model="form.descricao"
                rows="2"
                placeholder="Descreva o serviço..."
                class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-pink-400 resize-none"
              />
            </div>

            <div class="grid grid-cols-2 gap-4">
              <div>
                <label class="block text-xs font-semibold text-gray-600 uppercase tracking-widest mb-1.5">Categoria <span class="text-red-500">*</span></label>
                <select
                  v-model="form.categoria"
                  class="w-full rounded-xl border border-gray-200 bg-gray-50 px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-[var(--color-primary,#6b7280)] focus:border-[var(--color-primary,#6b7280)]"
                >
                  <option value="" disabled>Selecione</option>
                  <option value="cilios">Cílios</option>
                  <option value="unhas">Unhas</option>
                  <option value="combo">Combo</option>
                  <option value="outro">Outro</option>
                </select>
              </div>
              <div>
                <label class="block text-xs font-semibold text-gray-600 uppercase tracking-widest mb-1.5">Duração (min) <span class="text-red-500">*</span></label>
                <input
                  v-model.number="form.duracao_min"
                  type="number"
                  min="1"
                  placeholder="60"
                  class="w-full rounded-xl border px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-pink-400"
                  :class="formErrors.duracao_min ? 'border-red-400 bg-red-50' : 'border-gray-200 bg-gray-50'"
                />
                <p v-if="formErrors.duracao_min" class="text-xs text-red-500 mt-1">{{ formErrors.duracao_min }}</p>
              </div>
            </div>

            <div class="grid grid-cols-2 gap-4">
              <div>
                <label class="block text-xs font-semibold text-gray-600 uppercase tracking-widest mb-1.5">Preço (R$) <span class="text-red-500">*</span></label>
                <input
                  v-model.number="form.preco"
                  type="number"
                  min="0"
                  step="0.01"
                  placeholder="0,00"
                  class="w-full rounded-xl border px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-pink-400"
                  :class="formErrors.preco ? 'border-red-400 bg-red-50' : 'border-gray-200 bg-gray-50'"
                />
                <p v-if="formErrors.preco" class="text-xs text-red-500 mt-1">{{ formErrors.preco }}</p>
              </div>
              <div class="flex flex-col justify-end">
                <label class="flex items-center gap-2 cursor-pointer select-none">
                  <div
                    class="relative w-10 h-5 rounded-full transition-colors"
                    :class="form.ativo ? 'bg-green-400' : 'bg-gray-300'"
                    @click="form.ativo = !form.ativo"
                  >
                    <div class="absolute top-0.5 left-0.5 w-4 h-4 rounded-full bg-white shadow transition-transform" :class="form.ativo ? 'translate-x-5' : ''" />
                  </div>
                  <span class="text-sm font-medium text-gray-700">{{ form.ativo ? 'Ativo' : 'Inativo' }}</span>
                </label>
              </div>
            </div>

            <div class="flex gap-3 pt-2">
              <button type="button" class="flex-1 py-2.5 rounded-xl border border-gray-200 text-sm font-semibold text-gray-600 hover:bg-gray-50" @click="fecharModal">Cancelar</button>
              <button
                type="submit"
                :disabled="saving"
                class="flex-1 py-2.5 rounded-xl bg-pink-500 text-white text-sm font-bold hover:bg-pink-400 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
              >
                {{ saving ? 'Salvando...' : (editando ? 'Salvar' : 'Adicionar') }}
              </button>
            </div>
          </form>
        </div>
      </div>
    </Teleport>

    <!-- MODAL EXCLUIR -->
    <Teleport to="body">
      <div v-if="excluindo" class="fixed inset-0 z-50 flex items-center justify-center p-4">
        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" @click="excluindo = null" />
        <div class="relative bg-white rounded-3xl shadow-2xl w-full max-w-sm p-6">
          <h2 class="text-lg font-bold text-gray-900 mb-2">Excluir serviço?</h2>
          <p class="text-sm text-gray-500 mb-1">Você está prestes a excluir <strong class="text-gray-800">{{ excluindo.nome }}</strong>.</p>
          <p class="text-xs text-red-500 mb-5">Esta ação não pode ser desfeita.</p>
          <div v-if="deleteError" class="bg-red-50 border border-red-200 text-red-600 rounded-xl px-4 py-3 text-sm mb-4">{{ deleteError }}</div>
          <div class="flex gap-3">
            <button type="button" class="flex-1 py-2.5 rounded-xl border border-gray-200 text-sm font-semibold text-gray-600 hover:bg-gray-50" @click="excluindo = null">Cancelar</button>
            <button
              type="button"
              :disabled="deleting"
              class="flex-1 py-2.5 rounded-xl bg-red-500 text-white text-sm font-bold hover:bg-red-400 disabled:opacity-50 transition-colors"
              @click="executarExclusao"
            >{{ deleting ? 'Excluindo...' : 'Excluir' }}</button>
          </div>
        </div>
      </div>
    </Teleport>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted } from 'vue'
import { createSupabaseClient } from '~/lib/supabase'
import { useEmpresa } from '~/composables/useEmpresa'
import { useAdmin } from '~/composables/useAdmin'
import AppNavIcon from '~/components/AppNavIcon.vue'

defineOptions({ name: 'ServicosPage' })
useHead({ title: 'Serviços' })

interface Servico {
  id: number
  nome: string
  descricao: string | null
  categoria: string
  duracao_min: number
  preco: number
  ativo: boolean
  created_at: string | null
}

const supabase = createSupabaseClient()
const { empresaId, loadEmpresa } = useEmpresa()
const { isAdminOrGerente } = useAdmin()

const servicos = ref<Servico[]>([])
const loading = ref(true)
const error = ref<string | null>(null)

const editando = ref<Servico | null>(null)
const adicionando = ref(false)
const saving = ref(false)
const modalError = ref<string | null>(null)

const excluindo = ref<Servico | null>(null)
const deleting = ref(false)
const deleteError = ref<string | null>(null)

const filtroAberto = ref(false)
const filtro = reactive({ busca: '', categoria: '', ativo: '' })

const form = reactive({
  nome: '',
  descricao: '',
  categoria: '',
  duracao_min: 60,
  preco: 0,
  ativo: true,
})

const formErrors = reactive({ nome: '', duracao_min: '', preco: '' })

const servicosFiltrados = computed(() =>
  servicos.value.filter(s => {
    if (filtro.busca && !s.nome.toLowerCase().includes(filtro.busca.toLowerCase())) return false
    if (filtro.categoria && s.categoria !== filtro.categoria) return false
    if (filtro.ativo === 'true' && !s.ativo) return false
    if (filtro.ativo === 'false' && s.ativo) return false
    return true
  })
)

function formatPreco(v: number) {
  return new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(v)
}

function categoriaLabel(cat: string) {
  return { cilios: 'Cílios', unhas: 'Unhas', combo: 'Combo', outro: 'Outro' }[cat] ?? cat
}

function categoriaCor(cat: string) {
  return { cilios: 'bg-pink-500', unhas: 'bg-purple-500', combo: 'bg-indigo-500', outro: 'bg-gray-400' }[cat] ?? 'bg-gray-300'
}

function categoriaBadge(cat: string) {
  return {
    cilios: 'bg-pink-100 text-pink-700',
    unhas: 'bg-purple-100 text-purple-700',
    combo: 'bg-indigo-100 text-indigo-700',
    outro: 'bg-gray-100 text-gray-600',
  }[cat] ?? 'bg-gray-100 text-gray-600'
}

onMounted(async () => {
  await loadEmpresa()
  await fetchServicos()
})

async function fetchServicos() {
  loading.value = true
  const { data, error: fetchError } = await supabase
    .from('servicos')
    .select('*')
    .eq('empresa_id', empresaId.value!)
    .order('categoria', { ascending: true })
    .order('nome', { ascending: true })

  loading.value = false
  if (fetchError) { error.value = fetchError.message; return }
  servicos.value = (data ?? []) as Servico[]
}

function resetForm() {
  form.nome = ''; form.descricao = ''; form.categoria = ''
  form.duracao_min = 60; form.preco = 0; form.ativo = true
  formErrors.nome = ''; formErrors.duracao_min = ''; formErrors.preco = ''
}

function abrirAdicionar() {
  resetForm()
  adicionando.value = true
  editando.value = null
  modalError.value = null
}

function fecharModal() {
  editando.value = null
  adicionando.value = false
}

function editServico(s: Servico) {
  editando.value = s
  adicionando.value = false
  modalError.value = null
  formErrors.nome = ''; formErrors.duracao_min = ''; formErrors.preco = ''
  form.nome = s.nome
  form.descricao = s.descricao ?? ''
  form.categoria = s.categoria
  form.duracao_min = s.duracao_min
  form.preco = s.preco
  form.ativo = s.ativo
}

function validateForm(): boolean {
  formErrors.nome = ''; formErrors.duracao_min = ''; formErrors.preco = ''
  let ok = true
  if (!form.nome.trim()) { formErrors.nome = 'O nome é obrigatório.'; ok = false }
  if (!form.duracao_min || form.duracao_min < 1) { formErrors.duracao_min = 'Informe a duração.'; ok = false }
  if (form.preco < 0) { formErrors.preco = 'Preço inválido.'; ok = false }
  return ok
}

function buildPayload() {
  return {
    nome: form.nome.trim(),
    descricao: form.descricao.trim() || null,
    categoria: form.categoria,
    duracao_min: form.duracao_min,
    preco: form.preco,
    ativo: form.ativo,
    empresa_id: empresaId.value!,
  }
}

async function salvarEdicao() {
  if (!editando.value || !validateForm()) return
  saving.value = true
  modalError.value = null

  const { error: updateError } = await supabase
    .from('servicos')
    .update(buildPayload())
    .eq('id', editando.value.id)

  saving.value = false
  if (updateError) { modalError.value = updateError.message; return }
  editando.value = null
  await fetchServicos()
}

async function salvarAdicao() {
  if (!validateForm()) return
  saving.value = true
  modalError.value = null

  const { error: insertError } = await supabase
    .from('servicos')
    .insert(buildPayload())

  saving.value = false
  if (insertError) { modalError.value = insertError.message; return }
  adicionando.value = false
  await fetchServicos()
}

function confirmarExclusao(s: Servico) {
  excluindo.value = s
  deleteError.value = null
}

async function executarExclusao() {
  if (!excluindo.value) return
  deleting.value = true
  deleteError.value = null

  const { error: deleteErr } = await supabase
    .from('servicos')
    .delete()
    .eq('id', excluindo.value.id)

  deleting.value = false
  if (deleteErr) { deleteError.value = deleteErr.message; return }
  excluindo.value = null
  await fetchServicos()
}
</script>
