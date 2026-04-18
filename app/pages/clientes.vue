<template>
  <div class="min-h-full bg-transparent p-3 sm:p-8">

    <!-- �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� CABE�?ALHO �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� -->
    <div class="relative rounded-3xl overflow-hidden mb-8 shadow-xl">
      <div class="absolute inset-0 bg-gradient-to-br from-pink-600 via-pink-500 to-rose-400" />
      <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_top_right,rgba(255,70,162,0.18),transparent_60%)]" />
      <div class="absolute -top-16 -right-16 w-72 h-72 rounded-full bg-white/[0.03] pointer-events-none" />
      <div class="absolute -bottom-20 left-1/4 w-96 h-96 rounded-full bg-white/[0.02] pointer-events-none" />
      <PageLogo />

      <div class="relative px-4 sm:px-8 pt-5 sm:pt-7 pb-5 sm:pb-7">
        <div class="flex flex-wrap items-start justify-between gap-3 sm:gap-6">
          <div class="flex items-center gap-3 sm:gap-5">
            <div class="flex items-center justify-center w-10 sm:w-14 h-10 sm:h-14 rounded-2xl bg-white/[0.12] backdrop-blur-sm border border-white/20 shadow-lg">
              <svg class="w-5 sm:w-7 h-5 sm:h-7 text-white" fill="none" stroke="currentColor" stroke-width="1.75" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 9h3.75M15 12h3.75M15 15h3.75M4.5 19.5h15a2.25 2.25 0 002.25-2.25V6.75A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25v10.5A2.25 2.25 0 004.5 19.5zm6-10.125a1.875 1.875 0 11-3.75 0 1.875 1.875 0 013.75 0zm1.5 0a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm-1.5 6.75a3.375 3.375 0 00-6.75 0h6.75z"/></svg>
            </div>
            <div>
              <div class="flex items-center gap-2 mb-1">
                <span class="text-xs font-semibold text-white/80 uppercase tracking-widest">CRM</span>
                <span class="w-1 h-1 rounded-full bg-white/40" />
                <span class="text-xs text-white/70 hidden sm:inline">UpStudio</span>
              </div>
              <h1 class="text-xl sm:text-3xl font-bold text-white tracking-tight leading-none">Clientes</h1>
              <p class="text-sm text-white/80 mt-1.5">
                {{ loading ? 'Carregando...' : `${clientesFiltrados.length} de ${clientes.length} cliente(s) exibido(s)` }}
              </p>
            </div>
          </div>

          <div class="flex items-center gap-2 shrink-0">
            <button
              type="button"
              class="inline-flex items-center gap-2 text-sm font-semibold px-3 sm:px-5 py-2.5 rounded-xl transition-all duration-200"
              :class="filtroAberto
                ? 'bg-white text-[#ff46a2] shadow-lg scale-[1.02]'
                : 'bg-white/10 text-white hover:bg-white/20 border border-white/15 backdrop-blur-sm'"
              @click="filtroAberto = !filtroAberto"
            >
              <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2a1 1 0 01-.293.707L13 13.414V19a1 1 0 01-.553.894l-4 2A1 1 0 017 21v-7.586L3.293 6.707A1 1 0 013 6V4z"/></svg>
              <span class="hidden sm:inline">Filtros</span>
              <span v-if="filtrosAtivos > 0" class="inline-flex items-center justify-center min-w-[20px] h-5 px-1 rounded-full bg-white text-pink-400 text-xs font-black">{{ filtrosAtivos }}</span>
            </button>
            <button
              v-if="isAdminOrGerente"
              type="button"
              class="inline-flex items-center gap-2 text-sm font-bold px-3 sm:px-5 py-2.5 rounded-xl bg-white text-[#ff46a2] hover:bg-pink-50 shadow-lg shadow-pink-200/40 transition-all duration-200 hover:scale-[1.02]"
              @click="abrirAdicionar"
            >
              <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
              <span class="hidden sm:inline">Adicionar Cliente</span>
            </button>
          </div>
        </div>

        <div class="h-px bg-white/10 my-4 sm:my-6" />

        <!-- Stats -->
        <div v-if="!loading" class="grid grid-cols-2 sm:grid-cols-4 gap-3">
          <div class="flex flex-col gap-1 bg-white/10 backdrop-blur-sm rounded-2xl px-5 py-4 border border-white/10 hover:bg-white/15 transition-colors">
            <span class="text-xs font-semibold text-white/70 uppercase tracking-widest">Total</span>
            <span class="text-xl font-black text-white leading-tight">{{ clientes.length }}</span>
            <span class="text-xs text-white/50">cliente(s)</span>
          </div>
          <div class="flex flex-col gap-1 bg-white/10 rounded-2xl px-5 py-4 border border-white/10 hover:bg-white/15 transition-colors">
            <div class="flex items-center gap-1.5">
              <span class="w-2 h-2 rounded-full bg-white" />
              <span class="text-xs font-semibold text-white/70 uppercase tracking-widest">Ativos</span>
            </div>
            <span class="text-xl font-black text-white leading-tight">{{ clientesAtivos }}</span>
            <span class="text-xs text-white/50">habilitados</span>
          </div>
          <div class="flex flex-col gap-1 bg-white/[0.07] rounded-2xl px-5 py-4 border border-white/10 hover:bg-white/12 transition-colors">
            <span class="text-xs font-semibold text-white/70 uppercase tracking-widest">Com E-mail</span>
            <span class="text-xl font-black text-white leading-tight">{{ comEmail }}</span>
            <span class="text-xs text-white/50">de {{ clientes.length }} cadastrados</span>
          </div>
          <div class="flex flex-col gap-1 bg-white/[0.07] rounded-2xl px-5 py-4 border border-white/10 hover:bg-white/12 transition-colors">
            <span class="text-xs font-semibold text-white/70 uppercase tracking-widest">Cidades</span>
            <span class="text-xl font-black text-white leading-tight">{{ cidadesUnicas.length }}</span>
            <span class="text-xs text-white/50">distintas</span>
          </div>
        </div>
      </div>
    </div>

    <!-- �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� FILTRO �.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.��.� -->
    <Transition name="slide-fade">
      <div v-show="filtroAberto" class="bg-white rounded-3xl border border-gray-100 shadow-md mb-6 overflow-hidden">
        <div class="flex items-center justify-between px-7 py-4 border-b border-gray-100 bg-gray-50/70">
          <div class="flex items-center gap-2.5">
            <svg class="w-4 h-4 text-[#ff46a2]" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2a1 1 0 01-.293.707L13 13.414V19a1 1 0 01-.553.894l-4 2A1 1 0 017 21v-7.586L3.293 6.707A1 1 0 013 6V4z"/></svg>
            <span class="text-sm font-bold text-gray-700">Filtros</span>
          </div>
          <button v-if="filtrosAtivos > 0" type="button" class="text-xs font-semibold text-[#ff46a2] hover:text-pink-600 hover:underline" @click="limparFiltros">
            Limpar todos
          </button>
        </div>
        <div class="p-7 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
          <div class="sm:col-span-2 flex flex-col gap-1.5">
            <label class="text-xs font-bold text-gray-500 uppercase tracking-widest">Busca</label>
            <div class="relative">
              <svg class="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"/><path stroke-linecap="round" d="m21 21-4.35-4.35"/></svg>
              <input v-model="filtros.busca" type="text" placeholder="Nome, CPF/CNPJ, telefone ou e-mail..." class="w-full rounded-xl border border-gray-200 pl-10 pr-4 py-2.5 text-sm text-gray-800 placeholder:text-gray-400 bg-gray-50/50 focus:outline-none focus:ring-2 focus:ring-violet-500 focus:border-violet-500 transition-shadow" />
            </div>
          </div>
          <div class="flex flex-col gap-1.5">
            <label class="text-xs font-bold text-gray-500 uppercase tracking-widest">Cidade</label>
            <select v-model="filtros.cidade" class="w-full rounded-xl border border-gray-200 px-4 py-2.5 text-sm text-gray-800 bg-gray-50/50 focus:outline-none focus:ring-2 focus:ring-violet-500 focus:border-violet-500">
              <option value="">Todas</option>
              <option v-for="c in cidadesUnicas" :key="c" :value="c">{{ c }}</option>
            </select>
          </div>
          <div class="flex flex-col gap-1.5">
            <label class="text-xs font-bold text-gray-500 uppercase tracking-widest">Status</label>
            <div class="flex gap-2">
              <button
                v-for="op in [{ label: 'Todos', value: '' }, { label: 'Ativo', value: 'true' }, { label: 'Inativo', value: 'false' }]"
                :key="op.value"
                type="button"
                class="flex-1 text-xs font-bold py-2 rounded-xl border transition-colors"
                :class="filtros.ativo === op.value
                  ? 'bg-violet-600 border-violet-600 text-white'
                  : 'border-gray-200 text-gray-500 hover:border-pink-400 hover:text-[#ff46a2] bg-white'"
                @click="filtros.ativo = op.value"
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
      <span class="inline-block w-12 h-12 border-4 border-violet-600 border-t-transparent rounded-full animate-spin" />
      <span class="text-sm text-gray-400 font-medium">Carregando clientes...</span>
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
          <span class="text-[#ff46a2] font-black">{{ clientesFiltrados.length }}</span>
          resultado(s)
          <span v-if="filtrosAtivos > 0" class="text-gray-400 font-normal"> �?" filtros aplicados</span>
        </span>
        <span class="text-xs text-gray-400">Ordenado por nome</span>
      </div>

      <div class="overflow-x-auto">
        <table class="min-w-full text-sm whitespace-nowrap">
          <thead>
            <tr class="bg-gray-50 border-b border-gray-100">
              <th class="text-left px-7 py-4 text-xs font-extrabold text-gray-400 uppercase tracking-widest">#</th>
              <th class="text-left px-5 py-4 text-xs font-extrabold text-gray-400 uppercase tracking-widest">Nome</th>
              <th class="text-left px-5 py-4 text-xs font-extrabold text-gray-400 uppercase tracking-widest">CPF / CNPJ</th>
              <th class="text-left px-5 py-4 text-xs font-extrabold text-gray-400 uppercase tracking-widest">Telefone</th>
              <th class="text-left px-5 py-4 text-xs font-extrabold text-gray-400 uppercase tracking-widest">E-mail</th>
              <th class="text-left px-5 py-4 text-xs font-extrabold text-gray-400 uppercase tracking-widest">Cidade / Estado</th>
              <th class="text-left px-5 py-4 text-xs font-extrabold text-gray-400 uppercase tracking-widest">Status</th>
              <th class="px-7 py-4 text-right text-xs font-extrabold text-gray-400 uppercase tracking-widest sm:sticky sm:right-0 bg-gray-50">Ações</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-50">
            <tr v-if="clientesFiltrados.length === 0">
              <td colspan="8" class="text-center py-20">
                <div class="flex flex-col items-center gap-3">
                  <svg class="w-14 h-14 text-gray-300" fill="none" stroke="currentColor" stroke-width="1.25" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 9h3.75M15 12h3.75M15 15h3.75M4.5 19.5h15a2.25 2.25 0 002.25-2.25V6.75A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25v10.5A2.25 2.25 0 004.5 19.5zm6-10.125a1.875 1.875 0 11-3.75 0 1.875 1.875 0 013.75 0zm1.5 0a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm-1.5 6.75a3.375 3.375 0 00-6.75 0h6.75z"/></svg>
                  <span class="text-base font-semibold text-gray-400">Nenhum cliente encontrado</span>
                  <span v-if="filtrosAtivos > 0" class="text-sm text-gray-400">Tente ajustar os filtros</span>
                </div>
              </td>
            </tr>
            <tr
              v-for="cli in clientesFiltrados"
              :key="cli.id"
              class="hover:bg-pink-50/40 transition-colors duration-150 group"
            >
              <td class="px-7 py-4">
                <span class="inline-flex items-center justify-center w-8 h-8 rounded-full bg-violet-100 text-[#ff46a2] font-black text-xs">
                  {{ cli.id }}
                </span>
              </td>
              <td class="px-5 py-4">
                <div class="flex items-center gap-3">
                  <div class="w-9 h-9 rounded-full bg-gradient-to-br from-pink-400 to-pink-600 flex items-center justify-center text-white font-black text-sm shrink-0 shadow-sm shadow-pink-200 select-none">
                    {{ initials(cli.nome) }}
                  </div>
                  <span class="font-semibold text-gray-800 max-w-[160px] block truncate">{{ cli.nome }}</span>
                </div>
              </td>
              <td class="px-5 py-4">
                <span v-if="cli.cpf_cnpj" class="font-mono text-xs font-semibold bg-gray-100 text-gray-600 px-2 py-1 rounded-lg">{{ cli.cpf_cnpj }}</span>
                <span v-else class="text-gray-300">-</span>
              </td>
              <td class="px-5 py-4 text-gray-500 font-medium">{{ cli.telefone ?? '-' }}</td>
              <td class="px-5 py-4 text-gray-500 font-medium">
                <span class="max-w-[180px] block truncate">{{ cli.email ?? '-' }}</span>
              </td>
              <td class="px-5 py-4">
                <span v-if="cli.cidade || cli.estado" class="text-gray-600 font-medium">
                  {{ [cli.cidade, cli.estado].filter(Boolean).join(' / ') }}
                </span>
                <span v-else class="text-gray-300">-</span>
              </td>
              <td class="px-5 py-4">
                <span
                  :class="['inline-flex items-center gap-1.5 text-xs font-bold px-3 py-1.5 rounded-full',
                    cli.ativo !== false ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500']"
                >
                  <span :class="['w-1.5 h-1.5 rounded-full', cli.ativo !== false ? 'bg-green-500' : 'bg-gray-400']" />
                  {{ cli.ativo !== false ? 'Ativo' : 'Inativo' }}
                </span>
              </td>
              <td class="px-7 py-4 text-right sm:sticky sm:right-0 bg-white group-hover:bg-pink-50/40 transition-colors">
                <div class="flex items-center justify-end gap-1">
                  <button
                    v-if="isAdminOrGerente"
                    type="button"
                    class="w-8 h-8 flex items-center justify-center rounded-xl text-[#ff46a2] hover:text-pink-700 hover:bg-pink-100 transition-colors"
                    title="Editar"
                    @click="editCliente(cli)"
                  >
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L10.582 16.07a4.5 4.5 0 01-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 011.13-1.897l8.932-8.931z"/><path stroke-linecap="round" stroke-linejoin="round" d="M19.5 7.125L18 8.625"/></svg>
                  </button>
                  <button
                    v-if="isAdminOrGerente"
                    type="button"
                    class="w-8 h-8 flex items-center justify-center rounded-xl text-red-400 hover:text-red-600 hover:bg-red-50 transition-colors"
                    title="Excluir"
                    @click="confirmarExclusao(cli)"
                  >
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
          <div class="bg-white rounded-3xl shadow-2xl w-full max-w-2xl overflow-hidden">
            <div class="flex items-center justify-between px-8 py-6 border-b border-gray-100 bg-gradient-to-r from-pink-50 to-white">
              <div class="flex items-center gap-3">
                <div class="w-9 h-9 rounded-xl bg-pink-100 flex items-center justify-center">
                  <svg class="w-5 h-5 text-[#ff46a2]" fill="none" stroke="currentColor" stroke-width="1.75" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 9h3.75M15 12h3.75M15 15h3.75M4.5 19.5h15a2.25 2.25 0 002.25-2.25V6.75A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25v10.5A2.25 2.25 0 004.5 19.5zm6-10.125a1.875 1.875 0 11-3.75 0 1.875 1.875 0 013.75 0zm1.5 0a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm-1.5 6.75a3.375 3.375 0 00-6.75 0h6.75z"/></svg>
                </div>
                <h2 class="text-lg font-bold text-gray-800">{{ adicionando ? 'Adicionar Cliente' : 'Editar Cliente' }}</h2>
              </div>
              <button type="button" class="w-8 h-8 flex items-center justify-center rounded-xl text-gray-400 hover:text-gray-700 hover:bg-gray-100 transition-colors" @click="fecharModal">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
              </button>
            </div>

            <form class="flex flex-col gap-5 px-8 py-7 overflow-y-auto max-h-[70vh]" @submit.prevent="adicionando ? salvarAdicao() : salvarEdicao()">
              <!-- Nome + CPF/CNPJ -->
              <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <AppInput v-model="form.nome" label="Nome *" placeholder="Ex: João da Silva" :error="formErrors.nome" required />
                <AppInput v-model="form.cpf_cnpj" label="CPF / CNPJ" placeholder="Ex: 000.000.000-00" :error="formErrors.cpf_cnpj" />
              </div>
              <!-- Telefone + E-mail -->
              <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <AppInput v-model="form.telefone" label="Telefone" placeholder="Ex: (11) 99999-9999" />
                <AppInput v-model="form.email" label="E-mail" type="email" placeholder="Ex: joao@email.com" :error="formErrors.email" />
              </div>
              <!-- Endereço + Número -->
              <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                <div class="sm:col-span-2">
                  <AppInput v-model="form.endereco" label="Endereço" placeholder="Ex: Rua das Flores" />
                </div>
                <AppInput v-model="form.numero" label="Número" placeholder="Ex: 123" />
              </div>
              <!-- Bairro + CEP -->
              <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <AppInput v-model="form.bairro" label="Bairro" placeholder="Ex: Centro" />
                <AppInput v-model="form.cep" label="CEP" placeholder="Ex: 00000-000" />
              </div>
              <!-- Cidade + Estado -->
              <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <AppInput v-model="form.cidade" label="Cidade" placeholder="Ex: São Paulo" />
                <div class="flex flex-col gap-1.5">
                  <label class="text-sm font-semibold text-gray-700">Estado</label>
                  <select v-model="form.estado" class="w-full rounded-xl border border-gray-200 px-4 py-2.5 text-sm text-gray-800 bg-gray-50/50 focus:outline-none focus:ring-2 focus:ring-violet-500 focus:border-violet-500">
                    <option value="">Selecione</option>
                    <option v-for="uf in ufs" :key="uf" :value="uf">{{ uf }}</option>
                  </select>
                </div>
              </div>
              <!-- Observação -->
              <div class="flex flex-col gap-1.5">
                <label class="text-sm font-semibold text-gray-700">Observação</label>
                <textarea
                  v-model="form.observacao"
                  rows="2"
                  placeholder="Informações adicionais..."
                  class="w-full rounded-xl border border-gray-200 px-4 py-2.5 text-sm text-gray-800 placeholder:text-gray-400 bg-gray-50/50 focus:outline-none focus:ring-2 focus:ring-violet-500 focus:border-violet-500 resize-none"
                />
              </div>
              <!-- Ativo -->
              <div class="flex items-center gap-3 bg-gray-50 rounded-xl px-4 py-3 border border-gray-100">
                <button
                  type="button"
                  class="relative w-11 h-6 rounded-full transition-colors duration-200"
                  :class="form.ativo ? 'bg-green-500' : 'bg-gray-300'"
                  @click="form.ativo = !form.ativo"
                >
                  <span class="absolute top-0.5 left-0.5 w-5 h-5 bg-white rounded-full shadow transition-transform duration-200" :class="form.ativo ? 'translate-x-5' : 'translate-x-0'" />
                </button>
                <div>
                  <p class="text-sm font-semibold text-gray-700">Cliente ativo</p>
                  <p class="text-xs text-gray-400">{{ form.ativo ? 'Habilitado para novas vendas' : 'Desativado' }}</p>
                </div>
              </div>

              <p v-if="modalError" class="text-sm text-red-600 bg-red-50 border border-red-200 rounded-xl px-4 py-3">{{ modalError }}</p>

              <div class="flex gap-3 pt-1">
                <button type="button" class="flex-1 py-3 rounded-xl border border-gray-200 text-gray-500 hover:bg-gray-50 transition-colors text-sm font-semibold" @click="fecharModal">
                  Cancelar
                </button>
                <AppButton variant="primary" size="md" type="submit" :loading="saving" class="flex-1">
                  {{ adicionando ? 'Adicionar' : 'Salvar alterações' }}
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
              <h2 class="text-xl font-bold text-gray-800">Excluir cliente?</h2>
              <p class="text-sm text-gray-500 mt-2 leading-relaxed">
                Tem certeza que deseja excluir <br /><strong class="text-gray-800">{{ excluindo.nome }}</strong>?<br />
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
import { ref, reactive, computed, onMounted } from 'vue'
import { createSupabaseClient } from '~/lib/supabase'
import { useAdmin } from '~/composables/useAdmin'
import { useEmpresa } from '~/composables/useEmpresa'
import AppInput from '~/components/AppInput.vue'
import AppButton from '~/components/AppButton.vue'

interface Cliente {
  id: number
  nome: string
  cpf_cnpj: string | null
  telefone: string | null
  email: string | null
  endereco: string | null
  numero: string | null
  bairro: string | null
  cidade: string | null
  estado: string | null
  cep: string | null
  observacao: string | null
  ativo: boolean | null
  created_at: string | null
}

const supabase = createSupabaseClient()
const { empresaId, loadEmpresa } = useEmpresa()
const { isAdminOrGerente } = useAdmin()

const clientes = ref<Cliente[]>([])
const loading = ref(true)
const error = ref<string | null>(null)

const editando = ref<Cliente | null>(null)
const adicionando = ref(false)
const saving = ref(false)
const modalError = ref<string | null>(null)

const excluindo = ref<Cliente | null>(null)
const deleting = ref(false)
const deleteError = ref<string | null>(null)

const form = reactive({
  nome: '',
  cpf_cnpj: '',
  telefone: '',
  email: '',
  endereco: '',
  numero: '',
  bairro: '',
  cidade: '',
  estado: '',
  cep: '',
  observacao: '',
  ativo: true,
})

const formErrors = reactive({ nome: '', cpf_cnpj: '', email: '' })

const filtroAberto = ref(false)
const filtros = reactive({ busca: '', cidade: '', ativo: '' })

const ufs = [
  'AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG',
  'PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO',
]

// �"?�"? Stats �"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?
const clientesAtivos = computed(() =>
  clientes.value.filter(c => c.ativo !== false).length
)
const comEmail = computed(() =>
  clientes.value.filter(c => c.email).length
)
const cidadesUnicas = computed(() => {
  const set = new Set(clientes.value.map(c => c.cidade).filter(Boolean) as string[])
  return Array.from(set).sort()
})

// �"?�"? Filtros �"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?
const filtrosAtivos = computed(() => {
  let c = 0
  if (filtros.busca) c++
  if (filtros.cidade) c++
  if (filtros.ativo) c++
  return c
})

const clientesFiltrados = computed(() => {
  return clientes.value.filter(c => {
    if (filtros.cidade && c.cidade !== filtros.cidade) return false
    if (filtros.ativo === 'true' && c.ativo === false) return false
    if (filtros.ativo === 'false' && c.ativo !== false) return false
    if (filtros.busca.trim()) {
      const q = filtros.busca.toLowerCase()
      return (
        c.nome.toLowerCase().includes(q) ||
        (c.cpf_cnpj ?? '').includes(q) ||
        (c.telefone ?? '').includes(q) ||
        (c.email ?? '').toLowerCase().includes(q)
      )
    }
    return true
  })
})

function limparFiltros() {
  filtros.busca = ''
  filtros.cidade = ''
  filtros.ativo = ''
}

// �"?�"? Helpers �"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?
function initials(nome: string): string {
  const parts = nome.trim().split(' ').filter(Boolean)
  if (parts.length >= 2) return ((parts[0]?.[0] ?? '') + (parts[1]?.[0] ?? '')).toUpperCase()
  return (nome[0] ?? '?').toUpperCase()
}

// �"?�"? CRUD �"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?�"?
onMounted(async () => { await loadEmpresa(); await fetchClientes() })

async function fetchClientes() {
  loading.value = true
  const { data, error: fetchError } = await supabase
    .from('clientes')
    .select('*')
    .eq('empresa_id', empresaId.value!)
    .order('nome', { ascending: true })

  loading.value = false
  if (fetchError) { error.value = fetchError.message; return }
  clientes.value = (data ?? []) as Cliente[]
}

function abrirAdicionar() {
  adicionando.value = true
  editando.value = null
  modalError.value = null
  formErrors.nome = ''; formErrors.cpf_cnpj = ''; formErrors.email = ''
  form.nome = ''; form.cpf_cnpj = ''; form.telefone = ''; form.email = ''
  form.endereco = ''; form.numero = ''; form.bairro = ''; form.cidade = ''
  form.estado = ''; form.cep = ''; form.observacao = ''; form.ativo = true
}

function fecharModal() {
  editando.value = null
  adicionando.value = false
}

function editCliente(cli: Cliente) {
  editando.value = cli
  modalError.value = null
  formErrors.nome = ''; formErrors.cpf_cnpj = ''; formErrors.email = ''
  form.nome       = cli.nome
  form.cpf_cnpj   = cli.cpf_cnpj ?? ''
  form.telefone   = cli.telefone ?? ''
  form.email      = cli.email ?? ''
  form.endereco   = cli.endereco ?? ''
  form.numero     = cli.numero ?? ''
  form.bairro     = cli.bairro ?? ''
  form.cidade     = cli.cidade ?? ''
  form.estado     = cli.estado ?? ''
  form.cep        = cli.cep ?? ''
  form.observacao = cli.observacao ?? ''
  form.ativo      = cli.ativo !== false
}

function buildPayload() {
  return {
    nome:       form.nome.trim(),
    cpf_cnpj:   form.cpf_cnpj.trim() || null,
    telefone:   form.telefone.trim() || null,
    email:      form.email.trim() || null,
    endereco:   form.endereco.trim() || null,
    numero:     form.numero.trim() || null,
    bairro:     form.bairro.trim() || null,
    cidade:     form.cidade.trim() || null,
    estado:     form.estado || null,
    cep:        form.cep.trim() || null,
    observacao: form.observacao.trim() || null,
    ativo:      form.ativo,
    empresa_id: empresaId.value!,
  }
}

function validateForm(): boolean {
  formErrors.nome = ''; formErrors.cpf_cnpj = ''; formErrors.email = ''
  let ok = true
  if (!form.nome.trim()) { formErrors.nome = 'O nome é obrigatório.'; ok = false }
  return ok
}

async function salvarEdicao() {
  if (!editando.value || !validateForm()) return
  saving.value = true
  modalError.value = null

  const { error: updateError } = await supabase
    .from('clientes')
    .update(buildPayload())
    .eq('id', editando.value.id)

  saving.value = false
  if (updateError) {
    modalError.value = updateError.message.includes('clientes_cpf_cnpj_key')
      ? 'Este CPF/CNPJ já está cadastrado.'
      : updateError.message.includes('clientes_email_key')
        ? 'Este e-mail já está cadastrado.'
        : updateError.message
    return
  }

  editando.value = null
  await fetchClientes()
}

async function salvarAdicao() {
  if (!validateForm()) return
  saving.value = true
  modalError.value = null

  const { error: insertError } = await supabase
    .from('clientes')
    .insert(buildPayload())

  saving.value = false
  if (insertError) {
    modalError.value = insertError.message.includes('clientes_cpf_cnpj_key')
      ? 'Este CPF/CNPJ já está cadastrado.'
      : insertError.message.includes('clientes_email_key')
        ? 'Este e-mail já está cadastrado.'
        : insertError.message
    return
  }

  adicionando.value = false
  await fetchClientes()
}

function confirmarExclusao(cli: Cliente) {
  excluindo.value = cli
  deleteError.value = null
}

async function executarExclusao() {
  if (!excluindo.value) return
  deleting.value = true
  deleteError.value = null

  const { error: deleteErr } = await supabase
    .from('clientes')
    .delete()
    .eq('id', excluindo.value.id)

  deleting.value = false
  if (deleteErr) { deleteError.value = deleteErr.message; return }

  excluindo.value = null
  await fetchClientes()
}
</script>

<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.2s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }
.slide-fade-enter-active { transition: all 0.2s ease; }
.slide-fade-leave-active { transition: all 0.15s ease; }
.slide-fade-enter-from, .slide-fade-leave-to { transform: translateY(-8px); opacity: 0; }
</style>
