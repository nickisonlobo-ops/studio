<template>
  <div class="font-sans bg-white text-gray-900 overflow-x-hidden">
    <!-- HEADER -->
    <header class="fixed top-0 inset-x-0 z-50 bg-white/90 backdrop-blur-md border-b border-gray-100 shadow-sm">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 flex items-center justify-between h-16">
        <div class="flex items-center gap-2.5">
          <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-green-600 to-green-800 flex items-center justify-center shadow">
            <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M3.75 21h16.5M4.5 3h15M5.25 3v18m13.5-18v18M9 6.75h1.5m-1.5 3h1.5m-1.5 3h1.5m3-6H15m-1.5 3H15m-1.5 3H15M9 21v-3.375c0-.621.504-1.125 1.125-1.125h3.75c.621 0 1.125.504 1.125 1.125V21"
              />
            </svg>
          </div>
          <span class="font-black text-gray-900 text-lg tracking-tight">PetFlow</span>
        </div>

        <nav class="hidden md:flex items-center gap-6 text-sm font-medium text-gray-600">
          <a href="#beneficios" class="hover:text-green-700 transition-colors">Benefícios</a>
          <a href="#sistema" class="hover:text-green-700 transition-colors">Sistema</a>
          <a href="#assessoria" class="hover:text-green-700 transition-colors">Assessoria</a>
          <a href="#marketing" class="hover:text-green-700 transition-colors">Marketing</a>
          <a href="#planos" class="hover:text-green-700 transition-colors">Planos</a>
          <a href="#contato" class="hover:text-green-700 transition-colors">Contato</a>
        </nav>

        <a
          href="#contato"
          class="inline-flex items-center gap-2 bg-green-600 hover:bg-green-700 text-white text-sm font-bold px-4 py-2 rounded-xl transition-colors shadow"
        >
          Falar com Consultor
        </a>
      </div>
    </header>

    <!-- HERO -->
    <section class="relative min-h-[100svh] flex items-center overflow-hidden pt-16">
      <div class="absolute inset-0 bg-gradient-to-br from-green-950 via-green-800 to-green-600"></div>
      <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_top_right,rgba(249,115,22,0.22),transparent_50%)]"></div>
      <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_bottom_left,rgba(255,255,255,0.08),transparent_55%)]"></div>

      <div class="absolute -top-40 -right-40 w-[600px] h-[600px] rounded-full bg-white/[0.03]"></div>
      <div class="absolute -bottom-52 -left-52 w-[700px] h-[700px] rounded-full bg-white/[0.03]"></div>

      <div class="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 py-20 grid lg:grid-cols-2 gap-14 items-center">
        <div class="flex flex-col items-start gap-6">
          <span class="inline-flex items-center gap-2 bg-white/10 border border-white/20 text-white text-xs font-bold px-4 py-2 rounded-full uppercase tracking-widest">
            <span class="w-2 h-2 rounded-full bg-orange-400 animate-pulse"></span>
            Sistema + Estratégia + Crescimento
          </span>

          <h1 class="text-4xl sm:text-5xl lg:text-6xl font-black text-white leading-[1.03] tracking-tight">
            Transforme sua casa de ração em uma
            <span class="text-transparent bg-clip-text bg-gradient-to-r from-orange-300 to-orange-500">máquina de vendas</span>
          </h1>

          <p class="text-base sm:text-lg text-green-100/90 max-w-xl leading-relaxed">
            Mais clientes, mais controle e mais lucro. Nós organizamos sua operação, estruturamos seu crescimento e
            ajudamos sua loja a vender mais todos os meses.
          </p>

          <div class="flex flex-wrap gap-3 pt-1">
            <a
              href="#planos"
              class="inline-flex items-center gap-2 bg-orange-500 hover:bg-orange-400 text-white font-black px-6 py-3.5 rounded-2xl text-base shadow-lg transition-all hover:scale-[1.02]"
            >
              Quero crescer minha loja
            </a>

            <a
              href="#sistema"
              class="inline-flex items-center gap-2 bg-white/10 hover:bg-white/20 border border-white/25 text-white font-bold px-6 py-3.5 rounded-2xl text-base transition-all"
            >
              Ver como funciona
            </a>
          </div>

          <div class="grid sm:grid-cols-2 gap-3 w-full max-w-2xl pt-4">
            <div
              v-for="item in heroBadges"
              :key="item"
              class="flex items-center gap-2 text-sm text-green-100 bg-white/8 border border-white/10 rounded-2xl px-4 py-3"
            >
              <svg class="w-4 h-4 text-green-300 flex-shrink-0" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"/>
              </svg>
              <span>{{ item }}</span>
            </div>
          </div>
        </div>

        <div class="hidden lg:flex flex-col gap-5">
          <div class="bg-white/10 backdrop-blur-md border border-white/15 rounded-3xl p-6 shadow-2xl">
            <p class="text-[10px] font-black text-green-200 uppercase tracking-[0.2em] mb-4">Visão do Negócio</p>
            <div class="grid grid-cols-2 gap-4">
              <div v-for="stat in heroStats" :key="stat.label" class="bg-white/10 rounded-2xl px-4 py-4 border border-white/10">
                <p class="text-[10px] font-black uppercase tracking-[0.15em]" :class="stat.color">{{ stat.label }}</p>
                <p class="text-2xl font-black text-white mt-1">{{ stat.value }}</p>
                <p class="text-[11px] text-green-100/70 mt-1">{{ stat.sub }}</p>
              </div>
            </div>
          </div>

          <div class="grid grid-cols-3 gap-4">
            <div class="rounded-2xl bg-white/10 backdrop-blur-md border border-white/15 p-4 text-center">
              <p class="text-2xl font-black text-white">+ Controle</p>
              <p class="text-xs text-green-100/70 mt-1">da operação</p>
            </div>
            <div class="rounded-2xl bg-white/10 backdrop-blur-md border border-white/15 p-4 text-center">
              <p class="text-2xl font-black text-white">+ Vendas</p>
              <p class="text-xs text-green-100/70 mt-1">com estratégia</p>
            </div>
            <div class="rounded-2xl bg-white/10 backdrop-blur-md border border-white/15 p-4 text-center">
              <p class="text-2xl font-black text-white">+ Lucro</p>
              <p class="text-xs text-green-100/70 mt-1">com visão clara</p>
            </div>
          </div>
        </div>
      </div>

      <div class="absolute bottom-0 inset-x-0">
        <svg viewBox="0 0 1440 80" fill="none" xmlns="http://www.w3.org/2000/svg" class="w-full">
          <path d="M0 80V42C240 10 480 74 720 40C960 6 1200 72 1440 38V80H0Z" fill="white"/>
        </svg>
      </div>
    </section>

    <!-- BENEFICIOS -->
    <section id="beneficios" class="py-20 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-14">
          <span class="text-xs font-black text-orange-500 uppercase tracking-widest">Resultado real</span>
          <h2 class="mt-2 text-3xl sm:text-4xl font-black text-gray-900">
            Você para de apagar incêndio e começa a
            <span class="text-green-700">crescer com direção</span>
          </h2>
          <p class="mt-4 text-gray-500 max-w-3xl mx-auto">
            A PetFlow une sistema, organização, suporte e estratégia para transformar a rotina da sua loja em um
            negócio mais leve, controlado e lucrativo.
          </p>
        </div>

        <div class="grid md:grid-cols-3 gap-6">
          <div
            v-for="benefit in benefits"
            :key="benefit.title"
            class="rounded-3xl border border-gray-100 bg-gray-50 p-7 shadow-sm hover:shadow-md transition-shadow"
          >
            <div class="w-14 h-14 rounded-2xl flex items-center justify-center mb-5" :class="benefit.iconBg">
              <span v-html="benefit.icon" :class="benefit.iconColor"></span>
            </div>
            <h3 class="text-lg font-black text-gray-900">{{ benefit.title }}</h3>
            <p class="mt-2 text-sm text-gray-600 leading-relaxed">{{ benefit.desc }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- DOR -->
    <section class="py-20 bg-gray-50">
      <div class="max-w-7xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-14">
          <span class="text-xs font-black text-orange-500 uppercase tracking-widest">Sua realidade hoje</span>
          <h2 class="mt-2 text-3xl sm:text-4xl font-black text-gray-900">
            Se você trabalha muito e o dinheiro não sobra,
            <br class="hidden sm:block" />
            o problema pode estar aqui:
          </h2>
        </div>

        <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-5">
          <div
            v-for="p in problemas"
            :key="p.title"
            class="flex gap-4 p-5 rounded-2xl bg-white border border-red-100 shadow-sm"
          >
            <div class="w-11 h-11 flex-shrink-0 rounded-xl bg-red-50 flex items-center justify-center">
              <svg class="w-5 h-5 text-red-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z"/>
              </svg>
            </div>
            <div>
              <p class="font-bold text-gray-900 text-sm">{{ p.title }}</p>
              <p class="text-xs text-gray-500 mt-1 leading-relaxed">{{ p.desc }}</p>
            </div>
          </div>
        </div>

        <div class="mt-12 rounded-3xl bg-gradient-to-r from-green-700 to-green-900 p-8 text-center text-white shadow-xl">
          <p class="text-xl font-black">A boa notícia é que isso tem solução.</p>
          <p class="text-green-200 text-sm mt-2 max-w-2xl mx-auto">
            Com a estrutura certa, sua loja pode vender melhor, trabalhar com menos bagunça e crescer de forma mais previsível.
          </p>
        </div>
      </div>
    </section>

    <!-- SISTEMA -->
    <section id="sistema" class="py-20 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-14">
          <span class="text-xs font-black text-green-600 uppercase tracking-widest">Módulo 1</span>
          <h2 class="mt-2 text-3xl sm:text-4xl font-black text-gray-900">Sistema PetFlow</h2>
          <p class="mt-4 text-gray-500 max-w-3xl mx-auto">
            Você passa a ter controle total da sua loja em tempo real, mesmo sem estar presente. Tudo centralizado em um só lugar.
          </p>
        </div>

        <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-5">
          <div
            v-for="mod in modulos"
            :key="mod.title"
            class="group bg-gray-50 rounded-3xl p-6 border border-gray-100 shadow-sm hover:shadow-lg hover:-translate-y-1 transition-all duration-200"
          >
            <div class="w-12 h-12 rounded-2xl flex items-center justify-center mb-4" :class="mod.iconBg">
              <span v-html="mod.icon" :class="mod.iconColor"></span>
            </div>
            <h3 class="font-black text-gray-900 text-base">{{ mod.title }}</h3>
            <p class="text-sm text-gray-500 mt-2 leading-relaxed">{{ mod.desc }}</p>

            <ul class="mt-4 flex flex-col gap-2">
              <li v-for="f in mod.features" :key="f" class="flex items-start gap-2 text-sm text-gray-600">
                <svg class="w-4 h-4 text-green-500 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"/>
                </svg>
                <span>{{ f }}</span>
              </li>
            </ul>
          </div>
        </div>

        <div class="mt-10 rounded-3xl overflow-hidden">
          <div class="relative bg-gradient-to-br from-green-900 via-green-700 to-green-600 p-8 sm:p-10 flex flex-col lg:flex-row items-start lg:items-center justify-between gap-6">
            <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_right,rgba(249,115,22,0.18),transparent_60%)]"></div>
            <div class="relative z-10">
              <p class="text-2xl font-black text-white">Acesso 100% na nuvem</p>
              <p class="text-green-200 text-sm mt-2 max-w-xl">
                Sem instalação complicada. Funciona no celular, no tablet e no computador. Sua equipe acessa com rapidez e praticidade.
              </p>
            </div>
            <a
              href="#contato"
              class="relative z-10 inline-flex items-center gap-2 bg-white text-green-700 font-black text-sm px-6 py-3 rounded-2xl shadow hover:bg-green-50 transition-colors"
            >
              Solicitar demonstração
            </a>
          </div>
        </div>
      </div>
    </section>

    <!-- ASSESSORIA -->
    <section id="assessoria" class="py-20 bg-gray-50">
      <div class="max-w-7xl mx-auto px-4 sm:px-6">
        <div class="grid lg:grid-cols-2 gap-14 items-center">
          <div>
            <span class="text-xs font-black text-blue-600 uppercase tracking-widest">Módulo 2</span>
            <h2 class="mt-2 text-3xl sm:text-4xl font-black text-gray-900 leading-tight">
              Assessoria Empresarial
            </h2>
            <p class="mt-4 text-gray-600 leading-relaxed max-w-xl">
              A gente entra no seu negócio, identifica onde você está perdendo dinheiro e mostra o que precisa ser ajustado para crescer com mais segurança.
            </p>

            <div class="mt-8 flex flex-col gap-4">
              <div
                v-for="item in assessoriaServicos"
                :key="item.title"
                class="flex gap-4 p-5 rounded-2xl border border-gray-100 bg-white shadow-sm"
              >
                <div class="w-11 h-11 flex-shrink-0 rounded-xl bg-blue-50 border border-blue-100 flex items-center justify-center">
                  <span v-html="item.icon" class="text-blue-600"></span>
                </div>
                <div>
                  <p class="font-bold text-gray-900 text-sm">{{ item.title }}</p>
                  <p class="text-sm text-gray-500 mt-1 leading-relaxed">{{ item.desc }}</p>
                </div>
              </div>
            </div>
          </div>

          <div class="flex flex-col gap-5">
            <div class="rounded-3xl p-7 text-white shadow-xl" style="background: linear-gradient(135deg,#254d8e,#0a1c39)">
              <p class="text-xs font-black uppercase tracking-widest text-blue-300 mb-4">O que você recebe</p>
              <ul class="flex flex-col gap-3">
                <li v-for="item in assessoriaReceive" :key="item" class="flex items-start gap-3 text-sm font-semibold">
                  <svg class="w-5 h-5 text-green-400 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"/>
                  </svg>
                  <span>{{ item }}</span>
                </li>
              </ul>
            </div>

            <div class="grid grid-cols-2 gap-5">
              <div v-for="m in assessoriaMetrics" :key="m.label" class="rounded-2xl border border-gray-100 bg-white p-5 text-center shadow-sm">
                <p class="text-3xl font-black" :class="m.color">{{ m.value }}</p>
                <p class="text-xs font-semibold text-gray-500 mt-2">{{ m.label }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- MARKETING -->
    <section id="marketing" class="py-20 bg-gradient-to-br from-orange-50 via-white to-orange-50">
      <div class="max-w-7xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-14">
          <span class="text-xs font-black text-orange-500 uppercase tracking-widest">Módulo 3</span>
          <h2 class="mt-2 text-3xl sm:text-4xl font-black text-gray-900">Assessoria de Marketing</h2>
          <p class="mt-4 text-gray-600 max-w-3xl mx-auto">
            Enquanto você cuida da loja, nós cuidamos de trazer clientes até você com presença digital, conteúdo e campanhas mais estratégicas.
          </p>
        </div>

        <div class="grid sm:grid-cols-2 lg:grid-cols-4 gap-5 mb-10">
          <div
            v-for="item in marketingServicos"
            :key="item.title"
            class="bg-white rounded-3xl p-6 border border-gray-100 shadow-sm hover:shadow-lg hover:-translate-y-1 transition-all duration-200 text-center"
          >
            <div class="w-14 h-14 rounded-2xl bg-orange-50 border border-orange-100 flex items-center justify-center mx-auto mb-4">
              <span v-html="item.icon" class="text-orange-500"></span>
            </div>
            <h3 class="font-black text-gray-900 text-sm">{{ item.title }}</h3>
            <p class="text-sm text-gray-500 mt-2 leading-relaxed">{{ item.desc }}</p>
          </div>
        </div>

        <div class="rounded-3xl bg-white border border-orange-100 shadow-sm p-7 sm:p-10">
          <div class="mb-6">
            <p class="text-xl font-black text-gray-900 mb-1">O que é entregue com estratégia</p>
            <p class="text-sm text-gray-500 leading-relaxed max-w-2xl">
              Não é só postar por postar. Cada ação é pensada para aumentar sua visibilidade, gerar confiança e trazer mais movimento para a loja.
            </p>
          </div>

          <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
            <div v-for="e in marketingEntregas" :key="e" class="flex items-start gap-3 text-sm text-gray-600">
              <div class="w-6 h-6 rounded-lg bg-orange-100 flex items-center justify-center flex-shrink-0 mt-0.5">
                <svg class="w-3.5 h-3.5 text-orange-500" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"/>
                </svg>
              </div>
              <span>{{ e }}</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- COMO FUNCIONA -->
    <section class="py-20 bg-white">
      <div class="max-w-6xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-14">
          <span class="text-xs font-black text-green-600 uppercase tracking-widest">Processo</span>
          <h2 class="mt-2 text-3xl sm:text-4xl font-black text-gray-900">Como começamos</h2>
        </div>

        <div class="relative">
          <div class="hidden lg:block absolute top-10 left-[10%] right-[10%] h-0.5 bg-gradient-to-r from-green-200 via-orange-200 to-blue-200"></div>

          <div class="grid sm:grid-cols-2 lg:grid-cols-4 gap-8">
            <div v-for="(step, i) in etapas" :key="step.title" class="flex flex-col items-center text-center gap-3">
              <div class="relative w-20 h-20 rounded-2xl flex items-center justify-center shadow-md z-10" :class="step.bg">
                <span v-html="step.icon" :class="step.iconColor"></span>
                <span
                  class="absolute -top-2 -right-2 w-6 h-6 rounded-full bg-white border-2 text-xs font-black flex items-center justify-center"
                  :class="step.numColor"
                >
                  {{ i + 1 }}
                </span>
              </div>
              <p class="font-black text-gray-900 text-sm">{{ step.title }}</p>
              <p class="text-sm text-gray-500 leading-relaxed">{{ step.desc }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- PLANOS -->
    <section id="planos" class="py-20 bg-gray-50">
      <div class="max-w-7xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-14">
          <span class="text-xs font-black text-green-600 uppercase tracking-widest">Investimento</span>
          <h2 class="mt-2 text-3xl sm:text-4xl font-black text-gray-900">Escolha o melhor plano para crescer</h2>
          <p class="mt-4 text-gray-500 max-w-2xl mx-auto">
            Os planos foram desenhados para acompanhar a evolução da sua loja, do controle básico até a expansão com marketing e estratégia.
          </p>
        </div>

        <div class="grid lg:grid-cols-3 gap-6 items-stretch">
          <div
            v-for="plano in planos"
            :key="plano.name"
            class="relative flex flex-col rounded-3xl border transition-transform hover:-translate-y-1 duration-200"
            :class="plano.featured
              ? 'bg-gradient-to-b from-green-700 to-green-950 border-green-700 shadow-2xl scale-[1.01]'
              : 'bg-white border-gray-100 shadow-sm'"
          >
            <div v-if="plano.featured" class="absolute -top-3.5 inset-x-0 flex justify-center">
              <span class="bg-orange-500 text-white text-[10px] font-black px-4 py-1 rounded-full uppercase tracking-widest shadow">
                Melhor custo-benefício
              </span>
            </div>

            <div class="p-7 flex flex-col gap-5 flex-1">
              <div>
                <p class="text-xs font-black uppercase tracking-widest" :class="plano.featured ? 'text-green-300' : 'text-gray-400'">
                  {{ plano.label }}
                </p>
                <h3 class="text-2xl font-black mt-1" :class="plano.featured ? 'text-white' : 'text-gray-900'">
                  {{ plano.name }}
                </h3>
                <p class="text-sm mt-2 leading-relaxed" :class="plano.featured ? 'text-green-100/90' : 'text-gray-500'">
                  {{ plano.desc }}
                </p>
              </div>

              <div>
                <div class="flex items-end gap-1">
                  <span class="text-sm font-bold" :class="plano.featured ? 'text-green-300' : 'text-gray-400'">R$</span>
                  <span class="text-5xl font-black leading-none" :class="plano.featured ? 'text-white' : 'text-gray-900'">
                    {{ plano.price }}
                  </span>
                  <span class="text-sm font-semibold pb-1" :class="plano.featured ? 'text-green-300' : 'text-gray-400'">/mês</span>
                </div>
                <p class="text-xs mt-2" :class="plano.featured ? 'text-green-200/80' : 'text-gray-400'">
                  {{ plano.implantacao }}
                </p>
                <p class="text-xs mt-2 font-semibold" :class="plano.featured ? 'text-orange-300' : 'text-green-700'">
                  {{ plano.retorno }}
                </p>
              </div>

              <ul class="flex flex-col gap-3 flex-1">
                <li
                  v-for="item in plano.includes"
                  :key="item.text"
                  class="flex items-start gap-2.5 text-sm"
                  :class="item.active ? (plano.featured ? 'text-green-50' : 'text-gray-700') : (plano.featured ? 'text-green-200/50' : 'text-gray-400')"
                >
                  <svg
                    class="w-4 h-4 flex-shrink-0 mt-0.5"
                    :class="item.active ? 'text-green-400' : (plano.featured ? 'text-green-200/40' : 'text-gray-300')"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2.5"
                    viewBox="0 0 24 24"
                  >
                    <path v-if="item.active" stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"/>
                    <path v-else stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
                  </svg>
                  <span>{{ item.text }}</span>
                </li>
              </ul>

              <a
                href="#contato"
                class="mt-2 block text-center font-black text-sm px-5 py-3.5 rounded-2xl transition-all"
                :class="plano.featured
                  ? 'bg-orange-500 hover:bg-orange-400 text-white shadow-lg'
                  : 'bg-green-600 hover:bg-green-700 text-white'"
              >
                {{ plano.cta }}
              </a>
            </div>
          </div>
        </div>

        <p class="text-center text-xs text-gray-400 mt-8">
          * Valores sujeitos a reajuste. Consulte condições especiais para contrato anual.
        </p>
      </div>
    </section>

    <!-- DIFERENCIAIS -->
    <section class="py-20 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-14">
          <span class="text-xs font-black text-green-600 uppercase tracking-widest">Por que escolher</span>
          <h2 class="mt-2 text-3xl sm:text-4xl font-black text-gray-900">O que faz a PetFlow diferente</h2>
        </div>

        <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-5">
          <div
            v-for="d in diferenciais"
            :key="d.title"
            class="flex gap-4 p-5 rounded-2xl bg-gray-50 border border-gray-100 hover:border-green-100 hover:bg-green-50/30 transition-colors"
          >
            <div class="w-11 h-11 flex-shrink-0 rounded-xl flex items-center justify-center" :class="d.iconBg">
              <span v-html="d.icon" :class="d.iconColor"></span>
            </div>
            <div>
              <p class="font-bold text-gray-900 text-sm">{{ d.title }}</p>
              <p class="text-sm text-gray-500 mt-1 leading-relaxed">{{ d.desc }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- DEPOIMENTOS -->
    <section class="py-20 bg-gray-50">
      <div class="max-w-7xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-14">
          <span class="text-xs font-black text-green-600 uppercase tracking-widest">Prova social</span>
          <h2 class="mt-2 text-3xl sm:text-4xl font-black text-gray-900">Resultados reais de quem decidiu crescer</h2>
        </div>

        <div class="grid md:grid-cols-3 gap-5">
          <div
            v-for="d in depoimentos"
            :key="d.name"
            class="bg-white rounded-3xl p-6 border border-gray-100 shadow-sm hover:shadow-md transition-shadow flex flex-col gap-4"
          >
            <div class="flex gap-0.5">
              <svg v-for="i in 5" :key="i" class="w-4 h-4 text-amber-400" fill="currentColor" viewBox="0 0 20 20">
                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
              </svg>
            </div>

            <p class="text-sm text-gray-600 italic leading-relaxed flex-1">"{{ d.text }}"</p>

            <div class="flex items-center gap-3">
              <div class="w-10 h-10 rounded-full flex items-center justify-center font-black text-sm text-white" :class="d.avatarBg">
                {{ d.initials }}
              </div>
              <div>
                <p class="font-bold text-gray-900 text-sm">{{ d.name }}</p>
                <p class="text-xs text-gray-400">{{ d.role }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- FAQ -->
    <section class="py-20 bg-white">
      <div class="max-w-4xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-12">
          <span class="text-xs font-black text-green-600 uppercase tracking-widest">Dúvidas frequentes</span>
          <h2 class="mt-2 text-3xl font-black text-gray-900">Perguntas frequentes</h2>
        </div>

        <div class="flex flex-col gap-3">
          <div
            v-for="faq in faqs"
            :key="faq.q"
            class="rounded-2xl border border-gray-100 bg-gray-50 overflow-hidden"
          >
            <button
              class="w-full flex items-center justify-between gap-4 px-5 py-4 text-left"
              @click="toggleFaq(faq.q)"
            >
              <span class="font-bold text-gray-800 text-sm">{{ faq.q }}</span>
              <svg
                class="w-5 h-5 text-gray-400 flex-shrink-0 transition-transform duration-200"
                :class="openFaq === faq.q ? 'rotate-180' : ''"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                viewBox="0 0 24 24"
              >
                <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 8.25l-7.5 7.5-7.5-7.5"/>
              </svg>
            </button>

            <div v-if="openFaq === faq.q" class="px-5 pb-4 text-sm text-gray-500 leading-relaxed border-t border-gray-100">
              <p class="pt-3">{{ faq.a }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- CONTATO -->
    <section id="contato" class="py-20 bg-gradient-to-br from-green-950 via-green-800 to-green-600 relative overflow-hidden">
      <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_top_left,rgba(249,115,22,0.2),transparent_55%)]"></div>
      <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_bottom_right,rgba(255,255,255,0.12),transparent_60%)]"></div>

      <div class="relative z-10 max-w-4xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-12">
          <span class="text-xs font-black text-orange-300 uppercase tracking-widest">Próximo passo</span>
          <h2 class="mt-2 text-3xl sm:text-4xl font-black text-white leading-tight">
            Se você quer parar de operar no escuro
            <br class="hidden sm:block" />
            e começar a crescer de verdade, esse é o próximo passo.
          </h2>
          <p class="mt-4 text-green-100/80 max-w-2xl mx-auto">
            Preencha o formulário e nossa equipe entrará em contato para entender o seu cenário e apresentar a melhor estrutura para sua loja.
          </p>
        </div>

        <div class="bg-white rounded-3xl p-7 sm:p-10 shadow-2xl">
          <form @submit.prevent="enviarFormulario" class="grid sm:grid-cols-2 gap-5">
            <div class="flex flex-col gap-1.5">
              <label class="text-xs font-bold text-gray-700 uppercase tracking-wider">Nome completo *</label>
              <input
                v-model="form.nome"
                type="text"
                required
                placeholder="Seu nome"
                class="border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition"
              />
            </div>

            <div class="flex flex-col gap-1.5">
              <label class="text-xs font-bold text-gray-700 uppercase tracking-wider">Nome da loja *</label>
              <input
                v-model="form.loja"
                type="text"
                required
                placeholder="Nome do estabelecimento"
                class="border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition"
              />
            </div>

            <div class="flex flex-col gap-1.5">
              <label class="text-xs font-bold text-gray-700 uppercase tracking-wider">WhatsApp *</label>
              <input
                v-model="form.whatsapp"
                type="tel"
                required
                placeholder="(00) 00000-0000"
                class="border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition"
              />
            </div>

            <div class="flex flex-col gap-1.5">
              <label class="text-xs font-bold text-gray-700 uppercase tracking-wider">E-mail</label>
              <input
                v-model="form.email"
                type="email"
                placeholder="seu@email.com"
                class="border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition"
              />
            </div>

            <div class="flex flex-col gap-1.5 sm:col-span-2">
              <label class="text-xs font-bold text-gray-700 uppercase tracking-wider">Seu principal interesse</label>
              <div class="flex flex-wrap gap-2">
                <button
                  v-for="opt in interesseOpts"
                  :key="opt"
                  type="button"
                  @click="toggleInteresse(opt)"
                  class="text-xs font-semibold px-3 py-2 rounded-xl border transition-all"
                  :class="form.interesses.includes(opt)
                    ? 'bg-green-600 text-white border-green-600'
                    : 'bg-gray-50 text-gray-600 border-gray-200 hover:border-green-400'"
                >
                  {{ opt }}
                </button>
              </div>
            </div>

            <div class="flex flex-col gap-1.5 sm:col-span-2">
              <label class="text-xs font-bold text-gray-700 uppercase tracking-wider">Mensagem</label>
              <textarea
                v-model="form.mensagem"
                rows="4"
                placeholder="Conte um pouco sobre sua loja e o que você quer melhorar..."
                class="border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition resize-none"
              />
            </div>

            <div class="sm:col-span-2">
              <button
                type="submit"
                :disabled="enviando"
                class="w-full flex items-center justify-center gap-2 bg-green-600 hover:bg-green-700 disabled:opacity-60 text-white font-black text-base px-8 py-4 rounded-2xl transition-all shadow-lg"
              >
                <svg v-if="!enviando" class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6 12L3.269 3.126A59.768 59.768 0 0121.485 12 59.77 59.77 0 013.27 20.876L5.999 12zm0 0h7.5"/>
                </svg>
                <svg v-else class="w-5 h-5 animate-spin" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"/>
                </svg>
                {{ enviando ? 'Enviando...' : 'Quero organizar e crescer minha loja' }}
              </button>
            </div>
          </form>

          <div v-if="enviado" class="mt-6 flex items-center gap-3 bg-green-50 border border-green-200 rounded-2xl p-4">
            <svg class="w-6 h-6 text-green-500 flex-shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
            </svg>
            <p class="text-sm text-green-700 font-semibold">Recebemos sua solicitação. Entraremos em contato em breve.</p>
          </div>
        </div>

        <div class="mt-8 text-center">
          <p class="text-green-200/80 text-sm mb-3">Prefere falar agora?</p>
          <a
            href="https://wa.me/5500000000000?text=Ol%C3%A1!%20Vi%20a%20p%C3%A1gina%20da%20PetFlow%20e%20quero%20saber%20mais."
            target="_blank"
            rel="noopener noreferrer"
            class="inline-flex items-center gap-2.5 bg-[#25D366] hover:bg-[#20c45a] text-white font-black px-7 py-3.5 rounded-2xl text-sm transition-all shadow-lg hover:scale-[1.02]"
          >
            Conversar pelo WhatsApp
          </a>
        </div>
      </div>
    </section>

    <!-- FOOTER -->
    <footer class="bg-gray-950 text-gray-400 py-10">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 flex flex-col sm:flex-row items-center justify-between gap-4">
        <div class="flex items-center gap-2">
          <div class="w-8 h-8 rounded-xl bg-green-600 flex items-center justify-center">
            <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M3.75 21h16.5M4.5 3h15M5.25 3v18m13.5-18v18M9 6.75h1.5m-1.5 3h1.5m-1.5 3h1.5m3-6H15m-1.5 3H15m-1.5 3H15M9 21v-3.375c0-.621.504-1.125 1.125-1.125h3.75c.621 0 1.125.504 1.125 1.125V21"
              />
            </svg>
          </div>
          <span class="text-white font-black">PetFlow</span>
        </div>

        <p class="text-xs text-center">© {{ new Date().getFullYear() }} PetFlow. Todos os direitos reservados.</p>
        <p class="text-xs">Sistema · Assessoria · Marketing</p>
      </div>
    </footer>
  </div>
</template>

<script setup lang="ts">
definePageMeta({ layout: false })

const openFaq = ref<string | null>(null)
const enviando = ref(false)
const enviado = ref(false)

const form = reactive({
  nome: '',
  loja: '',
  whatsapp: '',
  email: '',
  interesses: [] as string[],
  mensagem: '',
})

const heroBadges = [
  'Implantação assistida',
  'Suporte humanizado',
  'Atualizações incluídas',
  'Estratégia para crescer',
]

const heroStats = [
  { label: 'Vendas', value: 'R$ 42k', sub: 'mês atual', color: 'text-green-300' },
  { label: 'Clientes', value: '318', sub: 'ativos', color: 'text-blue-300' },
  { label: 'Estoque', value: '1.2k', sub: 'itens', color: 'text-purple-300' },
  { label: 'Rotina', value: '97%', sub: 'organizada', color: 'text-orange-300' },
]

const icons = {
  chart: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M3 3v18h18M7.5 15l3-3 2.25 2.25L18 9"/></svg>`,
  eye: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.644C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.01 9.963 7.178.07.207.07.437 0 .644C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.01-9.964-7.178z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/></svg>`,
  rocket: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M15.59 14.37a6 6 0 00-5.84-5.84m5.84 5.84L19.5 19.5m-9.75-1.5l-5.25 1.5 1.5-5.25m3.75-3.75l6-6a2.121 2.121 0 013 3l-6 6m-3 3l-3 3"/></svg>`,
  users: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M18 18.72a9.094 9.094 0 003.742-.477 3 3 0 00-4.682-2.72m.94 3.197v.001c0 .414-.033.822-.097 1.22M18 18.72A9.094 9.094 0 0112 21a9.094 9.094 0 01-6-.28m12 0v.001c0 .414.033.822.097 1.22M6 18.72a9.094 9.094 0 01-3.742-.477 3 3 0 014.682-2.72m-.94 3.197A9.094 9.094 0 0012 21m0-10.5a3.75 3.75 0 100-7.5 3.75 3.75 0 000 7.5z"/></svg>`,
  box: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M21 7.5l-9-4.5-9 4.5m18 0v9l-9 4.5m9-13.5l-9 4.5m0 0L3 7.5m9 4.5V21"/></svg>`,
  money: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18.75a60.07 60.07 0 0119.5 0m-18-12a60.07 60.07 0 0116.5 0M12 6v12m3-9.75c0-.621-1.343-1.125-3-1.125S9 7.629 9 8.25 10.343 9.375 12 9.375s3 .504 3 1.125-1.343 1.125-3 1.125-3 .504-3 1.125 1.343 1.125 3 1.125 3 .504 3 1.125"/></svg>`,
  finance: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M3 13.5h4.5V21H3v-7.5zm6.75-6H14V21H9.75V7.5zm6.75-4.5H21V21h-4.5V3z"/></svg>`,
  team: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z"/></svg>`,
  analytics: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M7.5 14.25l3-3 2.25 2.25L16.5 9m3 0h-3.75M19.5 9v3.75M3.75 19.5h16.5"/></svg>`,
  search: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-5.2-5.2m1.45-4.55a6 6 0 11-12 0 6 6 0 0112 0z"/></svg>`,
  target: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6l4 2m6-2A10 10 0 1112 2a10 10 0 0110 10z"/></svg>`,
  gear: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M10.5 6h3m-8.25 6h13.5m-10.5 6h7.5"/></svg>`,
  handshake: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M15.75 5.25l3 3m0 0l-3 3m3-3H9.75m-4.5 10.5l-3-3m0 0l3-3m-3 3h9"/></svg>`,
  megaphone: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-7 h-7"><path stroke-linecap="round" stroke-linejoin="round" d="M10.34 6.16L18 3v18l-7.66-3.16A4.5 4.5 0 016 13.5v-3a4.5 4.5 0 014.34-4.34zM6 13.5h2.25"/></svg>`,
  content: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-7 h-7"><path stroke-linecap="round" stroke-linejoin="round" d="M7.5 3.75h9A2.25 2.25 0 0118.75 6v12A2.25 2.25 0 0116.5 20.25h-9A2.25 2.25 0 015.25 18V6A2.25 2.25 0 017.5 3.75zM8.25 8.25h7.5M8.25 12h7.5M8.25 15.75h4.5"/></svg>`,
  ads: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-7 h-7"><path stroke-linecap="round" stroke-linejoin="round" d="M3.75 13.5l10.5-11.25L12 10.5h8.25L9.75 21.75 12 13.5H3.75z"/></svg>`,
  brand: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-7 h-7"><path stroke-linecap="round" stroke-linejoin="round" d="M12 3l7.5 4.5v9L12 21 4.5 16.5v-9L12 3z"/></svg>`,
  searchBig: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-8 h-8"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-4.35-4.35m1.35-5.15a6.5 6.5 0 11-13 0 6.5 6.5 0 0113 0z"/></svg>`,
  monitor: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-8 h-8"><path stroke-linecap="round" stroke-linejoin="round" d="M3 5.25A2.25 2.25 0 015.25 3h13.5A2.25 2.25 0 0121 5.25v9.5A2.25 2.25 0 0118.75 17H5.25A2.25 2.25 0 013 14.75v-9.5zM8.25 21h7.5"/></svg>`,
  strategy: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-8 h-8"><path stroke-linecap="round" stroke-linejoin="round" d="M4.5 19.5l5.25-5.25 3.75 3.75 6-8.25"/></svg>`,
  loop: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-8 h-8"><path stroke-linecap="round" stroke-linejoin="round" d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99"/></svg>`,
  layers: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M12 3l9 4.5-9 4.5-9-4.5L12 3zm-9 9l9 4.5 9-4.5M3 16.5L12 21l9-4.5"/></svg>`,
  compass: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M12 21a9 9 0 100-18 9 9 0 000 18zm3.75-12.75l-2.7 6.3-6.3 2.7 2.7-6.3 6.3-2.7z"/></svg>`,
  growth: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M3 17.25V21h3.75L17.25 10.5M14.25 6.75h6v6"/></svg>`,
  support: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M8.625 12a.375.375 0 11-.75 0 .375.375 0 01.75 0zm0 0H8.25m4.125 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm0 0H12m4.125 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm0 0h-.375M21 12c0 4.556-4.03 8.25-9 8.25a9.764 9.764 0 01-2.555-.337A5.972 5.972 0 015.41 20.97a5.969 5.969 0 01-.474-.065 4.48 4.48 0 00.978-2.025c.09-.457-.133-.901-.467-1.226C3.93 16.178 3 14.189 3 12c0-4.556 4.03-8.25 9-8.25s9 3.694 9 8.25z"/></svg>`,
  spark: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M9.813 15.904L9 18.75l-.813-2.846a4.5 4.5 0 00-3.091-3.091L2.25 12l2.846-.813a4.5 4.5 0 003.091-3.091L9 5.25l.813 2.846a4.5 4.5 0 003.091 3.091l2.846.813-2.846.813a4.5 4.5 0 00-3.091 3.091zM18.259 8.715L18 9.75l-.259-1.035a3.375 3.375 0 00-2.456-2.456L14.25 6l1.035-.259a3.375 3.375 0 002.456-2.456L18 2.25l.259 1.035a3.375 3.375 0 002.456 2.456L21.75 6l-1.035.259a3.375 3.375 0 00-2.456 2.456z"/></svg>`,
  building: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M3.75 21h16.5M4.5 3h15M5.25 3v18m13.5-18v18M9 6.75h1.5m-1.5 3h1.5m-1.5 3h1.5m3-6H15m-1.5 3H15m-1.5 3H15M9 21v-3.375c0-.621.504-1.125 1.125-1.125h3.75c.621 0 1.125.504 1.125 1.125V21"/></svg>`,
}

const benefits = [
  {
    title: 'Mais controle no dia a dia',
    desc: 'Saiba o que entra, o que sai, o que vende e onde estão os gargalos da operação.',
    iconBg: 'bg-green-50',
    iconColor: 'text-green-600',
    icon: icons.chart,
  },
  {
    title: 'Mais clareza para decidir',
    desc: 'Pare de trabalhar no achismo e comece a tomar decisões com dados e visão real do negócio.',
    iconBg: 'bg-blue-50',
    iconColor: 'text-blue-600',
    icon: icons.eye,
  },
  {
    title: 'Mais força para crescer',
    desc: 'Sistema, estratégia e marketing juntos para sua loja vender mais com estrutura.',
    iconBg: 'bg-orange-50',
    iconColor: 'text-orange-500',
    icon: icons.rocket,
  },
]

const problemas = [
  {
    title: 'Falta de controle financeiro',
    desc: 'Você trabalha o mês inteiro e no final não sabe exatamente quanto sobrou de lucro.',
  },
  {
    title: 'Estoque desorganizado',
    desc: 'Produto parado de um lado e falta do outro, gerando prejuízo e venda perdida.',
  },
  {
    title: 'Clientes não fidelizam',
    desc: 'Sem histórico e sem relacionamento, seu cliente compra hoje e some amanhã.',
  },
  {
    title: 'Equipe sem direção',
    desc: 'Funcionários fazem o básico, mas a operação continua bagunçada e travada.',
  },
  {
    title: 'Pouca presença digital',
    desc: 'Sua concorrência aparece, anuncia e vende mais, enquanto sua loja fica invisível.',
  },
  {
    title: 'Decisões no escuro',
    desc: 'Sem relatórios claros, você toma decisões importantes sem confiança.',
  },
]

const modulos = [
  {
    title: 'Gestão de Clientes',
    desc: 'Cadastro organizado, histórico de relacionamento e visão completa de cada cliente.',
    iconBg: 'bg-blue-50',
    iconColor: 'text-blue-600',
    icon: icons.users,
    features: [
      'Cadastro completo de clientes',
      'Histórico de compras e relacionamento',
      'Lembretes e oportunidades de fidelização',
    ],
  },
  {
    title: 'Controle de Produtos',
    desc: 'Estoque mais inteligente para evitar falta, excesso e perda de dinheiro.',
    iconBg: 'bg-purple-50',
    iconColor: 'text-purple-600',
    icon: icons.box,
    features: [
      'Cadastro de produtos e categorias',
      'Controle de estoque mínimo',
      'Visão mais clara do giro dos itens',
    ],
  },
  {
    title: 'Gestão de Vendas',
    desc: 'Acompanhe faturamento, fluxo comercial e desempenho da loja com mais clareza.',
    iconBg: 'bg-green-50',
    iconColor: 'text-green-600',
    icon: icons.money,
    features: [
      'Registro de vendas simplificado',
      'Acompanhamento do faturamento',
      'Visão rápida de desempenho',
    ],
  },
  {
    title: 'Financeiro',
    desc: 'Saiba o que entra, o que sai e onde estão os pontos de desperdício.',
    iconBg: 'bg-orange-50',
    iconColor: 'text-orange-500',
    icon: icons.finance,
    features: [
      'Controle de entradas e saídas',
      'Relatórios financeiros básicos',
      'Mais clareza sobre margem e resultado',
    ],
  },
  {
    title: 'Equipe e Rotina',
    desc: 'Mais alinhamento para a operação fluir com menos retrabalho.',
    iconBg: 'bg-rose-50',
    iconColor: 'text-rose-600',
    icon: icons.team,
    features: [
      'Organização de tarefas',
      'Mais controle operacional',
      'Rotina mais leve e previsível',
    ],
  },
  {
    title: 'Relatórios e Indicadores',
    desc: 'Entenda o negócio com números e indicadores simples de acompanhar.',
    iconBg: 'bg-emerald-50',
    iconColor: 'text-emerald-600',
    icon: icons.analytics,
    features: [
      'Relatórios visuais',
      'Indicadores para decisão',
      'Acompanhamento da evolução da loja',
    ],
  },
]

const assessoriaServicos = [
  {
    title: 'Diagnóstico do Negócio',
    desc: 'Entendemos sua operação e identificamos os pontos que mais travam resultado e lucro.',
    icon: icons.search,
  },
  {
    title: 'Plano de Crescimento',
    desc: 'Organizamos prioridades, metas e ações práticas para sua loja sair do improviso.',
    icon: icons.target,
  },
  {
    title: 'Otimização de Processos',
    desc: 'Melhoramos a rotina da operação para reduzir desperdícios, retrabalho e lentidão.',
    icon: icons.gear,
  },
  {
    title: 'Acompanhamento Estratégico',
    desc: 'Você não fica sozinho. Seguimos ajustando a rota com reuniões e visão de crescimento.',
    icon: icons.handshake,
  },
]

const assessoriaReceive = [
  'Reunião estratégica mensal',
  'Diagnóstico do cenário atual',
  'Plano de crescimento prático',
  'Ajustes de processos e operação',
  'Orientação para vendas, equipe e gestão',
  'Acompanhamento contínuo com suporte',
]

const assessoriaMetrics = [
  { value: '+ Clareza', label: 'para decidir melhor', color: 'text-blue-700' },
  { value: '+ Lucro', label: 'com mais controle', color: 'text-green-700' },
  { value: '- Retrabalho', label: 'na operação', color: 'text-orange-500' },
  { value: '+ Direção', label: 'para crescer', color: 'text-purple-700' },
]

const marketingServicos = [
  {
    title: 'Posicionamento Digital',
    desc: 'Sua loja passa a ser vista com mais profissionalismo e mais força no mercado local.',
    icon: icons.megaphone,
  },
  {
    title: 'Conteúdo Estratégico',
    desc: 'Postagens, artes e presença que geram confiança, lembrança e conexão com seu público.',
    icon: icons.content,
  },
  {
    title: 'Campanhas Pagas',
    desc: 'Anúncios direcionados para atrair mais movimento e oportunidades de venda.',
    icon: icons.ads,
  },
  {
    title: 'Fortalecimento da Marca',
    desc: 'Sua comunicação deixa de ser amadora e passa a transmitir valor e credibilidade.',
    icon: icons.brand,
  },
]

const marketingEntregas = [
  'Planejamento de conteúdo mensal',
  'Criação de posts e artes estratégicas',
  'Stories com foco em presença e engajamento',
  'Gestão de campanhas pagas',
  'Análise de concorrência local',
  'Acompanhamento de métricas',
  'Otimização contínua do perfil',
  'Ajustes de posicionamento e comunicação',
]

const etapas = [
  {
    title: 'Diagnóstico',
    desc: 'Entendemos o momento da sua loja, suas dores e onde estão os maiores gargalos.',
    bg: 'bg-green-600',
    iconColor: 'text-white',
    numColor: 'text-green-600 border-green-200',
    icon: icons.searchBig,
  },
  {
    title: 'Implantação',
    desc: 'Configuramos a estrutura inicial e organizamos a base para começar do jeito certo.',
    bg: 'bg-orange-500',
    iconColor: 'text-white',
    numColor: 'text-orange-500 border-orange-200',
    icon: icons.monitor,
  },
  {
    title: 'Estratégia',
    desc: 'Definimos prioridades, ajustes e ações práticas para o negócio avançar com direção.',
    bg: 'bg-blue-600',
    iconColor: 'text-white',
    numColor: 'text-blue-600 border-blue-200',
    icon: icons.strategy,
  },
  {
    title: 'Acompanhamento',
    desc: 'Seguimos junto com suporte, revisão de resultados e melhorias contínuas.',
    bg: 'bg-purple-600',
    iconColor: 'text-white',
    numColor: 'text-purple-600 border-purple-200',
    icon: icons.loop,
  },
]

const planos = [
  {
    label: 'Para começar',
    name: 'Base',
    desc: 'Organize sua loja e pare de perder dinheiro no dia a dia.',
    price: '597',
    implantacao: 'Implantação única R$ 1.997',
    retorno: 'Potencial de retorno: mais controle e base pronta para crescer',
    featured: false,
    cta: 'Quero organizar minha loja',
    includes: [
      { text: 'Sistema PetFlow completo', active: true },
      { text: 'Até 3 usuários', active: true },
      { text: 'Todos os 6 módulos', active: true },
      { text: 'Suporte via e-mail', active: true },
      { text: 'Assessoria empresarial', active: false },
      { text: 'Reunião estratégica mensal', active: false },
      { text: 'Assessoria de marketing', active: false },
    ],
  },
  {
    label: 'Mais escolhido',
    name: 'Crescimento',
    desc: 'Estrutura + estratégia para fazer sua loja crescer de verdade.',
    price: '1.497',
    implantacao: 'Implantação única R$ 2.297',
    retorno: 'Potencial de retorno: mais organização, vendas e margem',
    featured: true,
    cta: 'Quero crescer com estratégia',
    includes: [
      { text: 'Sistema PetFlow completo', active: true },
      { text: 'Usuários ilimitados', active: true },
      { text: 'Todos os 6 módulos', active: true },
      { text: 'Suporte via WhatsApp', active: true },
      { text: 'Assessoria empresarial', active: true },
      { text: 'Reunião estratégica mensal', active: true },
      { text: 'Assessoria de marketing', active: false },
    ],
  },
  {
    label: 'Solução completa',
    name: 'Dominação',
    desc: 'Transforme sua loja em referência e lidere o mercado local.',
    price: '2.297',
    implantacao: 'Implantação única R$ 3.997',
    retorno: 'Potencial de retorno: crescimento mais forte com presença e estratégia',
    featured: false,
    cta: 'Quero dominar meu mercado',
    includes: [
      { text: 'Sistema PetFlow completo', active: true },
      { text: 'Usuários ilimitados', active: true },
      { text: 'Todos os 6 módulos', active: true },
      { text: 'Suporte prioritário', active: true },
      { text: 'Assessoria empresarial', active: true },
      { text: 'Reunião estratégica mensal', active: true },
      { text: 'Assessoria de marketing', active: true },
    ],
  },
]

const diferenciais = [
  {
    title: 'Tudo em uma solução só',
    desc: 'Você não precisa contratar várias ferramentas separadas para organizar e crescer.',
    iconBg: 'bg-green-50',
    iconColor: 'text-green-600',
    icon: icons.layers,
  },
  {
    title: 'Visão estratégica, não só sistema',
    desc: 'Além da plataforma, você recebe orientação para melhorar a operação e o resultado.',
    iconBg: 'bg-blue-50',
    iconColor: 'text-blue-600',
    icon: icons.compass,
  },
  {
    title: 'Foco em crescimento real',
    desc: 'Toda a estrutura foi pensada para aumentar controle, clareza e potencial de venda.',
    iconBg: 'bg-orange-50',
    iconColor: 'text-orange-500',
    icon: icons.growth,
  },
  {
    title: 'Suporte próximo',
    desc: 'Você fala com pessoas de verdade e tem apoio durante a implantação e evolução.',
    iconBg: 'bg-purple-50',
    iconColor: 'text-purple-600',
    icon: icons.support,
  },
  {
    title: 'Mais percepção de valor',
    desc: 'Sua loja passa a se apresentar melhor para o cliente, online e na operação.',
    iconBg: 'bg-emerald-50',
    iconColor: 'text-emerald-600',
    icon: icons.spark,
  },
  {
    title: 'Estrutura para escalar',
    desc: 'Você cria uma base mais profissional para crescer sem aumentar a bagunça.',
    iconBg: 'bg-rose-50',
    iconColor: 'text-rose-600',
    icon: icons.building,
  },
]

const depoimentos = [
  {
    text: 'Antes eu vivia no caos. Depois que organizamos a operação, ficou muito mais claro onde estava o problema e o que precisava ser feito.',
    name: 'Mariana Costa',
    role: 'Proprietária',
    initials: 'MC',
    avatarBg: 'bg-green-600',
  },
  {
    text: 'A parte estratégica fez muita diferença. Começamos a enxergar melhor o negócio e a comunicação ficou muito mais profissional.',
    name: 'Roberto Lima',
    role: 'Empresário do setor pet',
    initials: 'RL',
    avatarBg: 'bg-blue-600',
  },
  {
    text: 'O maior ganho foi parar de tomar decisão no escuro. Hoje tenho mais visão, mais controle e mais segurança para crescer.',
    name: 'Fernanda Souza',
    role: 'Sócia de loja pet',
    initials: 'FS',
    avatarBg: 'bg-orange-500',
  },
]

const faqs = [
  {
    q: 'Preciso ter conhecimento técnico para usar o sistema?',
    a: 'Não. A plataforma foi pensada para ser simples e prática. Além disso, a implantação é assistida e sua equipe recebe orientação para começar com segurança.',
  },
  {
    q: 'Funciona no celular?',
    a: 'Sim. O sistema funciona no celular, tablet e computador, permitindo acesso de qualquer lugar com internet.',
  },
  {
    q: 'Posso contratar só o sistema?',
    a: 'Sim. O plano Base é voltado para quem quer começar pela organização da operação com o sistema.',
  },
  {
    q: 'A assessoria empresarial faz diferença mesmo?',
    a: 'Faz porque ela ajuda a transformar o sistema em resultado. Você não fica apenas com a ferramenta: recebe direção estratégica para melhorar o negócio.',
  },
  {
    q: 'O marketing está incluído em qual plano?',
    a: 'A assessoria de marketing está incluída no plano Dominação, pensado para quem quer crescer com mais força e presença no mercado local.',
  },
  {
    q: 'Quanto tempo leva para começar?',
    a: 'Depois da contratação, iniciamos o processo de implantação e alinhamento para colocar sua operação em movimento o quanto antes.',
  },
]

const interesseOpts = [
  'Sistema',
  'Organização da loja',
  'Assessoria empresarial',
  'Marketing',
  'Vender mais',
]

function toggleFaq(question: string) {
  openFaq.value = openFaq.value === question ? null : question
}

function toggleInteresse(option: string) {
  if (form.interesses.includes(option)) {
    form.interesses = form.interesses.filter((item) => item !== option)
    return
  }
  form.interesses.push(option)
}

async function enviarFormulario() {
  enviando.value = true

  try {
    await new Promise((resolve) => setTimeout(resolve, 1200))
    enviado.value = true

    form.nome = ''
    form.loja = ''
    form.whatsapp = ''
    form.email = ''
    form.interesses = []
    form.mensagem = ''
  } finally {
    enviando.value = false
  }
}

</script>