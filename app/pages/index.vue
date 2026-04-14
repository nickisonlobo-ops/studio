<template>
  <div class="min-h-full bg-gray-50/60 p-3 sm:p-8">

    <!-- �.��.��.��.��.��.��.��.��.��.��.� VIS�fO FUNCIONÁRIO �.��.��.��.��.��.��.��.��.��.��.� -->
    <template v-if="!adminLoading && !isAdmin">
      <!-- Cabeçalho funcionário -->
      <div class="relative rounded-3xl overflow-hidden mb-7 shadow-xl">
        <div class="absolute inset-0 bg-gradient-to-br from-green-900 via-green-700 to-green-500" />
        <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_top_right,rgba(99,102,241,0.18),transparent_60%)]" />
        <div class="absolute -top-16 -right-16 w-72 h-72 rounded-full bg-white/[0.04] pointer-events-none" />
        <div class="absolute -bottom-20 left-1/4 w-96 h-96 rounded-full bg-white/[0.03] pointer-events-none" />

        <div class="relative px-4 sm:px-8 pt-6 pb-6">
          <div class="flex flex-wrap items-center justify-between gap-4">
            <div class="flex items-center gap-4">
              <div class="w-12 h-12 rounded-2xl bg-white/[0.15] backdrop-blur-sm border border-white/20 shadow-lg flex items-center justify-center">
                <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" stroke-width="1.75" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"/>
                </svg>
              </div>
              <div>
                <p class="text-xs font-bold text-green-300 uppercase tracking-widest">PetFlow</p>
                <h1 class="text-2xl font-black text-white leading-tight">
                  {{ funcionarioLogado ? `Olá, ${primeiroNome(funcionarioLogado.nome)}!` : 'Minhas Atividades' }}
                </h1>
                <p class="text-sm text-green-100/80 mt-0.5">{{ dataHoje }}</p>
              </div>
            </div>
            <div v-if="funcionarioLogado" class="flex flex-wrap gap-2">
              <span class="inline-flex items-center gap-1.5 text-xs font-bold bg-white/10 border border-white/15 text-white px-3 py-1.5 rounded-xl">
                <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M20.25 14.15v4.25c0 1.094-.787 2.036-1.872 2.18-2.087.277-4.216.42-6.378.42s-4.291-.143-6.378-.42c-1.085-.144-1.872-1.086-1.872-2.18v-4.25m16.5 0a2.18 2.18 0 00.75-1.661V8.706c0-1.081-.768-2.015-1.837-2.175a48.114 48.114 0 00-3.413-.387m4.5 8.006c-.194.165-.42.295-.673.38A23.978 23.978 0 0112 15.75c-2.648 0-5.195-.429-7.577-1.22a2.016 2.016 0 01-.673-.38m0 0A2.18 2.18 0 013 12.489V8.706c0-1.081.768-2.015 1.837-2.175a48.111 48.111 0 013.413-.387m7.5 0V5.25A2.25 2.25 0 0013.5 3h-3a2.25 2.25 0 00-2.25 2.25v.894m7.5 0a48.667 48.667 0 00-7.5 0M12 12.75h.008v.008H12v-.008z"/></svg>
                {{ funcionarioLogado.cargo ?? 'Funcionário' }}
              </span>
              <span class="inline-flex items-center gap-1 text-xs font-bold bg-white/10 border border-white/15 text-white px-3 py-1.5 rounded-xl">
                <span class="w-2 h-2 rounded-full bg-green-400" />
                {{ minhasAtividades.length }} atividade(s)
              </span>
            </div>
          </div>

          <!-- Stats rápidos -->
          <div v-if="funcionarioLogado && !loadingAtividades" class="grid grid-cols-2 sm:grid-cols-4 gap-3 mt-5">
            <div class="flex flex-col gap-1 bg-white/10 backdrop-blur-sm rounded-2xl px-4 py-3 border border-white/10">
              <span class="text-[10px] font-bold text-amber-300 uppercase tracking-widest">Pendentes</span>
              <span class="text-xl font-black text-white">{{ countAtivStatus('pendente') }}</span>
            </div>
            <div class="flex flex-col gap-1 bg-white/10 backdrop-blur-sm rounded-2xl px-4 py-3 border border-white/10">
              <span class="text-[10px] font-bold text-blue-300 uppercase tracking-widest">Em Andamento</span>
              <span class="text-xl font-black text-white">{{ countAtivStatus('em_andamento') }}</span>
            </div>
            <div class="flex flex-col gap-1 bg-white/10 backdrop-blur-sm rounded-2xl px-4 py-3 border border-white/10">
              <span class="text-[10px] font-bold text-green-300 uppercase tracking-widest">Concluídas</span>
              <span class="text-xl font-black text-white">{{ countAtivStatus('concluida') }}</span>
            </div>
            <div class="flex flex-col gap-1 bg-white/10 backdrop-blur-sm rounded-2xl px-4 py-3 border border-white/10">
              <span class="text-[10px] font-bold text-red-300 uppercase tracking-widest">Urgentes</span>
              <span class="text-xl font-black text-white">{{ minhasAtividades.filter(a => a.prioridade === 'urgente').length }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Sem funcionário vinculado -->
      <div v-if="!loadingAtividades && !funcionarioLogado" class="flex flex-col items-center justify-center py-24 gap-4">
        <div class="w-16 h-16 rounded-2xl bg-amber-50 border border-amber-100 flex items-center justify-center">
          <svg class="w-8 h-8 text-amber-400" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/></svg>
        </div>
        <div class="text-center">
          <p class="text-base font-bold text-gray-700">Nenhum funcionário vinculado</p>
          <p class="text-sm text-gray-400 mt-1">Peça ao administrador para cadastrar seu e-mail na ficha de funcionário.</p>
        </div>
      </div>

      <!-- Loading -->
      <div v-else-if="loadingAtividades" class="flex items-center justify-center py-24">
        <span class="inline-block w-10 h-10 border-4 border-green-500 border-t-transparent rounded-full animate-spin" />
      </div>

      <!-- Tabs e lista de atividades -->
      <template v-else-if="funcionarioLogado">
        <!-- Tabs -->
        <div class="flex gap-2 mb-6 overflow-x-auto pb-1">
          <button
            v-for="tab in tabs"
            :key="tab.value"
            type="button"
            class="shrink-0 inline-flex items-center gap-2 px-4 py-2.5 rounded-xl text-sm font-bold transition-all duration-150"
            :class="tabAtiva === tab.value
              ? 'bg-green-700 text-white shadow-md'
              : 'bg-white text-gray-600 border border-gray-200 hover:border-green-400 hover:text-green-700'"
            @click="tabAtiva = tab.value"
          >
            {{ tab.label }}
            <span
              class="inline-flex items-center justify-center min-w-[20px] h-5 px-1 rounded-full text-xs font-black"
              :class="tabAtiva === tab.value ? 'bg-white/20 text-white' : 'bg-gray-100 text-gray-600'"
            >
              {{ atividadesPorTab(tab.value).length }}
            </span>
          </button>
        </div>

        <!-- Frase motivacional -->
        <div v-if="funcionarioLogado" class="mb-5 flex items-center gap-3 px-4 py-3 rounded-2xl bg-gradient-to-r from-green-50 to-emerald-50 border border-green-100">
          <div class="shrink-0 w-8 h-8 rounded-xl bg-green-600 flex items-center justify-center">
            <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3.75 13.5l10.5-11.25L12 10.5h8.25L9.75 21.75 12 13.5H3.75z"/></svg>
          </div>
          <p class="text-sm font-semibold text-green-800 leading-snug">{{ fraseAtual }}</p>
        </div>

        <!-- Cards de atividades -->
        <div v-if="atividadesPorTab(tabAtiva).length === 0" class="flex flex-col items-center justify-center py-20 gap-3">
          <svg class="w-14 h-14 text-gray-300" fill="none" stroke="currentColor" stroke-width="1.25" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
          </svg>
          <span class="text-base font-semibold text-gray-400">Nenhuma atividade para este período</span>
        </div>

        <template v-else>
          <!-- Ativas -->
          <div v-if="ativasTab(tabAtiva).length > 0" class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-4">
          <div
            v-for="at in ativasTab(tabAtiva)"
            :key="at.id"
            class="group bg-white rounded-2xl border shadow-sm hover:shadow-md transition-all duration-200 overflow-hidden relative"
            :class="at.status === 'em_andamento'
              ? 'border-blue-300 ring-2 ring-blue-100'
              : at.prioridade === 'urgente' ? 'border-red-200' : 'border-gray-100'"
          >
            <!-- Borda topo: barra animada se em andamento, cor de prioridade caso contrário -->
            <div v-if="at.status === 'em_andamento'" class="h-1 w-full bg-blue-100 overflow-hidden">
              <div class="h-full bg-gradient-to-r from-blue-400 via-blue-600 to-blue-400 animate-[progress_2s_ease-in-out_infinite]" style="background-size:200% 100%" />
            </div>
            <div v-else class="h-1" :class="prioridadeAccent(at.prioridade)" />

            <!-- Cabeçalho premium do título -->
            <div class="relative px-5 pt-4 pb-3 bg-gradient-to-r from-green-950 via-green-800 to-green-700 overflow-hidden">
              <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_top_right,rgba(255,255,255,0.12),transparent_65%)]" />
              <div class="absolute -top-4 -right-4 w-16 h-16 rounded-full bg-white/5" />
              <div class="relative flex items-start justify-between gap-2">
                <h3 class="font-black text-white text-sm leading-snug tracking-tight drop-shadow-sm">{{ at.titulo }}</h3>
                <span :class="['shrink-0 inline-flex items-center gap-1 text-[11px] font-bold px-2 py-0.5 rounded-full border',
                  at.status === 'em_andamento' ? 'bg-blue-500/20 border-blue-400/40 text-blue-200' :
                  at.status === 'pendente'     ? 'bg-amber-500/20 border-amber-400/40 text-amber-200' :
                  'bg-white/10 border-white/20 text-white/80']">
                  <span v-if="at.status === 'em_andamento'" class="relative flex w-2 h-2">
                    <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-blue-300 opacity-75" />
                    <span class="relative inline-flex rounded-full w-2 h-2 bg-blue-300" />
                  </span>
                  <span v-else :class="['w-1.5 h-1.5 rounded-full', statusDotClass(at.status)]" />
                  {{ statusLabel(at.status) }}
                </span>
              </div>
              <p v-if="at.descricao" class="relative mt-1.5 text-xs text-green-100/75 leading-relaxed line-clamp-2">{{ at.descricao }}</p>
            </div>

            <div class="px-5 py-4 flex flex-col gap-3">
              <div class="flex flex-wrap gap-2">
                <span :class="['inline-flex items-center gap-1 text-[11px] font-bold px-2 py-0.5 rounded-full', prioridadeBadgeClass(at.prioridade)]">
                  {{ prioridadeLabel(at.prioridade) }}
                </span>
                <span :class="['inline-flex items-center gap-1 text-[11px] font-bold px-2 py-0.5 rounded-full', periodicidadeBadgeClass(at.periodicidade)]">
                  {{ periodicidadeLabel(at.periodicidade) }}
                </span>
              </div>

              <div class="flex items-center justify-between pt-1 border-t border-gray-50">
                <div class="flex items-center gap-1.5 text-xs text-gray-400">
                  <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25m-18 0A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75m-18 0v-7.5A2.25 2.25 0 015.25 9h13.5A2.25 2.25 0 0121 9v7.5"/></svg>
                  {{ at.data_atividade ? formatarData(at.data_atividade) : 'Sem data definida' }}
                </div>
                <div v-if="at.hora_inicio" class="flex items-center gap-1 text-xs text-gray-400">
                  <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path stroke-linecap="round" stroke-linejoin="round" d="M12 6.75v5.25l3 1.5"/></svg>
                  {{ at.hora_inicio }}{{ at.hora_fim ? ` �?" ${at.hora_fim}` : '' }}
                </div>
              </div>

              <p v-if="at.observacao" class="text-xs text-gray-400 italic border-t border-gray-50 pt-2">{{ at.observacao }}</p>

              <!-- Botão alterar status -->
              <div class="flex gap-2 pt-1" v-if="at.status !== 'concluida' && at.status !== 'cancelada'">
                <button
                  v-if="at.status === 'pendente'"
                  type="button"
                  class="flex-1 text-xs font-bold py-2 rounded-xl bg-blue-50 text-blue-700 hover:bg-blue-100 border border-blue-100 transition-colors"
                  :disabled="atualizando === at.id"
                  @click="alterarStatus(at, 'em_andamento')"
                >
                  {{ atualizando === at.id ? '...' : 'Iniciar' }}
                </button>
                <button
                  v-if="at.status === 'em_andamento'"
                  type="button"
                  class="flex-1 inline-flex items-center justify-center gap-1.5 text-xs font-bold py-2 rounded-xl bg-green-50 text-green-700 hover:bg-green-100 border border-green-100 transition-colors"
                  :disabled="atualizando === at.id"
                  @click="alterarStatus(at, 'concluida')"
                >
                  <svg v-if="atualizando !== at.id" class="w-3.5 h-3.5 animate-spin text-green-500" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v4a4 4 0 00-4 4H4z"/>
                  </svg>
                  {{ atualizando === at.id ? '...' : 'Concluir' }}
                </button>
              </div>
              <div v-else-if="at.status === 'concluida'" class="flex items-center gap-1.5 text-xs font-bold text-green-600 pt-1">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                Concluída
              </div>
            </div>
          </div>
          </div>

          <!-- Banner: tudo concluído nesta aba -->
          <div
            v-if="ativasTab(tabAtiva).length === 0 && concluidasTab(tabAtiva).length > 0"
            class="mb-6 relative overflow-hidden rounded-2xl bg-gradient-to-r from-green-600 via-emerald-500 to-green-500 p-5 shadow-lg"
          >
            <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_top_right,rgba(255,255,255,0.2),transparent_60%)]" />
            <div class="absolute -top-6 -right-6 w-28 h-28 rounded-full bg-white/10 pointer-events-none" />
            <div class="relative flex items-center gap-4">
              <div class="shrink-0 w-14 h-14 rounded-2xl bg-white/20 border border-white/30 flex items-center justify-center text-3xl select-none">
                �Y�?
              </div>
              <div>
                <p class="text-base font-black text-white leading-tight">Parabéns, {{ funcionarioLogado ? primeiroNome(funcionarioLogado.nome) : 'campeão' }}!</p>
                <p class="text-sm text-green-100/90 mt-0.5">Todas as tarefas desta aba foram concluídas. Excelente trabalho! Continue assim! 🎉</p>
              </div>
            </div>
          </div>

          <!-- Divisor Concluídas -->
          <div v-if="concluidasTab(tabAtiva).length > 0" class="mt-8">
            <div class="flex items-center gap-3 mb-4">
              <div class="flex-1 h-px bg-gray-200" />
              <span class="inline-flex items-center gap-1.5 text-xs font-bold text-green-700 bg-green-50 border border-green-100 px-3 py-1 rounded-full">
                <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                Concluídas ({{ concluidasTab(tabAtiva).length }})
              </span>
              <div class="flex-1 h-px bg-gray-200" />
            </div>
            <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-4 opacity-70">
              <div
                v-for="at in concluidasTab(tabAtiva)"
                :key="at.id"
                class="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden"
              >
                <!-- Header concluída neutro -->
                <div class="px-5 pt-4 pb-3 bg-gray-50 border-b border-gray-100">
                  <div class="flex items-start justify-between gap-2">
                    <div class="flex items-start gap-2">
                      <svg class="w-4 h-4 text-green-500 shrink-0 mt-0.5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                      <h3 class="font-semibold text-gray-400 text-sm leading-snug line-through decoration-gray-300">{{ at.titulo }}</h3>
                    </div>
                    <span class="shrink-0 inline-flex items-center gap-1 text-[11px] font-bold px-2 py-0.5 rounded-full bg-green-100 text-green-700">
                      <span class="w-1.5 h-1.5 rounded-full bg-green-500" />
                      Concluída
                    </span>
                  </div>
                  <p v-if="at.descricao" class="mt-1 text-xs text-gray-400 leading-relaxed line-clamp-2">{{ at.descricao }}</p>
                </div>

                <div class="px-5 py-3 flex flex-wrap gap-2">
                  <span :class="['inline-flex items-center gap-1 text-[11px] font-bold px-2 py-0.5 rounded-full', prioridadeBadgeClass(at.prioridade)]">
                    {{ prioridadeLabel(at.prioridade) }}
                  </span>
                  <span :class="['inline-flex items-center gap-1 text-[11px] font-bold px-2 py-0.5 rounded-full', periodicidadeBadgeClass(at.periodicidade)]">
                    {{ periodicidadeLabel(at.periodicidade) }}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </template>
      </template>
    </template>

    <!-- �.��.��.��.��.��.��.��.��.��.��.� VIS�fO ADMIN �.��.��.��.��.��.��.��.��.��.��.� -->
    <template v-if="!adminLoading && isAdmin">

      <!-- Header compacto -->
      <section class="relative overflow-hidden rounded-3xl bg-gradient-to-br from-green-950 via-green-800 to-green-600 shadow-xl mb-6">
        <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_top_right,rgba(255,255,255,0.15),transparent_60%)]" />
        <div class="absolute -top-12 -right-12 w-48 h-48 rounded-full bg-white/5 pointer-events-none" />
        <div class="relative px-6 sm:px-10 py-6 flex items-center justify-between gap-4">
          <div>
            <p class="text-[11px] font-bold uppercase tracking-[0.25em] text-green-300 mb-1">PetFlow · Painel Admin</p>
            <h1 class="text-xl sm:text-3xl font-black text-white leading-tight">Visão Geral do Negócio</h1>
            <p class="text-sm text-green-100/70 mt-1">{{ dataHoje }}</p>
          </div>
          <div class="shrink-0 w-14 h-14 rounded-2xl bg-white/10 border border-white/20 flex items-center justify-center">
            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M3 13.125C3 12.504 3.504 12 4.125 12h2.25c.621 0 1.125.504 1.125 1.125v6.75C7.5 20.496 6.996 21 6.375 21h-2.25A1.125 1.125 0 013 19.875v-6.75zM9.75 8.625c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125v11.25c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V8.625zM16.5 4.125c0-.621.504-1.125 1.125-1.125h2.25C20.496 3 21 3.504 21 4.125v15.75c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V4.125z"/>
            </svg>
          </div>
        </div>
      </section>

      <!-- �"?�"? Financeiro �"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"? -->
      <div class="mb-3 flex items-center gap-2 px-1">
        <span class="text-[11px] font-black uppercase tracking-widest text-gray-400">Financeiro</span>
        <div class="flex-1 h-px bg-gray-200" />
      </div>
      <div class="grid grid-cols-2 xl:grid-cols-4 gap-3 sm:gap-4 mb-6">

        <!-- Faturamento -->
        <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-green-600 to-green-700 p-4 shadow-md">
          <div class="absolute -top-4 -right-4 w-20 h-20 rounded-full bg-white/10 pointer-events-none" />
          <div class="flex items-center gap-2 mb-3">
            <div class="w-8 h-8 rounded-xl bg-white/15 flex items-center justify-center shrink-0">
              <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12c-.725 0-1.45-.22-2.003-.659-1.106-.879-1.106-2.303 0-3.182s2.9-.879 4.006 0l.415.33M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
            </div>
            <span class="text-[10px] font-black uppercase tracking-widest text-green-100">Faturamento / Mês</span>
          </div>
          <p class="text-lg sm:text-2xl font-black text-white truncate">{{ resumoLoading ? '...' : formatCurrency(faturamentoMes) }}</p>
          <p class="text-[11px] text-green-100/70 mt-1">vendas confirmadas</p>
        </div>

        <!-- Pedidos do mês -->
        <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-orange-500 to-orange-600 p-4 shadow-md">
          <div class="absolute -top-4 -right-4 w-20 h-20 rounded-full bg-white/10 pointer-events-none" />
          <div class="flex items-center gap-2 mb-3">
            <div class="w-8 h-8 rounded-xl bg-white/15 flex items-center justify-center shrink-0">
              <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 14.25l6-6m4.5-3.493V21.75l-3.75-1.5-3.75 1.5-3.75-1.5-3.75 1.5V4.757c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0111.186 0c1.1.128 1.907 1.077 1.907 2.185z"/></svg>
            </div>
            <span class="text-[10px] font-black uppercase tracking-widest text-orange-100">Pedidos / Mês</span>
          </div>
          <p class="text-2xl font-black text-white">{{ resumoLoading ? '...' : vendasMes }}</p>
          <p class="text-[11px] text-orange-100/70 mt-1">pedidos este mês</p>
        </div>

        <!-- Contas a pagar -->
        <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-violet-600 to-violet-700 p-4 shadow-md">
          <div class="absolute -top-4 -right-4 w-20 h-20 rounded-full bg-white/10 pointer-events-none" />
          <div class="flex items-center gap-2 mb-3">
            <div class="w-8 h-8 rounded-xl bg-white/15 flex items-center justify-center shrink-0">
              <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 8.25h19.5M2.25 9h19.5m-16.5 5.25h6m-6 2.25h3m-3.75 3h15a2.25 2.25 0 002.25-2.25V6.75A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25v10.5A2.25 2.25 0 004.5 19.5z"/></svg>
            </div>
            <span class="text-[10px] font-black uppercase tracking-widest text-violet-100">Contas a Pagar</span>
          </div>
          <p class="text-lg sm:text-xl font-black text-white truncate">{{ resumoLoading ? '...' : formatCurrency(valorContasPagar) }}</p>
          <div class="flex items-center gap-1.5 mt-1">
            <span class="text-[11px] text-violet-100/70">em aberto</span>
            <span class="inline-flex items-center justify-center text-[10px] font-black px-1.5 py-0.5 rounded-full bg-white/20 text-white">
              {{ resumoLoading ? '...' : totalContasPagar }} conta{{ totalContasPagar !== 1 ? 's' : '' }}
            </span>
          </div>
        </div>

        <!-- Contas vencidas -->
        <div
          class="relative overflow-hidden rounded-2xl p-4 shadow-md transition-colors"
          :class="contasVencidas > 0 ? 'bg-gradient-to-br from-red-500 to-red-600' : 'bg-gradient-to-br from-slate-500 to-slate-600'"
        >
          <div class="absolute -top-4 -right-4 w-20 h-20 rounded-full bg-white/10 pointer-events-none" />
          <div class="flex items-center gap-2 mb-3">
            <div class="w-8 h-8 rounded-xl bg-white/15 flex items-center justify-center shrink-0">
              <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/></svg>
            </div>
            <span class="text-[10px] font-black uppercase tracking-widest text-red-100">Vencidas</span>
          </div>
          <p class="text-2xl font-black text-white flex items-center gap-2">
            {{ resumoLoading ? '...' : contasVencidas }}
            <span v-if="contasVencidas > 0" class="inline-block w-2 h-2 rounded-full bg-white animate-ping" />
          </p>
          <p class="text-[11px] text-white/70 mt-1">{{ contasVencidas > 0 ? 'atenção necessária' : 'tudo em dia ✅' }}</p>
        </div>
      </div>

      <!-- �"?�"? Operacional �"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"? -->
      <div class="mb-3 flex items-center gap-2 px-1">
        <span class="text-[11px] font-black uppercase tracking-widest text-gray-400">Operacional</span>
        <div class="flex-1 h-px bg-gray-200" />
      </div>
      <div class="grid grid-cols-2 xl:grid-cols-4 gap-3 sm:gap-4 mb-8">

        <div class="rounded-2xl bg-white border border-gray-100 shadow-sm p-4 flex flex-col gap-1">
          <div class="flex items-center justify-between mb-1">
            <span class="text-[10px] font-black uppercase tracking-widest text-violet-500">Total Clientes</span>
            <div class="w-7 h-7 rounded-xl bg-violet-50 flex items-center justify-center">
              <svg class="w-4 h-4 text-violet-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z"/></svg>
            </div>
          </div>
          <p class="text-2xl font-black text-gray-800">{{ resumoLoading ? '...' : totalClientes }}</p>
          <p class="text-[11px] text-gray-400">cadastrados no sistema</p>
        </div>

        <div class="rounded-2xl bg-white border border-gray-100 shadow-sm p-4 flex flex-col gap-1">
          <div class="flex items-center justify-between mb-1">
            <span class="text-[10px] font-black uppercase tracking-widest text-emerald-500">Clientes Ativos</span>
            <div class="w-7 h-7 rounded-xl bg-emerald-50 flex items-center justify-center">
              <svg class="w-4 h-4 text-emerald-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
            </div>
          </div>
          <p class="text-2xl font-black text-gray-800">{{ resumoLoading ? '...' : clientesAtivos }}</p>
          <p class="text-[11px] text-gray-400">{{ resumoLoading || totalClientes === 0 ? '' : Math.round(clientesAtivos / totalClientes * 100) + '% do total' }}</p>
        </div>

        <div class="rounded-2xl bg-white border border-gray-100 shadow-sm p-4 flex flex-col gap-1">
          <div class="flex items-center justify-between mb-1">
            <span class="text-[10px] font-black uppercase tracking-widest text-blue-500">Tarefas Hoje</span>
            <div class="w-7 h-7 rounded-xl bg-blue-50 flex items-center justify-center">
              <svg class="w-4 h-4 text-blue-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"/></svg>
            </div>
          </div>
          <p class="text-2xl font-black text-gray-800">{{ resumoLoading ? '...' : tarefasHoje }}</p>
          <p class="text-[11px] text-gray-400">{{ resumoLoading ? '' : tarefasConcluidasHoje + ' concluídas hoje' }}</p>
        </div>

        <div class="rounded-2xl bg-white border border-gray-100 shadow-sm p-4 flex flex-col gap-1">
          <div class="flex items-center justify-between mb-1">
            <span class="text-[10px] font-black uppercase tracking-widest text-amber-500">Tarefas Pendentes</span>
            <div class="w-7 h-7 rounded-xl bg-amber-50 flex items-center justify-center">
              <svg class="w-4 h-4 text-amber-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6h4.5m4.5 0a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
            </div>
          </div>
          <p class="text-2xl font-black text-gray-800">{{ resumoLoading ? '...' : tarefasPendentes }}</p>
          <p class="text-[11px] text-gray-400">aguardando início</p>
        </div>
      </div>

      <!-- �"?�"? Atalhos compactos �"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"? -->
      <div class="mb-3 flex items-center gap-2 px-1">
        <span class="text-[11px] font-black uppercase tracking-widest text-gray-400">Atalhos</span>
        <div class="flex-1 h-px bg-gray-200" />
      </div>
      <div class="grid grid-cols-3 sm:grid-cols-5 gap-2 sm:gap-3">
        <NuxtLink
          v-for="atalho in atalhosVisiveis"
          :key="atalho.to"
          :to="atalho.to"
          class="group flex flex-col items-center gap-2 py-4 px-2 rounded-2xl border border-gray-100 bg-white hover:border-green-200 hover:shadow-md transition-all duration-200 hover:-translate-y-0.5"
        >
          <div
            class="w-10 h-10 rounded-xl flex items-center justify-center border transition-transform duration-200 group-hover:scale-110"
            :class="atalho.iconBg"
          >
            <AppNavIcon :name="atalho.icon" class="w-5 h-5" :class="atalho.iconColor" />
          </div>
          <span class="text-[11px] font-bold text-gray-600 text-center leading-tight group-hover:text-gray-800">{{ atalho.title }}</span>
        </NuxtLink>
      </div>

    </template>

    <!-- Loading inicial -->
    <div v-if="adminLoading" class="flex items-center justify-center py-32">
      <span class="inline-block w-10 h-10 border-4 border-green-500 border-t-transparent rounded-full animate-spin" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { useAdmin } from '~/composables/useAdmin'
import { createSupabaseClient } from '~/lib/supabase'
import AppNavIcon from '~/components/AppNavIcon.vue'

const supabase = createSupabaseClient()
const { isAdmin, adminLoading } = useAdmin()

// �"?�"? ADMIN: resumo �"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?
const resumoLoading      = ref(true)
const totalClientes      = ref(0)
const clientesAtivos     = ref(0)
const vendasMes          = ref(0)
const faturamentoMes     = ref(0)
const totalContasPagar   = ref(0)
const valorContasPagar   = ref(0)
const contasVencidas     = ref(0)
const tarefasHoje        = ref(0)
const tarefasConcluidasHoje = ref(0)
const tarefasPendentes   = ref(0)

// �"?�"? FUNCIONÁRIO: atividades �"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?
interface AtividadeFuncionario {
  id: number
  titulo: string
  descricao: string | null
  status: string | null
  prioridade: string | null
  periodicidade: string | null
  data_atividade: string | null
  hora_inicio: string | null
  hora_fim: string | null
  observacao: string | null
}
interface FuncionarioLite { id: number; nome: string; cargo: string | null }

const funcionarioLogado  = ref<FuncionarioLite | null>(null)
const minhasAtividades   = ref<AtividadeFuncionario[]>([])
const loadingAtividades  = ref(true)
const atualizando        = ref<number | null>(null)
const tabAtiva           = ref<'hoje' | 'semana' | 'quinzena' | 'mes'>('hoje')

const tabs = [
  { label: 'Hoje',     value: 'hoje'     },
  { label: 'Semana',   value: 'semana'   },
  { label: 'Quinzena', value: 'quinzena' },
  { label: 'Mês',      value: 'mes'      },
] as const

// �"?�"? Datas de referência �"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?
const hoje = new Date()
hoje.setHours(0, 0, 0, 0)

const dataHoje = hoje.toLocaleDateString('pt-BR', { weekday: 'long', day: '2-digit', month: 'long', year: 'numeric' })

function toISODate(d: Date) {
  return d.toISOString().slice(0, 10)
}

function inicioSemana(): Date {
  const d = new Date(hoje)
  const dia = d.getDay() // 0=Dom
  d.setDate(d.getDate() - dia)
  return d
}
function fimSemana(): Date {
  const d = new Date(inicioSemana())
  d.setDate(d.getDate() + 6)
  return d
}
function inicioQuinzena(): Date {
  const d = new Date(hoje)
  d.setDate(hoje.getDate() <= 15 ? 1 : 16)
  return d
}
function fimQuinzena(): Date {
  const d = new Date(hoje)
  if (hoje.getDate() <= 15) {
    d.setDate(15)
  } else {
    d.setMonth(d.getMonth() + 1, 0) // último dia do mês
  }
  return d
}
function inicioMes(): Date {
  return new Date(hoje.getFullYear(), hoje.getMonth(), 1)
}
function fimMes(): Date {
  return new Date(hoje.getFullYear(), hoje.getMonth() + 1, 0)
}

function ativasTab(tab: string): AtividadeFuncionario[] {
  return atividadesPorTab(tab).filter(a => a.status !== 'concluida' && a.status !== 'cancelada')
}
function concluidasTab(tab: string): AtividadeFuncionario[] {
  return atividadesPorTab(tab).filter(a => a.status === 'concluida')
}

const frasesMotivacionais = [
  'Cada tarefa concluída é um passo rumo à excelência!',
  'Foco total, resultado certo. Vamos lá!',
  'Organização é o segredo de quem vai longe!',
  'Um animal bem cuidado começa com uma tarefa realizada.',
  'Consistência supera talento todos os dias.',
  'Hoje é um ótimo dia para dar o seu melhor!',
  'Pequenas ações, grandes resultados.',
  'Produtividade é fazer as coisas certas com dedicação.',
]
const fraseAtual = computed(() => {
  const idx = new Date().getDate() % frasesMotivacionais.length
  return frasesMotivacionais[idx]
})

function atividadesPorTab(tab: string): AtividadeFuncionario[] {
  const todaIso = toISODate(hoje)
  return minhasAtividades.value.filter(a => {
    const dataAtiv = a.data_atividade
    if (tab === 'hoje') {
      // diárias de hoje OU sem data definida com periodicidade diária
      if (a.periodicidade === 'diaria') {
        return !dataAtiv || dataAtiv === todaIso
      }
      return dataAtiv === todaIso
    }
    if (tab === 'semana') {
      if (a.periodicidade !== 'diaria') return false
      if (!dataAtiv) return true // recorrente diária sem data fixa
      return dataAtiv >= toISODate(inicioSemana()) && dataAtiv <= toISODate(fimSemana())
    }
    if (tab === 'quinzena') {
      if (a.periodicidade !== 'quinzenal') return false
      if (!dataAtiv) return true
      return dataAtiv >= toISODate(inicioQuinzena()) && dataAtiv <= toISODate(fimQuinzena())
    }
    if (tab === 'mes') {
      if (a.periodicidade !== 'mensal') return false
      if (!dataAtiv) return true
      return dataAtiv >= toISODate(inicioMes()) && dataAtiv <= toISODate(fimMes())
    }
    return false
  })
}

function countAtivStatus(s: string) {
  return minhasAtividades.value.filter(a => a.status === s).length
}

function primeiroNome(nome: string) {
  return nome.split(' ')[0]
}

function formatarData(iso: string): string {
  const [y, m, d] = iso.split('-')
  return `${d}/${m}/${y}`
}

function statusLabel(s: string | null) {
  if (s === 'pendente')     return 'Pendente'
  if (s === 'em_andamento') return 'Em Andamento'
  if (s === 'concluida')    return 'Concluída'
  if (s === 'cancelada')    return 'Cancelada'
  return s ?? '�?"'
}
function statusBadgeClass(s: string | null) {
  if (s === 'pendente')     return 'bg-amber-100 text-amber-700'
  if (s === 'em_andamento') return 'bg-blue-100 text-blue-700'
  if (s === 'concluida')    return 'bg-green-100 text-green-700'
  if (s === 'cancelada')    return 'bg-red-100 text-red-700'
  return 'bg-gray-100 text-gray-500'
}
function statusDotClass(s: string | null) {
  if (s === 'pendente')     return 'bg-amber-500'
  if (s === 'em_andamento') return 'bg-blue-500'
  if (s === 'concluida')    return 'bg-green-500'
  if (s === 'cancelada')    return 'bg-red-500'
  return 'bg-gray-400'
}
function prioridadeLabel(p: string | null) {
  if (p === 'baixa')   return 'Baixa'
  if (p === 'media')   return 'Média'
  if (p === 'alta')    return 'Alta'
  if (p === 'urgente') return 'Urgente'
  return p ?? '�?"'
}
function prioridadeBadgeClass(p: string | null) {
  if (p === 'baixa')   return 'bg-gray-100 text-gray-600'
  if (p === 'media')   return 'bg-sky-100 text-sky-700'
  if (p === 'alta')    return 'bg-orange-100 text-orange-700'
  if (p === 'urgente') return 'bg-red-100 text-red-700'
  return 'bg-gray-100 text-gray-500'
}
function prioridadeAccent(p: string | null) {
  if (p === 'baixa')   return 'bg-gray-300'
  if (p === 'media')   return 'bg-sky-400'
  if (p === 'alta')    return 'bg-orange-400'
  if (p === 'urgente') return 'bg-red-500'
  return 'bg-gray-200'
}
function periodicidadeLabel(p: string | null) {
  if (p === 'diaria')    return 'Diária'
  if (p === 'quinzenal') return 'Quinzenal'
  if (p === 'mensal')    return 'Mensal'
  return p ?? '�?"'
}
function periodicidadeBadgeClass(p: string | null) {
  if (p === 'diaria')    return 'bg-violet-100 text-violet-700'
  if (p === 'quinzenal') return 'bg-teal-100 text-teal-700'
  if (p === 'mensal')    return 'bg-rose-100 text-rose-700'
  return 'bg-gray-100 text-gray-500'
}

async function alterarStatus(at: AtividadeFuncionario, novoStatus: string) {
  atualizando.value = at.id
  await supabase.from('atividades_funcionarios').update({ status: novoStatus }).eq('id', at.id)
  at.status = novoStatus
  atualizando.value = null
}

// �"?�"? Fetch �"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?
onMounted(async () => {
  const { data: { session } } = await supabase.auth.getSession()
  const email = session?.user?.email

  // Funcionário: buscar pelo email
  if (email && email !== 'admin@zoocultura.com') {
    const { data: func } = await supabase
      .from('funcionarios')
      .select('id, nome, cargo')
      .ilike('email', email)
      .maybeSingle()

    if (func) {
      funcionarioLogado.value = func as FuncionarioLite
      const { data: ativs } = await supabase
        .from('atividades_funcionarios')
        .select('id, titulo, descricao, status, prioridade, periodicidade, data_atividade, hora_inicio, hora_fim, observacao')
        .eq('funcionario_id', func.id)
        .order('data_atividade', { ascending: true })
      minhasAtividades.value = (ativs ?? []) as AtividadeFuncionario[]
    }
    loadingAtividades.value = false
    resumoLoading.value = false
    return
  }

  // Admin: buscar resumo
  loadingAtividades.value = false
  const todayIso = new Date().toISOString().slice(0, 10)
  const [clientesResp, vendasResp, contasResp, tarefasResp] = await Promise.all([
    supabase.from('clientes').select('ativo'),
    supabase.from('vendas').select('valor_total, data_venda, status'),
    supabase.from('contas_pagar').select('valor, data_vencimento, status'),
    supabase.from('atividades_funcionarios').select('status, data_atividade').eq('data_atividade', todayIso),
  ])

  if (!clientesResp.error) {
    const clientes = clientesResp.data ?? []
    totalClientes.value = clientes.length
    clientesAtivos.value = clientes.filter(c => c.ativo !== false).length
  }

  if (!vendasResp.error) {
    const vendas = vendasResp.data ?? []
    const now = new Date()
    const vendasNoMes = vendas.filter(v => {
      if (!v.data_venda) return false
      const d = new Date(v.data_venda)
      return d.getFullYear() === now.getFullYear() && d.getMonth() === now.getMonth()
    })
    vendasMes.value = vendasNoMes.length
    faturamentoMes.value = vendasNoMes
      .filter(v => v.status !== 'cancelada')
      .reduce((sum, v) => sum + Number(v.valor_total ?? 0), 0)
  }

  if (!contasResp.error) {
    const contas = (contasResp.data ?? []).filter(c => c.status !== 'pago' && c.status !== 'cancelado')
    totalContasPagar.value = contas.length
    valorContasPagar.value = contas.reduce((sum, c) => sum + Number(c.valor ?? 0), 0)
    contasVencidas.value = contas.filter(c => c.data_vencimento && c.data_vencimento < todayIso).length
  }

  if (!tarefasResp.error) {
    const tf = tarefasResp.data ?? []
    tarefasHoje.value = tf.length
    tarefasConcluidasHoje.value = tf.filter(t => t.status === 'concluida').length
    tarefasPendentes.value = tf.filter(t => t.status === 'pendente').length
  }

  resumoLoading.value = false
})

function formatCurrency(val: number): string {
  return val.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })
}

const atalhos = [
  {
    to: '/clientes',
    icon: 'identification',
    title: 'Clientes',
    description: 'Gerencie cadastros, contatos e informações de relacionamento.',
    adminOnly: false,
    accent: 'bg-violet-500',
    iconBg: 'bg-violet-50 border-violet-100',
    iconColor: 'text-violet-600',
    badge: 'bg-violet-50 text-violet-700',
  },
  {
    to: '/vendas',
    icon: 'receipt',
    title: 'Vendas',
    description: 'Registre vendas com itens e subtotais de forma rápida e segura.',
    adminOnly: false,
    accent: 'bg-orange-500',
    iconBg: 'bg-orange-50 border-orange-100',
    iconColor: 'text-orange-600',
    badge: 'bg-orange-50 text-orange-700',
  },
  {
    to: '/produtos',
    icon: 'package',
    title: 'Produtos',
    description: 'Acompanhe estoque, categorias, preços e status dos itens.',
    adminOnly: false,
    accent: 'bg-blue-500',
    iconBg: 'bg-blue-50 border-blue-100',
    iconColor: 'text-blue-600',
    badge: 'bg-blue-50 text-blue-700',
  },
  {
    to: '/funcionarios',
    icon: 'users',
    title: 'Funcionários',
    description: 'Organize dados da equipe e mantenha o controle operacional.',
    adminOnly: true,
    accent: 'bg-emerald-500',
    iconBg: 'bg-emerald-50 border-emerald-100',
    iconColor: 'text-emerald-600',
    badge: 'bg-emerald-50 text-emerald-700',
  },
  {
    to: '/contas-pagar',
    icon: 'wallet',
    title: 'Contas a Pagar',
    description: 'Monitore vencimentos, status e planejamento financeiro.',
    adminOnly: true,
    accent: 'bg-rose-500',
    iconBg: 'bg-rose-50 border-rose-100',
    iconColor: 'text-rose-600',
    badge: 'bg-rose-50 text-rose-700',
  },
] as const

const atalhosVisiveis = computed(() =>
  atalhos.filter(item => !item.adminOnly || isAdmin.value)
)
</script>
