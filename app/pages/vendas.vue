<template>
  <div class="min-h-full bg-gray-50/60 p-3 sm:p-8">

    <!-- �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� CABE�?ALHO �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� -->
    <div class="relative rounded-3xl overflow-hidden mb-8 shadow-xl">
      <div class="absolute inset-0 bg-gradient-to-br from-green-900 via-green-700 to-green-500" />
      <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_top_right,rgba(251,207,232,0.15),transparent_60%)]" />
      <div class="absolute -top-16 -right-16 w-72 h-72 rounded-full bg-white/[0.04] pointer-events-none" />
      <div class="absolute -bottom-20 left-1/4 w-96 h-96 rounded-full bg-white/[0.03] pointer-events-none" />
      <div class="absolute top-4 right-1/3 w-40 h-40 rounded-full bg-yellow-300/10 pointer-events-none" />

      <div class="relative px-4 sm:px-8 pt-5 sm:pt-7 pb-5 sm:pb-7">
        <div class="flex flex-wrap items-start justify-between gap-3 sm:gap-6">
          <div class="flex items-center gap-3 sm:gap-5">
            <div class="flex items-center justify-center w-10 sm:w-14 h-10 sm:h-14 rounded-2xl bg-white/[0.12] backdrop-blur-sm border border-white/20 shadow-lg">
              <svg class="w-5 sm:w-7 h-5 sm:h-7 text-white" fill="none" stroke="currentColor" stroke-width="1.75" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 14.25l6-6m4.5-3.493V21.75l-3.75-1.5-3.75 1.5-3.75-1.5-3.75 1.5V4.757c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0111.186 0c1.1.128 1.907 1.077 1.907 2.185zM9.75 9h.008v.008H9.75V9zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm4.125 4.5h.008v.008h-.008V13.5zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z"/></svg>
            </div>
            <div>
              <div class="flex items-center gap-2 mb-1">
                <span class="text-xs font-semibold text-green-300 uppercase tracking-widest">Financeiro</span>
                <span class="w-1 h-1 rounded-full bg-green-400/50" />
                <span class="text-xs text-green-300/70 hidden sm:inline">PetFlow</span>
              </div>
              <h1 class="text-xl sm:text-3xl font-bold text-white tracking-tight leading-none">Vendas</h1>
              <p class="text-sm text-green-100/80 mt-1.5">
                {{ loading ? 'Carregando...' : `${vendasFiltradas.length} de ${vendas.length} venda(s) exibida(s)` }}
              </p>
            </div>
          </div>

          <div class="flex items-center gap-2 shrink-0">
            <button
              type="button"
              class="inline-flex items-center gap-2 text-sm font-semibold px-3 sm:px-5 py-2.5 rounded-xl transition-all duration-200"
              :class="filtroAberto
                ? 'bg-white/20 text-white shadow-lg scale-[1.02]'
                : 'bg-white/10 text-white hover:bg-white/20 border border-white/15 backdrop-blur-sm'"
              @click="filtroAberto = !filtroAberto"
            >
              <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2a1 1 0 01-.293.707L13 13.414V19a1 1 0 01-.553.894l-4 2A1 1 0 017 21v-7.586L3.293 6.707A1 1 0 013 6V4z"/></svg>
              <span class="hidden sm:inline">Filtros</span>
              <span v-if="filtrosAtivos > 0" class="inline-flex items-center justify-center min-w-[20px] h-5 px-1 rounded-full bg-white text-green-600 text-xs font-black ring-2 ring-green-300">{{ filtrosAtivos }}</span>
            </button>
            <button
              type="button"
              class="inline-flex items-center gap-2 text-sm font-semibold px-3 sm:px-5 py-2.5 rounded-xl bg-white/10 text-white hover:bg-white/20 border border-white/15 backdrop-blur-sm transition-all duration-200 hover:scale-[1.02]"
              title="Exportar relatório em PDF"
              @click="exportarPDF"
            >
              <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m.75 12l3 3m0 0l3-3m-3 3v-6m-1.5-9H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z"/></svg>
              <span class="hidden sm:inline">Exportar PDF</span>
            </button>
            <button
              type="button"
              class="inline-flex items-center gap-2 text-sm font-bold px-3 sm:px-5 py-2.5 rounded-xl bg-white text-green-800 hover:bg-green-50 shadow-lg shadow-green-900/25 transition-all duration-200 hover:scale-[1.02]"
              @click="abrirAdicionar"
            >
              <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
              <span class="hidden sm:inline">Nova Venda</span>
            </button>
          </div>
        </div>

        <div class="h-px bg-white/10 my-4 sm:my-6" />

        <!-- Stats -->
        <div v-if="!loading" class="grid grid-cols-2 sm:grid-cols-4 gap-3">
          <div class="flex flex-col gap-1 bg-white/10 backdrop-blur-sm rounded-2xl px-5 py-4 border border-white/10 hover:bg-white/15 transition-colors">
            <span class="text-xs font-semibold text-green-300 uppercase tracking-widest">Total Vendas</span>
            <span class="text-xl font-black text-white leading-tight">{{ vendas.length }}</span>
            <span class="text-xs text-green-200/60">registros</span>
          </div>
          <div class="flex flex-col gap-1 bg-green-400/10 rounded-2xl px-5 py-4 border border-green-300/20 hover:bg-green-400/15 transition-colors">
            <div class="flex items-center gap-1.5">
              <span class="w-2 h-2 rounded-full bg-green-400" />
              <span class="text-xs font-semibold text-green-200 uppercase tracking-widest">Faturamento</span>
            </div>
            <span class="text-xl font-black text-green-100 leading-tight truncate">{{ formatCurrency(faturamentoTotal) }}</span>
            <span class="text-xs text-green-300/50">total acumulado</span>
          </div>
          <div class="flex flex-col gap-1 bg-white/[0.07] rounded-2xl px-5 py-4 border border-white/10 hover:bg-white/12 transition-colors">
            <span class="text-xs font-semibold text-green-300 uppercase tracking-widest">Ticket Médio</span>
            <span class="text-xl font-black text-white leading-tight truncate">{{ formatCurrency(ticketMedio) }}</span>
            <span class="text-xs text-green-200/60">por venda</span>
          </div>
          <div class="flex flex-col gap-1 bg-white/[0.07] rounded-2xl px-5 py-4 border border-white/10 hover:bg-white/12 transition-colors">
            <span class="text-xs font-semibold text-green-300 uppercase tracking-widest">Este Mês</span>
            <span class="text-xl font-black text-white leading-tight">{{ vendasMes }}</span>
            <span class="text-xs text-green-200/60">venda(s)</span>
          </div>
        </div>
      </div>
    </div>

    <!-- �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� FILTRO �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� -->
    <Transition name="slide-fade">
      <div v-show="filtroAberto" class="bg-white rounded-3xl border border-gray-100 shadow-md mb-6 overflow-hidden">
        <div class="flex items-center justify-between px-7 py-4 border-b border-gray-100 bg-gray-50/70">
          <div class="flex items-center gap-2.5">
            <svg class="w-4 h-4 text-orange-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2a1 1 0 01-.293.707L13 13.414V19a1 1 0 01-.553.894l-4 2A1 1 0 017 21v-7.586L3.293 6.707A1 1 0 013 6V4z"/></svg>
            <span class="text-sm font-bold text-gray-700">Filtros</span>
          </div>
          <button v-if="filtrosAtivos > 0" type="button" class="text-xs font-semibold text-orange-500 hover:text-orange-700 hover:underline" @click="limparFiltros">
            Limpar todos
          </button>
        </div>
        <div class="p-7 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
          <div class="sm:col-span-2 flex flex-col gap-1.5">
            <label class="text-xs font-bold text-gray-500 uppercase tracking-widest">Busca</label>
            <div class="relative">
              <svg class="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"/><path stroke-linecap="round" d="m21 21-4.35-4.35"/></svg>
              <input v-model="filtros.busca" type="text" placeholder="Nome do cliente ou produto..." class="w-full rounded-xl border border-gray-200 pl-10 pr-4 py-2.5 text-sm text-gray-800 placeholder:text-gray-400 bg-gray-50/50 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500 transition-shadow" />
            </div>
          </div>
          <div class="flex flex-col gap-1.5">
            <label class="text-xs font-bold text-gray-500 uppercase tracking-widest">Forma de Pagto.</label>
            <select v-model="filtros.formaPagamento" class="w-full rounded-xl border border-gray-200 px-4 py-2.5 text-sm text-gray-800 bg-gray-50/50 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
              <option value="">Todas</option>
              <option v-for="fp in formasPagamento" :key="fp" :value="fp">{{ fp }}</option>
            </select>
          </div>
          <div class="flex flex-col gap-1.5">
            <label class="text-xs font-bold text-gray-500 uppercase tracking-widest">Status</label>
            <div class="flex gap-2">
              <button
                v-for="op in [{ label: 'Todos', value: '' }, { label: 'Finalizada', value: 'finalizada' }, { label: 'Pendente', value: 'pendente' }, { label: 'Cancelada', value: 'cancelada' }]"
                :key="op.value"
                type="button"
                class="flex-1 text-xs font-bold py-2 rounded-xl border transition-colors"
                :class="filtros.status === op.value
                  ? 'bg-orange-500 border-orange-500 text-white'
                  : 'border-gray-200 text-gray-500 hover:border-orange-400 hover:text-orange-700 bg-white'"
                @click="filtros.status = op.value"
              >
                {{ op.label }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </Transition>

    <!-- �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� LOADING �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� -->
    <div v-if="loading" class="flex flex-col items-center justify-center gap-4 py-32">
      <span class="inline-block w-12 h-12 border-4 border-orange-500 border-t-transparent rounded-full animate-spin" />
      <span class="text-sm text-gray-400 font-medium">Carregando vendas...</span>
    </div>

    <!-- �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� ERRO �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� -->
    <div v-else-if="error" class="flex items-center gap-3 text-sm text-red-700 bg-red-50 border border-red-200 rounded-2xl px-6 py-4">
      <svg class="w-5 h-5 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><path stroke-linecap="round" d="M12 8v4m0 4h.01"/></svg>
      {{ error }}
    </div>

    <!-- �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� TABELA �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� -->
    <div v-else class="bg-white rounded-3xl shadow-md border border-gray-100 overflow-hidden">
      <div class="flex items-center justify-between px-7 py-4 border-b border-gray-100 bg-gray-50/50">
        <span class="text-sm font-semibold text-gray-600">
          <span class="text-orange-600 font-black">{{ vendasFiltradas.length }}</span>
          resultado(s)
          <span v-if="filtrosAtivos > 0" class="text-gray-400 font-normal"> �?" filtros aplicados</span>
        </span>
        <span class="text-xs text-gray-400">Ordenado por data</span>
      </div>

      <div class="overflow-x-auto">
        <table class="min-w-full text-sm">
          <thead>
            <tr class="bg-gray-50 border-b border-gray-100">
              <th class="text-left px-6 py-4 text-xs font-extrabold text-gray-400 uppercase tracking-widest w-12">#</th>
              <th class="text-left px-5 py-4 text-xs font-extrabold text-gray-400 uppercase tracking-widest">Cliente</th>
              <th class="text-left px-5 py-4 text-xs font-extrabold text-gray-400 uppercase tracking-widest">Item</th>
              <th class="text-right px-5 py-4 text-xs font-extrabold text-gray-400 uppercase tracking-widest">Subtotal</th>
              <th class="text-left px-5 py-4 text-xs font-extrabold text-gray-400 uppercase tracking-widest">Pagamento / Status</th>
              <th class="text-left px-5 py-4 text-xs font-extrabold text-gray-400 uppercase tracking-widest whitespace-nowrap">Data</th>
              <th class="px-6 py-4 text-right text-xs font-extrabold text-gray-400 uppercase tracking-widest sm:sticky sm:right-0 bg-gray-50 w-24">Ações</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-50">
            <tr v-if="vendasFiltradas.length === 0">
              <td colspan="7" class="text-center py-20">
                <div class="flex flex-col items-center gap-3">
                  <svg class="w-14 h-14 text-gray-300" fill="none" stroke="currentColor" stroke-width="1.25" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 14.25l6-6m4.5-3.493V21.75l-3.75-1.5-3.75 1.5-3.75-1.5-3.75 1.5V4.757c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0111.186 0c1.1.128 1.907 1.077 1.907 2.185zM9.75 9h.008v.008H9.75V9zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm4.125 4.5h.008v.008h-.008V13.5zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z"/></svg>
                  <span class="text-base font-semibold text-gray-400">Nenhuma venda encontrada</span>
                  <span v-if="filtrosAtivos > 0" class="text-sm text-gray-400">Tente ajustar os filtros</span>
                </div>
              </td>
            </tr>
            <tr
              v-for="venda in vendasFiltradas"
              :key="venda.id"
              class="hover:bg-orange-50/30 transition-colors duration-150 group"
            >
              <!-- # -->
              <td class="px-6 py-4">
                <span class="inline-flex items-center justify-center w-8 h-8 rounded-full bg-orange-100 text-orange-700 font-black text-xs">
                  {{ venda.id }}
                </span>
              </td>

              <!-- Cliente -->
              <td class="px-5 py-4">
                <div class="flex items-center gap-2.5">
                  <div class="w-8 h-8 rounded-full bg-gradient-to-br from-violet-400 to-violet-600 flex items-center justify-center text-white font-black text-xs shrink-0 shadow-sm shadow-violet-200 select-none">
                    {{ (venda.clientes?.nome ?? '?')[0]?.toUpperCase() }}
                  </div>
                  <span class="font-semibold text-gray-800 max-w-[160px] block truncate whitespace-nowrap">{{ venda.clientes?.nome ?? '�?"' }}</span>
                </div>
              </td>

              <!-- Itens da venda -->
              <td class="px-5 py-4">
                <div class="flex flex-col gap-1">
                  <template v-if="venda.vendas_itens && venda.vendas_itens.length > 0">
                    <div v-for="item in venda.vendas_itens.slice(0, 2)" :key="item.produto_id" class="flex items-center gap-1.5 min-w-0">
                      <span class="font-semibold text-gray-800 max-w-[160px] truncate text-sm">{{ item.produtos_casa_racao?.nome ?? '�?"' }}</span>
                      <span class="text-xs text-gray-400 whitespace-nowrap shrink-0">{{ item.quantidade }}�- {{ formatCurrency(item.preco_unitario) }}</span>
                    </div>
                    <span v-if="venda.vendas_itens.length > 2" class="text-xs text-orange-500 font-semibold">+{{ venda.vendas_itens.length - 2 }} item(ns)</span>
                  </template>
                  <span v-else class="text-sm text-gray-400">�?"</span>
                </div>
              </td>

              <!-- Subtotal -->
              <td class="px-5 py-4 text-right">
                <div class="flex flex-col items-end gap-0.5">
                  <span class="text-base font-black text-gray-800 whitespace-nowrap">
                    {{ formatCurrency(vendaTotalValor(venda)) }}
                  </span>
                  <span class="text-[11px] text-gray-400 font-medium">{{ venda.vendas_itens?.length ?? 0 }} item(ns)</span>
                </div>
              </td>

              <!-- Pagamento / Status -->
              <td class="px-5 py-4">
                <div class="flex flex-col gap-1.5">
                  <span :class="['inline-flex items-center gap-1.5 text-xs font-bold px-2.5 py-1 rounded-full w-fit', statusBadgeClass(venda.status)]">
                    <span :class="['w-1.5 h-1.5 rounded-full', statusDotClass(venda.status)]" />
                    {{ statusLabel(venda.status) }}
                  </span>
                  <span v-if="venda.forma_pagamento" class="inline-flex items-center gap-1 text-[11px] font-semibold text-gray-500 whitespace-nowrap">
                    <svg class="w-3 h-3" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 8.25h19.5M2.25 9h19.5m-16.5 5.25h6m-6 2.25h3m-3.75 3h15a2.25 2.25 0 002.25-2.25V6.75A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25v10.5A2.25 2.25 0 004.5 21z"/></svg>
                    {{ venda.forma_pagamento }}
                  </span>
                  <span v-else class="text-[11px] text-gray-300">Sem pagamento</span>
                </div>
              </td>

              <!-- Data -->
              <td class="px-5 py-4 text-xs text-gray-500 font-medium whitespace-nowrap">{{ formatDate(venda.data_venda) }}</td>

              <!-- Ações -->
              <td class="px-6 py-4 text-right sm:sticky sm:right-0 bg-white group-hover:bg-orange-50/30 transition-colors">
                <div class="flex items-center justify-end gap-1">
                  <button type="button" class="w-8 h-8 flex items-center justify-center rounded-xl text-orange-500 hover:text-orange-700 hover:bg-orange-100 transition-colors" title="Editar" @click="editVenda(venda)">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L10.582 16.07a4.5 4.5 0 01-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 011.13-1.897l8.932-8.931z"/><path stroke-linecap="round" stroke-linejoin="round" d="M19.5 7.125L18 8.625"/></svg>
                  </button>
                  <button type="button" class="w-8 h-8 flex items-center justify-center rounded-xl text-red-400 hover:text-red-600 hover:bg-red-50 transition-colors" title="Excluir" @click="confirmarExclusao(venda)">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6M9 7h6m-7 0a1 1 0 01-1-1V5a1 1 0 011-1h8a1 1 0 011 1v1a1 1 0 01-1 1H9z"/></svg>
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� MODAL ADICIONAR / EDITAR �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� -->
    <Teleport to="body">
      <Transition name="fade">
        <div
          v-if="editando !== null || adicionando"
          class="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-md px-4"
          @click.self="fecharModal"
        >
          <div class="bg-white rounded-3xl shadow-2xl w-full max-w-xl overflow-hidden">
            <div class="flex items-center justify-between px-8 py-6 border-b border-gray-100 bg-gradient-to-r from-orange-50 to-white">
              <div class="flex items-center gap-3">
                <div class="w-9 h-9 rounded-xl bg-orange-100 flex items-center justify-center">
                  <svg class="w-5 h-5 text-orange-600" fill="none" stroke="currentColor" stroke-width="1.75" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 14.25l6-6m4.5-3.493V21.75l-3.75-1.5-3.75 1.5-3.75-1.5-3.75 1.5V4.757c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0111.186 0c1.1.128 1.907 1.077 1.907 2.185zM9.75 9h.008v.008H9.75V9zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm4.125 4.5h.008v.008h-.008V13.5zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z"/></svg>
                </div>
                <h2 class="text-lg font-bold text-gray-800">{{ adicionando ? 'Nova Venda' : 'Editar Venda' }}</h2>
              </div>
              <button type="button" class="w-8 h-8 flex items-center justify-center rounded-xl text-gray-400 hover:text-gray-700 hover:bg-gray-100 transition-colors" @click="fecharModal">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
              </button>
            </div>

            <form class="flex flex-col gap-5 px-8 py-7 overflow-y-auto max-h-[72vh]" @submit.prevent="adicionando ? salvarAdicao() : salvarEdicao()">
              <!-- Cliente -->
              <div class="flex flex-col gap-1.5">
                <label class="text-sm font-semibold text-gray-700">Cliente *</label>
                <select v-model="form.cliente_id" required class="w-full rounded-xl border border-gray-200 px-4 py-2.5 text-sm text-gray-800 bg-gray-50/50 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" :class="formErrors.cliente_id ? 'border-red-400 ring-1 ring-red-400' : ''">
                  <option :value="null">Selecione o cliente</option>
                  <option v-for="c in clientesOpcoes" :key="c.id" :value="c.id">{{ c.nome }}</option>
                </select>
                <p v-if="formErrors.cliente_id" class="text-xs text-red-500 font-medium">{{ formErrors.cliente_id }}</p>
              </div>

              <!-- �"?�"? ITENS DA VENDA �"?�"? -->
              <template v-if="adicionando || editando">
                <div class="flex flex-col gap-3">
                  <div class="flex items-center justify-between">
                    <label class="text-sm font-semibold text-gray-700">Itens da venda *</label>
                    <span class="text-xs text-gray-400">{{ itens.length }} item(ns)</span>
                  </div>

                  <!-- Lista de itens adicionados -->
                  <div v-if="itens.length > 0" class="flex flex-col gap-2">
                    <div
                      v-for="(item, idx) in itens"
                      :key="idx"
                      class="flex items-center gap-3 bg-orange-50 border border-orange-100 rounded-2xl px-4 py-3"
                    >
                      <div class="flex-1 min-w-0">
                        <p class="text-sm font-bold text-gray-800 truncate">{{ produtoNome(item.produto_id) }}</p>
                        <p class="text-xs text-gray-400 mt-0.5">
                          {{ item.quantidade }}x {{ formatCurrency(item.preco_unitario) }}
                          <span class="font-bold text-orange-600 ml-1">= {{ formatCurrency(item.quantidade * item.preco_unitario) }}</span>
                        </p>
                      </div>
                      <button
                        type="button"
                        class="w-7 h-7 flex items-center justify-center rounded-xl text-red-400 hover:text-red-600 hover:bg-red-100 transition-colors shrink-0"
                        @click="removerItem(idx)"
                      >
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
                      </button>
                    </div>
                  </div>

                  <!-- Painel de adicionar item -->
                  <div class="flex flex-col gap-3 bg-gradient-to-br from-orange-50 to-amber-50/40 border border-orange-100 rounded-2xl p-4">
                    <p class="text-xs font-bold text-orange-700 uppercase tracking-widest">Adicionar produto</p>

                    <!-- Cards de categoria -->
                    <div class="flex flex-col gap-1.5">
                      <label class="text-xs font-semibold text-gray-400 uppercase tracking-widest">Categoria</label>
                      <div class="flex gap-2.5 overflow-x-auto pb-1 -mx-1 px-1 snap-x">
                        <button
                          type="button"
                          class="snap-start shrink-0 flex flex-col items-center gap-1.5 w-20 rounded-2xl border-2 py-3 transition-all duration-150"
                          :class="categoriaSelecionada === ''
                            ? 'bg-orange-500 border-orange-500 shadow-md shadow-orange-200 scale-[1.04]'
                            : 'bg-white border-gray-100 hover:border-orange-300 hover:shadow-sm'"
                          @click="selecionarCategoria('')"
                        >
                          <span class="w-9 h-9 flex items-center justify-center rounded-xl" :class="categoriaSelecionada === '' ? 'bg-white/20 text-white' : 'bg-orange-50 text-orange-400'">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6A2.25 2.25 0 016 3.75h2.25A2.25 2.25 0 0110.5 6v2.25a2.25 2.25 0 01-2.25 2.25H6a2.25 2.25 0 01-2.25-2.25V6zM3.75 15.75A2.25 2.25 0 016 13.5h2.25a2.25 2.25 0 012.25 2.25V18a2.25 2.25 0 01-2.25 2.25H6A2.25 2.25 0 013.75 18v-2.25zM13.5 6a2.25 2.25 0 012.25-2.25H18A2.25 2.25 0 0120.25 6v2.25A2.25 2.25 0 0118 10.5h-2.25a2.25 2.25 0 01-2.25-2.25V6zM13.5 15.75a2.25 2.25 0 012.25-2.25H18a2.25 2.25 0 012.25 2.25V18A2.25 2.25 0 0118 20.25h-2.25A2.25 2.25 0 0113.5 18v-2.25z"/></svg>
                          </span>
                          <span class="text-[11px] font-bold leading-tight text-center" :class="categoriaSelecionada === '' ? 'text-white' : 'text-gray-600'">Todas</span>
                          <span class="text-[10px] font-black px-1.5 py-0.5 rounded-full" :class="categoriaSelecionada === '' ? 'bg-white/25 text-white' : 'bg-orange-100 text-orange-600'">{{ produtosOpcoes.length }}</span>
                        </button>
                        <button
                          v-for="cat in categoriasComContagem"
                          :key="cat.nome"
                          type="button"
                          class="snap-start shrink-0 flex flex-col items-center gap-1.5 w-20 rounded-2xl border-2 py-3 transition-all duration-150"
                          :class="categoriaSelecionada === cat.nome
                            ? 'bg-orange-500 border-orange-500 shadow-md shadow-orange-200 scale-[1.04]'
                            : 'bg-white border-gray-100 hover:border-orange-300 hover:shadow-sm'"
                          @click="selecionarCategoria(cat.nome)"
                        >
                          <span class="w-9 h-9 flex items-center justify-center rounded-xl" :class="categoriaSelecionada === cat.nome ? 'bg-white/20 text-white' : 'bg-orange-50 text-orange-500'">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.75" viewBox="0 0 24 24" v-html="categoryIconHtml(cat.nome)" />
                          </span>
                          <span class="text-[11px] font-bold leading-tight text-center line-clamp-2 px-1" :class="categoriaSelecionada === cat.nome ? 'text-white' : 'text-gray-600'">{{ toCapitalCase(cat.nome) }}</span>
                          <span class="text-[10px] font-black px-1.5 py-0.5 rounded-full" :class="categoriaSelecionada === cat.nome ? 'bg-white/25 text-white' : 'bg-orange-100 text-orange-600'">{{ cat.count }}</span>
                        </button>
                      </div>
                    </div>

                    <!-- Produto + Qtd -->
                    <div class="flex gap-2 items-end">
                      <div class="flex-1 flex flex-col gap-1.5">
                        <label class="text-xs font-semibold text-gray-400 uppercase tracking-widest">Produto</label>
                        <select v-model="novoItem.produto_id" class="w-full rounded-xl border border-gray-200 px-3 py-2.5 text-sm text-gray-800 bg-white focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
                          <option :value="null">{{ produtosFiltradosPorCategoria.length === 0 ? 'Sem produtos' : 'Selecione...' }}</option>
                          <option v-for="p in produtosFiltradosPorCategoria" :key="p.id" :value="p.id">{{ p.nome }}</option>
                        </select>
                      </div>
                      <div class="w-20 flex flex-col gap-1.5">
                        <label class="text-xs font-semibold text-gray-400 uppercase tracking-widest">Qtd</label>
                        <input v-model.number="novoItem.quantidade" type="number" min="1" step="1" class="w-full rounded-xl border border-gray-200 px-3 py-2.5 text-sm text-gray-800 bg-white focus:outline-none focus:ring-2 focus:ring-orange-500" />
                      </div>
                      <div class="w-28 flex flex-col gap-1.5">
                        <label class="text-xs font-semibold text-gray-400 uppercase tracking-widest">Preço (R$)</label>
                        <input v-model.number="novoItem.preco_unitario" type="number" min="0" step="0.01" class="w-full rounded-xl border border-gray-200 px-3 py-2.5 text-sm text-gray-800 bg-white focus:outline-none focus:ring-2 focus:ring-orange-500" />
                      </div>
                      <button
                        type="button"
                        class="mb-0.5 w-10 h-10 flex items-center justify-center rounded-xl bg-orange-500 hover:bg-orange-600 text-white transition-colors shadow-sm shadow-orange-200 shrink-0 disabled:opacity-40"
                        :disabled="!novoItem.produto_id"
                        @click="adicionarItem"
                      >
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
                      </button>
                    </div>
                    <p v-if="formErrors.itens" class="text-xs text-red-500 font-medium">{{ formErrors.itens }}</p>
                  </div>

                  <!-- Total geral -->
                  <div v-if="itens.length > 0" class="flex items-center justify-between bg-orange-500 rounded-2xl px-5 py-3">
                    <span class="text-sm font-bold text-white">Total da venda</span>
                    <span class="text-lg font-black text-white">{{ formatCurrency(totalGeral) }}</span>
                  </div>
                </div>
              </template>

              <!-- Forma pagamento + Status -->
              <div class="grid grid-cols-2 gap-4">
                <div class="flex flex-col gap-1.5">
                  <label class="text-sm font-semibold text-gray-700">Forma de Pagamento</label>
                  <select v-model="form.forma_pagamento" class="w-full rounded-xl border border-gray-200 px-4 py-2.5 text-sm text-gray-800 bg-gray-50/50 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
                    <option value="">Não informado</option>
                    <option v-for="fp in formasPagamento" :key="fp" :value="fp">{{ fp }}</option>
                  </select>
                </div>
                <div class="flex flex-col gap-1.5">
                  <label class="text-sm font-semibold text-gray-700">Status</label>
                  <select v-model="form.status" class="w-full rounded-xl border border-gray-200 px-4 py-2.5 text-sm text-gray-800 bg-gray-50/50 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
                    <option value="finalizada">Finalizada</option>
                    <option value="pendente">Pendente</option>
                    <option value="cancelada">Cancelada</option>
                  </select>
                </div>
              </div>

              <!-- Data da venda -->
              <div class="flex flex-col gap-1.5">
                <label class="text-sm font-semibold text-gray-700">Data da Venda</label>
                <input v-model="form.data_venda" type="datetime-local" class="w-full rounded-xl border border-gray-200 px-4 py-2.5 text-sm text-gray-800 bg-gray-50/50 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" />
              </div>

              <!-- Observação -->
              <div class="flex flex-col gap-1.5">
                <label class="text-sm font-semibold text-gray-700">Observação</label>
                <textarea v-model="form.observacao" rows="2" placeholder="Informações adicionais..." class="w-full rounded-xl border border-gray-200 px-4 py-2.5 text-sm text-gray-800 placeholder:text-gray-400 bg-gray-50/50 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500 resize-none" />
              </div>

              <p v-if="modalError" class="text-sm text-red-600 bg-red-50 border border-red-200 rounded-xl px-4 py-3">{{ modalError }}</p>

              <div class="flex gap-3 pt-1">
                <button type="button" class="flex-1 py-3 rounded-xl border border-gray-200 text-gray-500 hover:bg-gray-50 transition-colors text-sm font-semibold" @click="fecharModal">
                  Cancelar
                </button>
                <AppButton variant="primary" size="md" type="submit" :loading="saving" class="flex-1">
                  {{ adicionando ? 'Registrar Venda' : 'Salvar alterações' }}
                </AppButton>
              </div>
            </form>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� MODAL EXCLUIR �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� -->
    <Teleport to="body">
      <Transition name="fade">
        <div
          v-if="excluindo"
          class="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-md px-4"
          @click.self="excluindo = null"
        >
          <div class="bg-white rounded-3xl shadow-2xl w-full max-w-sm overflow-hidden">
            <div class="px-8 pt-8 pb-6 text-center">
              <div class="w-16 h-16 rounded-2xl bg-red-50 border border-red-100 flex items-center justify-center mx-auto mb-5">
                <svg class="w-8 h-8 text-red-500" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6M9 7h6m-7 0a1 1 0 01-1-1V5a1 1 0 011-1h8a1 1 0 011 1v1a1 1 0 01-1 1H9z"/></svg>
              </div>
              <h2 class="text-xl font-bold text-gray-800">Excluir venda?</h2>
              <p class="text-sm text-gray-500 mt-2 leading-relaxed">
                Venda <strong class="text-gray-800">#{{ excluindo.id }}</strong> de
                <strong class="text-gray-800">{{ excluindo.clientes?.nome }}</strong>.<br />
                <span class="text-red-500 text-xs font-semibold">Essa ação não pode ser desfeita.</span>
              </p>
            </div>
            <p v-if="deleteError" class="text-sm text-red-600 bg-red-50 border-t border-b border-red-200 px-8 py-3 text-center">{{ deleteError }}</p>
            <div class="flex gap-3 px-8 pb-8 pt-4">
              <button type="button" class="flex-1 py-3 rounded-xl border border-gray-200 text-gray-500 hover:bg-gray-50 transition-colors text-sm font-semibold" @click="excluindo = null">
                Cancelar
              </button>
              <button
                type="button"
                class="flex-1 py-3 rounded-xl bg-red-500 hover:bg-red-600 text-white font-bold text-sm transition-colors shadow-sm shadow-red-200 disabled:opacity-60"
                :disabled="deleting"
                @click="executarExclusao"
              >
                <span v-if="deleting" class="inline-block w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin mr-1" />
                {{ deleting ? 'Excluindo...' : 'Excluir' }}
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, watch, onMounted } from 'vue'
import { createSupabaseClient } from '~/lib/supabase'
import AppButton from '~/components/AppButton.vue'
import jsPDF from 'jspdf'
import autoTable from 'jspdf-autotable'

interface ClienteOpcao { id: number; nome: string }
interface ProdutoOpcao  { id: number; nome: string; categoria: string | null; preco_venda: number }
interface ItemVenda { produto_id: number; quantidade: number; preco_unitario: number; valor_total?: number | null; produtos_casa_racao?: { nome: string } | null }
interface Venda {
  id: number
  cliente_id: number
  forma_pagamento: string | null
  status: string | null
  observacao: string | null
  data_venda: string | null
  created_at: string | null
  clientes: { nome: string } | null
  vendas_itens: ItemVenda[]
}

const supabase = createSupabaseClient()

const vendas          = ref<Venda[]>([])
const clientesOpcoes  = ref<ClienteOpcao[]>([])
const produtosOpcoes  = ref<ProdutoOpcao[]>([])
const loading         = ref(true)
const error           = ref<string | null>(null)

const editando    = ref<Venda | null>(null)
const adicionando = ref(false)
const saving      = ref(false)
const modalError  = ref<string | null>(null)

const excluindo   = ref<Venda | null>(null)
const deleting    = ref(false)
const deleteError = ref<string | null>(null)

const form = reactive({
  cliente_id:      null as number | null,
  forma_pagamento: '',
  status:          'finalizada',
  observacao:      '',
  data_venda:      '',
})
const formErrors = reactive({ cliente_id: '', itens: '' })

// itens do carrinho (modo adicionar)
const itens = ref<ItemVenda[]>([])
const novoItem = reactive<ItemVenda>({ produto_id: null as unknown as number, quantidade: 1, preco_unitario: 0 })

const totalGeral = computed(() =>
  itens.value.reduce((s, i) => s + i.quantidade * i.preco_unitario, 0)
)

const categoriaSelecionada = ref('')

const filtroAberto = ref(false)
const filtros = reactive({ busca: '', status: '', formaPagamento: '' })

const formasPagamento = ['Dinheiro', 'Pix', 'Cartão de Débito', 'Cartão de Crédito', 'Boleto', 'Transferência']

const categoriasDisponiveis = computed(() => {
  const set = new Set(produtosOpcoes.value.map(p => p.categoria).filter(Boolean) as string[])
  return Array.from(set).sort()
})
const categoriasComContagem = computed(() =>
  categoriasDisponiveis.value.map(nome => ({
    nome,
    count: produtosOpcoes.value.filter(p => p.categoria === nome).length,
  }))
)

const CATEGORY_ICONS: Record<string, string> = {
  food:         '<path stroke-linecap="round" stroke-linejoin="round" d="M15.362 5.214A8.252 8.252 0 0112 21 8.25 8.25 0 016.038 7.048 8.287 8.287 0 009 9.6a8.983 8.983 0 013.361-6.867 8.21 8.21 0 003 2.48z"/><path stroke-linecap="round" stroke-linejoin="round" d="M12 18a3.75 3.75 0 00.495-7.468 5.99 5.99 0 00-1.925 3.547 5.975 5.975 0 01-2.133-1.001A3.75 3.75 0 0012 18z"/>',
  hygiene:      '<path stroke-linecap="round" stroke-linejoin="round" d="M9.75 3.104v5.714a2.25 2.25 0 01-.659 1.591L5 14.5M9.75 3.104c-.251.023-.501.05-.75.082m.75-.082a24.301 24.301 0 014.5 0m0 0v5.714c0 .597.237 1.17.659 1.591L19.8 15.3M14.25 3.104c.251.023.501.05.75.082M19.8 15.3l-1.57.393A9.065 9.065 0 0112 15a9.065 9.065 0 00-6.23-.693L5 14.5m14.8.8l1.402 1.402c1.232 1.232.65 3.318-1.067 3.611A48.309 48.309 0 0112 21c-2.773 0-5.491-.235-8.135-.687-1.718-.293-2.3-2.379-1.067-3.61L5 14.5"/>',
  toy:          '<path stroke-linecap="round" stroke-linejoin="round" d="M9.813 15.904L9 18.75l-.813-2.846a4.5 4.5 0 00-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 003.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 003.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 00-3.09 3.09zM18.259 8.715L18 9.75l-.259-1.035a3.375 3.375 0 00-2.455-2.456L14.25 6l1.036-.259a3.375 3.375 0 002.455-2.456L18 2.25l.259 1.035a3.375 3.375 0 002.456 2.456L21.75 6l-1.035.259a3.375 3.375 0 00-2.456 2.456zM16.894 20.567L16.5 21.75l-.394-1.183a2.25 2.25 0 00-1.423-1.423L13.5 18.75l1.183-.394a2.25 2.25 0 001.423-1.423l.394-1.183.394 1.183a2.25 2.25 0 001.423 1.423l1.183.394-1.183.394a2.25 2.25 0 00-1.423 1.423z"/>',
  health:       '<path stroke-linecap="round" stroke-linejoin="round" d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z"/>',
  accessories:  '<path stroke-linecap="round" stroke-linejoin="round" d="M9.568 3H5.25A2.25 2.25 0 003 5.25v4.318c0 .597.237 1.17.659 1.591l9.581 9.581c.699.699 1.78.872 2.607.33a18.095 18.095 0 005.223-5.223c.542-.827.369-1.908-.33-2.607L11.16 3.66A2.25 2.25 0 009.568 3z"/><path stroke-linecap="round" stroke-linejoin="round" d="M6 6h.008v.008H6V6z"/>',
  home:         '<path stroke-linecap="round" stroke-linejoin="round" d="M2.25 12L11.204 3.046a1.125 1.125 0 011.592 0L21.75 12M4.5 9.75V19.5a.75.75 0 00.75.75h4.5a.75.75 0 00.75-.75v-4.5a.75.75 0 01.75-.75h3a.75.75 0 01.75.75V19.5a.75.75 0 00.75.75h4.5a.75.75 0 00.75-.75V9.75M8.25 21h8.25"/>',
  snack:        '<path stroke-linecap="round" stroke-linejoin="round" d="M12 3v2.25m6.364.386l-1.591 1.591M21 12h-2.25m-.386 6.364l-1.591-1.591M12 18.75V21m-4.773-4.227l-1.591 1.591M5.25 12H3m4.227-4.773L5.636 5.636M15.75 12a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0z"/>',
  default:      '<path stroke-linecap="round" stroke-linejoin="round" d="M20.25 7.5l-.625 10.632a2.25 2.25 0 01-2.247 2.118H6.622a2.25 2.25 0 01-2.247-2.118L3.75 7.5M10 11.25h4M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H3.375c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125z"/>',
}

function categoryIconHtml(nome: string): string {
  const n = nome.toLowerCase()
  let key = 'default'
  if (/ra[çc][aã]o|alimenta|comida|nutri/.test(n))               key = 'food'
  else if (/petisco|snack|biscoito|trat/.test(n))                key = 'snack'
  else if (/higien|banho|limpeza|shampoo|grooming/.test(n))      key = 'hygiene'
  else if (/brinquedo|toy|lazer|jogo/.test(n))                   key = 'toy'
  else if (/medic|sa[úu]de|veterin|farm|rem[ée]dio/.test(n))    key = 'health'
  else if (/acess[oó]rio|coleira|guia|roupa|vest/.test(n))       key = 'accessories'
  else if (/cama|casinha|confort|moradia/.test(n))               key = 'home'
  return CATEGORY_ICONS[key] ?? CATEGORY_ICONS['default']!
}

function toCapitalCase(s: string): string {
  if (!s) return s
  return s.charAt(0).toUpperCase() + s.slice(1)
}
const produtosFiltradosPorCategoria = computed(() => {
  if (!categoriaSelecionada.value) return produtosOpcoes.value
  return produtosOpcoes.value.filter(p => p.categoria === categoriaSelecionada.value)
})
function selecionarCategoria(cat: string) {
  categoriaSelecionada.value = cat
  novoItem.produto_id = null as unknown as number
  novoItem.preco_unitario = 0
}

watch(() => novoItem.produto_id, (id) => {
  if (id == null) return
  const p = produtosOpcoes.value.find(p => p.id === id)
  if (p) novoItem.preco_unitario = p.preco_venda
})

// �"?�"? Stats �"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?
const faturamentoTotal = computed(() =>
  vendas.value.reduce((s, v) =>
    s + (v.vendas_itens ?? []).reduce((si, i) => si + (i.valor_total ?? i.quantidade * i.preco_unitario), 0), 0)
)
const ticketMedio = computed(() =>
  vendas.value.length ? faturamentoTotal.value / vendas.value.length : 0
)
const vendasMes = computed(() => {
  const now = new Date()
  return vendas.value.filter(v => {
    if (!v.data_venda) return false
    const d = new Date(v.data_venda)
    return d.getFullYear() === now.getFullYear() && d.getMonth() === now.getMonth()
  }).length
})

// �"?�"? Filtros �"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?
const filtrosAtivos = computed(() => {
  let c = 0
  if (filtros.busca) c++
  if (filtros.status) c++
  if (filtros.formaPagamento) c++
  return c
})
const vendasFiltradas = computed(() => {
  return vendas.value.filter(v => {
    if (filtros.status && v.status !== filtros.status) return false
    if (filtros.formaPagamento && v.forma_pagamento !== filtros.formaPagamento) return false
    if (filtros.busca.trim()) {
      const q = filtros.busca.toLowerCase()
      return (
        (v.clientes?.nome ?? '').toLowerCase().includes(q) ||
        (v.vendas_itens ?? []).some(i => (i.produtos_casa_racao?.nome ?? '').toLowerCase().includes(q))
      )
    }
    return true
  })
})
function limparFiltros() { filtros.busca = ''; filtros.status = ''; filtros.formaPagamento = '' }

// �"?�"? Helpers �"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?
function formatCurrency(val: number | null | undefined): string {
  if (val == null) return '�?"'
  return val.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })
}
function formatDate(iso: string | null): string {
  if (!iso) return '�?"'
  return new Date(iso).toLocaleDateString('pt-BR', { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' })
}
function toDatetimeLocal(iso: string | null): string {
  if (!iso) return ''
  return new Date(iso).toISOString().slice(0, 16)
}
function statusLabel(s: string | null): string {
  if (s === 'finalizada') return 'Finalizada'
  if (s === 'pendente')   return 'Pendente'
  if (s === 'cancelada')  return 'Cancelada'
  return s ?? '�?"'
}
function statusBadgeClass(s: string | null): string {
  if (s === 'finalizada') return 'bg-green-100 text-green-700'
  if (s === 'pendente')   return 'bg-amber-100 text-amber-700'
  if (s === 'cancelada')  return 'bg-red-100 text-red-700'
  return 'bg-gray-100 text-gray-500'
}
function statusDotClass(s: string | null): string {
  if (s === 'finalizada') return 'bg-green-500'
  if (s === 'pendente')   return 'bg-amber-500'
  if (s === 'cancelada')  return 'bg-red-500'
  return 'bg-gray-400'
}
function vendaTotalValor(v: Venda): number {
  return (v.vendas_itens ?? []).reduce((s, i) => s + (i.valor_total ?? i.quantidade * i.preco_unitario), 0)
}

// �"?�"? CRUD �"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?
onMounted(async () => {
  await Promise.all([fetchVendas(), fetchOpcoes()])
})

async function fetchVendas() {
  loading.value = true
  const { data, error: fetchError } = await supabase
    .from('vendas')
    .select('*, clientes(nome), vendas_itens(id, produto_id, quantidade, preco_unitario, valor_total, produtos_casa_racao(nome))')
    .order('data_venda', { ascending: false })

  loading.value = false
  if (fetchError) { error.value = fetchError.message; return }
  vendas.value = (data ?? []) as Venda[]
}

async function fetchOpcoes() {
  const [{ data: clis }, { data: prods }] = await Promise.all([
    supabase.from('clientes').select('id, nome').eq('ativo', true).order('nome'),
    supabase.from('produtos_casa_racao').select('id, nome, categoria, preco_venda').eq('ativo', true).order('nome'),
  ])
  clientesOpcoes.value = (clis ?? []) as ClienteOpcao[]
  produtosOpcoes.value = (prods ?? []) as ProdutoOpcao[]
}

function adicionarItem() {
  if (!novoItem.produto_id) return
  itens.value.push({ produto_id: novoItem.produto_id, quantidade: novoItem.quantidade, preco_unitario: novoItem.preco_unitario })
  novoItem.produto_id = null as unknown as number
  novoItem.quantidade = 1
  novoItem.preco_unitario = 0
  categoriaSelecionada.value = ''
  formErrors.itens = ''
}
function removerItem(idx: number) { itens.value.splice(idx, 1) }
function produtoNome(id: number): string {
  return produtosOpcoes.value.find(p => p.id === id)?.nome ?? String(id)
}

function abrirAdicionar() {
  adicionando.value = true
  editando.value = null
  modalError.value = null
  formErrors.cliente_id = ''; formErrors.itens = ''
  form.cliente_id = null
  itens.value = []
  novoItem.produto_id = null as unknown as number; novoItem.quantidade = 1; novoItem.preco_unitario = 0
  categoriaSelecionada.value = ''
  form.forma_pagamento = ''; form.status = 'finalizada'
  form.observacao = ''; form.data_venda = toDatetimeLocal(new Date().toISOString())
}

function fecharModal() {
  editando.value = null
  adicionando.value = false
}

function editVenda(v: Venda) {
  editando.value = v
  modalError.value = null
  formErrors.cliente_id = ''; formErrors.itens = ''
  form.cliente_id      = v.cliente_id
  form.forma_pagamento = v.forma_pagamento ?? ''
  form.status          = v.status ?? 'finalizada'
  form.observacao      = v.observacao ?? ''
  form.data_venda      = toDatetimeLocal(v.data_venda)
  itens.value = (v.vendas_itens ?? []).map(i => ({
    produto_id:     i.produto_id,
    quantidade:     i.quantidade,
    preco_unitario: i.preco_unitario,
  }))
  categoriaSelecionada.value = ''
}

function validateForm(): boolean {
  formErrors.cliente_id = ''; formErrors.itens = ''
  let ok = true
  if (!form.cliente_id) { formErrors.cliente_id = 'Selecione o cliente.'; ok = false }
  if (itens.value.length === 0) { formErrors.itens = 'Adicione ao menos um produto.'; ok = false }
  return ok
}

async function salvarEdicao() {
  if (!editando.value || !validateForm()) return
  saving.value = true; modalError.value = null

  const { error: updateError } = await supabase
    .from('vendas')
    .update({
      cliente_id:      form.cliente_id!,
      forma_pagamento: form.forma_pagamento || null,
      status:          form.status,
      observacao:      form.observacao.trim() || null,
      data_venda:      form.data_venda || null,
    })
    .eq('id', editando.value.id)

  if (updateError) { modalError.value = updateError.message; saving.value = false; return }

  const { error: deleteItensError } = await supabase
    .from('vendas_itens')
    .delete()
    .eq('venda_id', editando.value.id)

  if (deleteItensError) { modalError.value = deleteItensError.message; saving.value = false; return }

  const { error: insertItensError } = await supabase
    .from('vendas_itens')
    .insert(itens.value.map(item => ({
      venda_id:       editando.value!.id,
      produto_id:     item.produto_id,
      quantidade:     item.quantidade,
      preco_unitario: item.preco_unitario,
    })))

  saving.value = false
  if (insertItensError) { modalError.value = insertItensError.message; return }
  editando.value = null
  await fetchVendas()
}

async function salvarAdicao() {
  if (!validateForm()) return
  saving.value = true; modalError.value = null

  const { data: vendaData, error: insertVendaError } = await supabase
    .from('vendas')
    .insert({
      cliente_id:      form.cliente_id!,
      forma_pagamento: form.forma_pagamento || null,
      status:          form.status,
      observacao:      form.observacao.trim() || null,
      data_venda:      form.data_venda || null,
    })
    .select('id')
    .single()

  if (insertVendaError) { modalError.value = insertVendaError.message; saving.value = false; return }

  const { error: insertItensError } = await supabase
    .from('vendas_itens')
    .insert(itens.value.map(item => ({
      venda_id:       vendaData.id,
      produto_id:     item.produto_id,
      quantidade:     item.quantidade,
      preco_unitario: item.preco_unitario,
    })))

  saving.value = false
  if (insertItensError) { modalError.value = insertItensError.message; return }
  adicionando.value = false
  await fetchVendas()
}

function confirmarExclusao(v: Venda) { excluindo.value = v; deleteError.value = null }

async function executarExclusao() {
  if (!excluindo.value) return
  deleting.value = true; deleteError.value = null
  const { error: deleteErr } = await supabase.from('vendas').delete().eq('id', excluindo.value.id)
  deleting.value = false
  if (deleteErr) { deleteError.value = deleteErr.message; return }
  excluindo.value = null
  await fetchVendas()
}

function exportarPDF() {
  const doc = new jsPDF({ orientation: 'landscape', unit: 'pt', format: 'a4' })
  const now = new Date()
  const dataGeracao = now.toLocaleDateString('pt-BR', { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' })

  // Cabeçalho
  doc.setFillColor(20, 83, 45)
  doc.rect(0, 0, doc.internal.pageSize.getWidth(), 56, 'F')
  doc.setTextColor(255, 255, 255)
  doc.setFontSize(20)
  doc.setFont('helvetica', 'bold')
  doc.text('PetFlow �?" Relatório de Vendas', 40, 34)
  doc.setFontSize(9)
  doc.setFont('helvetica', 'normal')
  doc.text(`Gerado em: ${dataGeracao}`, 40, 48)

  if (filtrosAtivos.value > 0) {
    const parts: string[] = []
    if (filtros.status) parts.push(`Status: ${statusLabel(filtros.status)}`)
    if (filtros.formaPagamento) parts.push(`Pagamento: ${filtros.formaPagamento}`)
    if (filtros.busca) parts.push(`Busca: "${filtros.busca}"`)
    doc.text(`Filtros aplicados: ${parts.join(' · ')}`, doc.internal.pageSize.getWidth() - 40, 48, { align: 'right' })
  }

  // Resumo
  doc.setTextColor(20, 83, 45)
  doc.setFontSize(9)
  doc.setFont('helvetica', 'bold')
  const resumoY = 74
  const totalVendasFiltradas = vendasFiltradas.value.length
  const faturamentoFiltrado = vendasFiltradas.value.reduce((s, v) => s + vendaTotalValor(v), 0)
  const ticketFiltrado = totalVendasFiltradas ? faturamentoFiltrado / totalVendasFiltradas : 0
  doc.text(
    `Total: ${totalVendasFiltradas} venda(s)   |   Faturamento: ${formatCurrency(faturamentoFiltrado)}   |   Ticket Médio: ${formatCurrency(ticketFiltrado)}`,
    40, resumoY
  )

  // Tabela
  autoTable(doc, {
    startY: resumoY + 14,
    head: [['#', 'Cliente', 'Itens', 'Total', 'Pagamento', 'Status', 'Data']],
    body: vendasFiltradas.value.map(v => [
      String(v.id),
      v.clientes?.nome ?? '�?"',
      (v.vendas_itens ?? []).map(i => `${i.produtos_casa_racao?.nome ?? '?'} �?" ${i.quantidade}�- ${formatCurrency(i.preco_unitario)}`).join('\n') || '�?"',
      formatCurrency(vendaTotalValor(v)),
      v.forma_pagamento ?? '�?"',
      statusLabel(v.status),
      formatDate(v.data_venda),
    ]),
    headStyles: { fillColor: [20, 83, 45], textColor: 255, fontStyle: 'bold', fontSize: 8 },
    bodyStyles: { fontSize: 8, textColor: [30, 30, 30] },
    alternateRowStyles: { fillColor: [240, 253, 244] },
    columnStyles: {
      0: { cellWidth: 28, halign: 'center' },
      3: { cellWidth: 70, halign: 'right' },
      4: { cellWidth: 80 },
      5: { cellWidth: 60, halign: 'center' },
      6: { cellWidth: 90 },
    },
    margin: { left: 40, right: 40 },
    tableLineColor: [220, 252, 231],
    tableLineWidth: 0.5,
  })

  // Rodapé
  const pageCount = (doc.internal as any).getNumberOfPages()
  for (let i = 1; i <= pageCount; i++) {
    doc.setPage(i)
    doc.setFontSize(8)
    doc.setFont('helvetica', 'normal')
    doc.setTextColor(150, 150, 150)
    doc.text(`Página ${i} de ${pageCount}`, doc.internal.pageSize.getWidth() / 2, doc.internal.pageSize.getHeight() - 16, { align: 'center' })
  }

  const filename = `vendas_${now.getFullYear()}${String(now.getMonth()+1).padStart(2,'0')}${String(now.getDate()).padStart(2,'0')}.pdf`
  doc.save(filename)
}
</script>

<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.2s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }
.slide-fade-enter-active { transition: all 0.2s ease; }
.slide-fade-leave-active { transition: all 0.15s ease; }
.slide-fade-enter-from, .slide-fade-leave-to { transform: translateY(-8px); opacity: 0; }
</style>
