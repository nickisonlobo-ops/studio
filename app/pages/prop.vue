?<template>
  <div class="font-sans bg-white text-gray-900 overflow-x-hidden">

    <!-- NAVBAR -->
    <header class="fixed top-0 inset-x-0 z-50 bg-white/90 backdrop-blur-md border-b border-gray-100 shadow-sm">
      <div class="max-w-6xl mx-auto px-4 sm:px-6 flex items-center justify-between h-16">
        <div class="flex items-center gap-2.5">
          <div class="w-9 h-9 rounded-xl bg-gradient-to-br from-green-600 to-green-800 flex items-center justify-center shadow">
            <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 21h16.5M4.5 3h15M5.25 3v18m13.5-18v18M9 6.75h1.5m-1.5 3h1.5m-1.5 3h1.5m3-6H15m-1.5 3H15m-1.5 3H15M9 21v-3.375c0-.621.504-1.125 1.125-1.125h3.75c.621 0 1.125.504 1.125 1.125V21" />
            </svg>
          </div>
          <span class="font-black text-gray-900 text-lg tracking-tight">PetFlow</span>
        </div>

        <nav class="hidden md:flex items-center gap-6 text-sm font-medium text-gray-600">
          <a href="#sistema" class="hover:text-green-700 transition-colors">Sistema</a>
          <a href="#modulos" class="hover:text-green-700 transition-colors">Módulos</a>
          <a href="#planos" class="hover:text-green-700 transition-colors">Planos</a>
          <a href="#contato" class="hover:text-green-700 transition-colors">Contato</a>
        </nav>

        <a href="#contato"
          class="inline-flex items-center gap-2 bg-green-600 hover:bg-green-700 text-white text-sm font-bold px-4 py-2 rounded-xl transition-colors shadow">
          Solicitar Demonstração
        </a>
      </div>
    </header>

    <!-- HERO -->
    <section class="relative min-h-[100svh] flex flex-col justify-center overflow-hidden pt-16">
      <!-- Background layers -->
      <div class="absolute inset-0 bg-gradient-to-br from-green-950 via-green-800 to-green-600" />
      <div class="absolute inset-0 bg-[radial-gradient(ellipse_80%_55%_at_100%_10%,rgba(240,112,16,0.2),transparent)]" />
      <div class="absolute inset-0 bg-[radial-gradient(ellipse_50%_40%_at_0%_90%,rgba(0,40,20,0.55),transparent)]" />
      <!-- Dot grid -->
      <div class="absolute inset-0 opacity-[0.055] bg-[radial-gradient(circle,white_1px,transparent_1px)] bg-[size:28px_28px]" />
      <!-- Decorative rings -->
      <div class="absolute top-16 right-0 w-[480px] h-[480px] rounded-full border border-white/[0.06] translate-x-1/2 pointer-events-none" />
      <div class="absolute top-28 right-0 w-[300px] h-[300px] rounded-full border border-white/[0.04] translate-x-1/3 pointer-events-none" />
      <div class="absolute -bottom-20 -left-20 w-[400px] h-[400px] rounded-full border border-white/[0.04] pointer-events-none" />

      <div class="relative z-10 max-w-6xl mx-auto px-4 sm:px-6 py-16 lg:py-20 grid lg:grid-cols-[1fr_1.15fr] gap-12 xl:gap-16 items-center">

        <!-- LEFT: Copy -->
        <div class="flex flex-col items-start gap-6">
          <div class="flex items-center gap-2.5 bg-orange-500/15 border border-orange-400/25 text-orange-200 text-[11px] font-bold px-4 py-2 rounded-full uppercase tracking-widest">
            <span class="w-1.5 h-1.5 rounded-full bg-orange-400 animate-pulse flex-shrink-0" />
            Sistema para Mercado Pet
          </div>

          <h1 class="text-[2.5rem] sm:text-5xl xl:text-[3.4rem] font-black text-white leading-[1.07] tracking-tight">
            Chega de perder dinheiro<br />
            <span class="text-transparent bg-clip-text bg-gradient-to-r from-orange-300 via-amber-300 to-orange-400">por falta de controle</span><br />
            na sua loja
          </h1>

          <p class="text-[15px] sm:text-base text-green-100/80 max-w-lg leading-relaxed">
            O PetFlow centraliza clientes, estoque, vendas, financeiro e equipe numa só plataforma - feita para <strong class="text-white font-semibold">casas de ração e mercados pet</strong>.
          </p>

          <div class="flex flex-wrap gap-3 mt-1">
            <a href="#planos"
              class="inline-flex items-center gap-2.5 bg-orange-500 hover:bg-orange-400 active:bg-orange-600 text-white font-black px-7 py-[14px] rounded-2xl text-[15px] shadow-lg shadow-orange-900/30 transition-all hover:scale-[1.03] hover:shadow-xl">
              Ver Planos e Preços
              <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17.25 8.25L21 12m0 0l-3.75 3.75M21 12H3" />
              </svg>
            </a>
            <a href="#modulos"
              class="inline-flex items-center gap-2 border border-white/20 hover:border-white/40 hover:bg-white/[0.08] text-white font-semibold px-7 py-[14px] rounded-2xl text-[15px] transition-all">
              Ver os Módulos
            </a>
          </div>

          <div class="flex flex-wrap gap-x-5 gap-y-2.5 mt-1">
            <div v-for="b in heroBadges" :key="b" class="flex items-center gap-2 text-xs font-medium text-green-100/75">
              <svg class="w-4 h-4 text-green-400 flex-shrink-0" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5" />
              </svg>
              {{ b }}
            </div>
          </div>
        </div>

        <!-- RIGHT: Enhanced Dashboard Mockup -->
        <div class="hidden lg:flex flex-col gap-3">
          <div class="bg-white/[0.07] backdrop-blur-md border border-white/[0.12] rounded-3xl overflow-hidden shadow-[0_32px_80px_rgba(0,0,0,0.35)]">

            <!-- Top bar -->
            <div class="flex items-center justify-between px-5 py-3.5 bg-white/[0.06] border-b border-white/[0.08]">
              <div class="flex items-center gap-2.5">
                <div class="w-7 h-7 rounded-lg bg-green-600 flex items-center justify-center flex-shrink-0">
                  <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 21h16.5M4.5 3h15M5.25 3v18m13.5-18v18M9 6.75h1.5m-1.5 3h1.5m-1.5 3h1.5m3-6H15m-1.5 3H15m-1.5 3H15M9 21v-3.375c0-.621.504-1.125 1.125-1.125h3.75c.621 0 1.125.504 1.125 1.125V21" />
                  </svg>
                </div>
                <div>
                  <p class="text-[11px] font-black text-white">PetFlow</p>
                  <p class="text-[9px] text-white/40">Casa de Ração do João – Dashboard</p>
                </div>
              </div>
              <div class="flex items-center gap-1.5 bg-green-500/20 border border-green-400/30 px-2.5 py-1 rounded-full">
                <span class="w-1.5 h-1.5 rounded-full bg-green-400 animate-pulse" />
                <span class="text-[9px] font-bold text-green-300">ao vivo</span>
              </div>
            </div>

            <!-- Stats grid -->
            <div class="grid grid-cols-2 gap-2.5 p-4">
              <div v-for="stat in heroStats" :key="stat.label"
                class="bg-white/[0.07] hover:bg-white/[0.11] rounded-2xl px-4 py-3 border border-white/[0.08] transition-colors cursor-default">
                <p class="text-[9px] font-black uppercase tracking-widest text-white/45">{{ stat.label }}</p>
                <p class="text-[1.65rem] font-black text-white mt-1 leading-none">{{ stat.value }}</p>
                <div class="flex items-center gap-1 mt-1.5">
                  <svg class="w-3 h-3 flex-shrink-0" :class="stat.color" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18L9 11.25l4.306 4.307a11.95 11.95 0 015.814-5.518l2.74-1.22m0 0l-5.94-2.281m5.94 2.28l-2.28 5.941" />
                  </svg>
                  <span class="text-[9px] font-semibold" :class="stat.color">{{ stat.sub }}</span>
                </div>
              </div>
            </div>

            <!-- Recent sales -->
            <div class="px-4 pb-4">
              <div class="flex items-center justify-between mb-2.5">
                <p class="text-[10px] font-black text-white/40 uppercase tracking-widest">Últimas vendas</p>
                <span class="text-[9px] text-green-400 font-bold cursor-default">Ver todas ?</span>
              </div>
              <div class="flex flex-col gap-1.5">
                <div v-for="sale in recentSales" :key="sale.id"
                  class="flex items-center gap-3 bg-white/[0.05] hover:bg-white/[0.09] border border-white/[0.07] rounded-xl px-3 py-2 transition-colors cursor-default">
                  <div class="w-7 h-7 rounded-lg flex items-center justify-center flex-shrink-0 font-black text-[10px] text-white" :class="sale.bg">
                    {{ sale.initials }}
                  </div>
                  <div class="flex-1 min-w-0">
                    <p class="text-[11px] font-bold text-white/90 truncate">{{ sale.name }}</p>
                    <p class="text-[9px] text-white/35">{{ sale.time }}</p>
                  </div>
                  <span class="text-[11px] font-black text-green-300 flex-shrink-0 tabular-nums">{{ sale.amount }}</span>
                </div>
              </div>
            </div>
          </div>

          <!-- Mini chips -->
          <div class="grid grid-cols-3 gap-2.5">
            <div v-for="m in heroMini" :key="m.label"
              class="bg-white/[0.07] backdrop-blur-sm border border-white/[0.12] rounded-2xl p-4 text-center hover:bg-white/[0.12] transition-colors">
              <p class="text-lg font-black text-white">{{ m.value }}</p>
              <p class="text-[10px] text-green-200/55 mt-0.5">{{ m.label }}</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Scroll hint -->
      <div class="absolute bottom-14 left-1/2 -translate-x-1/2 hidden md:flex flex-col items-center gap-1.5 animate-bounce z-10 pointer-events-none">
        <span class="text-[9px] font-bold text-white/30 uppercase tracking-widest">role para baixo</span>
        <svg class="w-4 h-4 text-white/25" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 8.25l-7.5 7.5-7.5-7.5" />
        </svg>
      </div>

      <!-- Wave -->
      <div class="absolute bottom-0 inset-x-0">
        <svg viewBox="0 0 1440 80" fill="none" xmlns="http://www.w3.org/2000/svg" class="w-full">
          <path d="M0 80V45C240 5 480 75 720 45C960 15 1200 70 1440 45V80H0Z" fill="white" />
        </svg>
      </div>
    </section>

    <!-- POR QUE USAR -->
    <section id="sistema" class="py-20 bg-white">
      <div class="max-w-6xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-14">
          <span class="text-xs font-black text-orange-500 uppercase tracking-widest">Por que o sistema?</span>
          <h2 class="mt-2 text-3xl sm:text-4xl font-black text-gray-900 leading-tight">
            Sem controle, você trabalha mais<br class="hidden sm:block" /> e lucra menos
          </h2>
          <p class="mt-3 text-gray-500 max-w-2xl mx-auto">
            O sistema PetFlow centraliza toda a operação da sua loja para você enxergar o que está acontecendo e agir com mais certeza.
          </p>
        </div>

        <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-5">
          <div v-for="p in problemas" :key="p.title" class="flex gap-4 p-5 rounded-2xl bg-red-50 border border-red-100">
            <div class="w-10 h-10 flex-shrink-0 rounded-xl bg-red-100 flex items-center justify-center">
              <svg class="w-5 h-5 text-red-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z" />
              </svg>
            </div>
            <div>
              <p class="font-bold text-gray-800 text-sm">{{ p.title }}</p>
              <p class="text-xs text-gray-500 mt-0.5 leading-relaxed">{{ p.desc }}</p>
            </div>
          </div>
        </div>

        <div class="mt-12 rounded-3xl bg-gradient-to-r from-green-600 to-green-800 p-8 text-center text-white shadow-xl">
          <p class="text-lg font-black">O PetFlow resolve cada um desses problemas.</p>
          <p class="text-green-200 text-sm mt-1">Tudo em uma plataforma, acessível de qualquer dispositivo.</p>
        </div>
      </div>
    </section>

    <!-- MÓDULOS -->
    <section id="modulos" class="py-20 bg-gray-50">
      <div class="max-w-6xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-14">
          <span class="text-xs font-black text-green-600 uppercase tracking-widest">O que está incluído</span>
          <h2 class="mt-2 text-3xl sm:text-4xl font-black text-gray-900">6 módulos completos</h2>
          <p class="mt-3 text-gray-500 max-w-2xl mx-auto">
            Tudo que sua loja precisa para funcionar com organização e visibilidade - sem precisar de vários sistemas separados.
          </p>
        </div>

        <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-5">
          <div v-for="mod in modulos" :key="mod.title"
            class="bg-white rounded-3xl p-6 border border-gray-100 shadow-sm hover:shadow-lg hover:-translate-y-1 transition-all duration-200">
            <div class="w-12 h-12 rounded-2xl flex items-center justify-center mb-4" :class="mod.iconBg">
              <span v-html="mod.icon" :class="mod.iconColor" />
            </div>
            <h3 class="font-black text-gray-800 text-base">{{ mod.title }}</h3>
            <p class="text-xs text-gray-500 mt-1.5 leading-relaxed">{{ mod.desc }}</p>
            <ul class="mt-4 flex flex-col gap-2">
              <li v-for="f in mod.features" :key="f" class="flex items-start gap-2 text-xs text-gray-600">
                <svg class="w-4 h-4 text-green-500 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5" />
                </svg>
                {{ f }}
              </li>
            </ul>
          </div>
        </div>

        <div class="mt-10 rounded-3xl overflow-hidden">
          <div class="relative bg-gradient-to-br from-green-900 via-green-700 to-green-600 p-8 sm:p-10 flex flex-col sm:flex-row items-center justify-between gap-6">
            <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_right,rgba(240,112,16,0.18),transparent_60%)]" />
            <div class="relative z-10">
              <p class="text-2xl font-black text-white">Acesso 100% na nuvem</p>
              <p class="text-green-200 text-sm mt-1">Sem instalação. Funciona no celular, tablet e computador.</p>
            </div>
            <a href="#contato"
              class="relative z-10 flex-shrink-0 inline-flex items-center gap-2 bg-white text-green-700 font-black text-sm px-6 py-3 rounded-2xl shadow hover:bg-green-50 transition-colors">
              Solicitar Demonstração
            </a>
          </div>
        </div>
      </div>
    </section>

    <!-- MOBILE -->
    <section class="py-20 bg-white overflow-hidden">
      <div class="max-w-6xl mx-auto px-4 sm:px-6">
        <div class="flex flex-col lg:flex-row items-center gap-12 lg:gap-20">

          <!-- Ilustração do celular -->
          <div class="w-full lg:w-auto flex justify-center shrink-0 order-2 lg:order-1">
            <div class="relative">
              <!-- Brilho de fundo -->
              <div class="absolute inset-0 bg-gradient-to-br from-green-400/20 to-orange-300/20 rounded-full blur-3xl scale-110 pointer-events-none" />

              <!-- Frame do celular -->
              <div class="relative w-[220px] sm:w-[260px] bg-gray-900 rounded-[2.8rem] p-[10px] shadow-[0_40px_80px_rgba(0,0,0,0.28)] ring-4 ring-white/10">
                <!-- Notch -->
                <div class="absolute top-[14px] left-1/2 -translate-x-1/2 w-20 h-5 bg-gray-900 rounded-full z-20" />
                <!-- Tela -->
                <div class="bg-gray-50 rounded-[2.2rem] overflow-hidden h-[440px] sm:h-[520px] flex flex-col">
                  <!-- Status bar -->
                  <div class="flex items-center justify-between px-5 pt-8 pb-2 bg-gradient-to-br from-green-900 to-green-700 shrink-0">
                    <span class="text-[9px] font-bold text-white/70">9:41</span>
                    <div class="flex gap-1 items-center">
                      <svg class="w-3 h-3 text-white/70" fill="currentColor" viewBox="0 0 24 24"><path d="M1.5 8.25C5.15 4.6 10.32 2.5 12 2.5s6.85 2.1 10.5 5.75l-1.5 1.5C17.85 6.6 14.6 4.5 12 4.5S6.15 6.6 3 9.75l-1.5-1.5zm3 3C6.65 9.1 9.2 7.5 12 7.5s5.35 1.6 7.5 3.75l-1.5 1.5C16.35 11.1 14.3 9.5 12 9.5s-4.35 1.6-6 3.25l-1.5-1.5zm3 3c1.1-1.1 2.8-2 3-2s2 .9 3 2l-1.5 1.5c-.4-.4-1-.9-1.5-1s-1.1.6-1.5 1L7.5 14.25z"/></svg>
                      <svg class="w-3.5 h-3.5 text-white/70" fill="currentColor" viewBox="0 0 24 24"><rect x="2" y="7" width="18" height="11" rx="2"/><path d="M22 11v3a1 1 0 01-1 1h-1V10h1a1 1 0 011 1z"/></svg>
                    </div>
                  </div>
                  <!-- App header -->
                  <div class="px-4 pt-3 pb-3 bg-gradient-to-br from-green-900 to-green-700 shrink-0">
                    <div class="flex items-center gap-2">
                      <div class="w-7 h-7 rounded-xl bg-white/20 flex items-center justify-center">
                        <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3.75 21h16.5M4.5 3h15M5.25 3v18m13.5-18v18M9 6.75h1.5m-1.5 3h1.5m-1.5 3h1.5m3-6H15m-1.5 3H15m-1.5 3H15M9 21v-3.375c0-.621.504-1.125 1.125-1.125h3.75c.621 0 1.125.504 1.125 1.125V21"/></svg>
                      </div>
                      <div>
                        <p class="text-[10px] font-black text-green-300 uppercase tracking-wider">PetFlow</p>
                        <p class="text-white font-black text-sm leading-tight">Visão Geral</p>
                      </div>
                    </div>
                  </div>
                  <!-- Conteúdo do app -->
                  <div class="flex-1 overflow-hidden px-3 py-3 flex flex-col gap-2.5 bg-gray-50">
                    <!-- Cards de stats -->
                    <div class="grid grid-cols-2 gap-2">
                      <div class="bg-white rounded-2xl p-3 shadow-sm border border-gray-100">
                        <p class="text-[9px] font-bold text-gray-400 uppercase tracking-wider">Faturamento</p>
                        <p class="text-base font-black text-gray-800 mt-0.5">R$12,4k</p>
                        <p class="text-[9px] text-green-600 font-semibold">? +8% hoje</p>
                      </div>
                      <div class="bg-white rounded-2xl p-3 shadow-sm border border-gray-100">
                        <p class="text-[9px] font-bold text-gray-400 uppercase tracking-wider">Vendas</p>
                        <p class="text-base font-black text-gray-800 mt-0.5">47</p>
                        <p class="text-[9px] text-blue-500 font-semibold">este mês</p>
                      </div>
                      <div class="bg-white rounded-2xl p-3 shadow-sm border border-gray-100">
                        <p class="text-[9px] font-bold text-gray-400 uppercase tracking-wider">Estoque</p>
                        <p class="text-base font-black text-gray-800 mt-0.5">312</p>
                        <p class="text-[9px] text-purple-500 font-semibold">produtos</p>
                      </div>
                      <div class="bg-orange-50 rounded-2xl p-3 shadow-sm border border-orange-100">
                        <p class="text-[9px] font-bold text-orange-400 uppercase tracking-wider">Alerta</p>
                        <p class="text-base font-black text-orange-700 mt-0.5">3</p>
                        <p class="text-[9px] text-orange-500 font-semibold">estoque baixo</p>
                      </div>
                    </div>
                    <!-- Lista de vendas recentes -->
                    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                      <p class="text-[9px] font-black text-gray-400 uppercase tracking-wider px-3 pt-2.5 pb-1">Últimas vendas</p>
                      <div class="divide-y divide-gray-50">
                        <div class="flex items-center justify-between px-3 py-1.5">
                          <div class="flex items-center gap-2">
                            <div class="w-5 h-5 rounded-full bg-blue-500 flex items-center justify-center text-white font-black text-[8px]">M</div>
                            <span class="text-[10px] font-semibold text-gray-700">Maria S.</span>
                          </div>
                          <span class="text-[10px] font-black text-green-600">R$ 89,00</span>
                        </div>
                        <div class="flex items-center justify-between px-3 py-1.5">
                          <div class="flex items-center gap-2">
                            <div class="w-5 h-5 rounded-full bg-purple-500 flex items-center justify-center text-white font-black text-[8px]">C</div>
                            <span class="text-[10px] font-semibold text-gray-700">Carlos P.</span>
                          </div>
                          <span class="text-[10px] font-black text-green-600">R$ 134,50</span>
                        </div>
                        <div class="flex items-center justify-between px-3 py-1.5">
                          <div class="flex items-center gap-2">
                            <div class="w-5 h-5 rounded-full bg-orange-500 flex items-center justify-center text-white font-black text-[8px]">A</div>
                            <span class="text-[10px] font-semibold text-gray-700">Ana L.</span>
                          </div>
                          <span class="text-[10px] font-black text-green-600">R$ 47,00</span>
                        </div>
                      </div>
                    </div>
                  </div>
                  <!-- Bottom nav do app -->
                  <div class="bg-white border-t border-gray-100 px-4 py-2 flex items-center justify-around shrink-0">
                    <div class="flex flex-col items-center gap-0.5">
                      <div class="w-5 h-5 bg-green-600 rounded-lg flex items-center justify-center">
                        <svg class="w-3 h-3 text-white" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 12l8.954-8.955a1.126 1.126 0 011.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75"/></svg>
                      </div>
                      <span class="text-[7px] font-bold text-green-600">Início</span>
                    </div>
                    <div class="flex flex-col items-center gap-0.5">
                      <svg class="w-5 h-5 text-gray-300" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 14.25l6-6m4.5-3.493V21.75l-3.75-1.5-3.75 1.5-3.75-1.5-3.75 1.5V4.757c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0111.186 0c1.1.128 1.907 1.077 1.907 2.185z"/></svg>
                      <span class="text-[7px] font-bold text-gray-300">Vendas</span>
                    </div>
                    <div class="flex flex-col items-center gap-0.5">
                      <svg class="w-5 h-5 text-gray-300" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M20.25 7.5l-.625 10.632a2.25 2.25 0 01-2.247 2.118H6.622a2.25 2.25 0 01-2.247-2.118L3.75 7.5M10 11.25h4"/></svg>
                      <span class="text-[7px] font-bold text-gray-300">Estoque</span>
                    </div>
                    <div class="flex flex-col items-center gap-0.5">
                      <svg class="w-5 h-5 text-gray-300" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z"/></svg>
                      <span class="text-[7px] font-bold text-gray-300">Perfil</span>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Badge flutuante -->
              <div class="absolute -bottom-4 -right-4 bg-white rounded-2xl shadow-xl border border-gray-100 px-4 py-2.5 flex items-center gap-2.5">
                <div class="w-8 h-8 rounded-xl bg-green-100 flex items-center justify-center shrink-0">
                  <svg class="w-4 h-4 text-green-600" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M10.5 1.5H8.25A2.25 2.25 0 006 3.75v16.5a2.25 2.25 0 002.25 2.25h7.5A2.25 2.25 0 0018 20.25V3.75a2.25 2.25 0 00-2.25-2.25H13.5m-3 0V3h3V1.5m-3 0h3m-3 18.75h3"/></svg>
                </div>
                <div>
                  <p class="text-xs font-black text-gray-800 leading-tight">100% mobile</p>
                  <p class="text-[10px] text-gray-400">sem instalação</p>
                </div>
              </div>
              <div class="absolute -top-4 -left-4 bg-orange-500 rounded-2xl shadow-xl px-4 py-2.5 flex items-center gap-2">
                <svg class="w-4 h-4 text-white shrink-0" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                <p class="text-xs font-black text-white">Atualiza em tempo real</p>
              </div>
            </div>
          </div>

          <!-- Texto -->
          <div class="flex flex-col gap-6 order-1 lg:order-2">
            <div>
              <span class="text-xs font-black text-orange-500 uppercase tracking-widest">Acesso Mobile</span>
              <h2 class="mt-2 text-3xl sm:text-4xl font-black text-gray-900 leading-tight">
                Gerencie sua loja<br />
                <span class="text-transparent bg-clip-text bg-gradient-to-r from-green-600 to-green-800">de qualquer lugar</span>
              </h2>
              <p class="mt-4 text-gray-500 leading-relaxed">
                O PetFlow funciona perfeitamente no celular, tablet e computador. Sem aplicativo para instalar - ssó abrir o navegador e usar.
              </p>
            </div>

            <div class="flex flex-col gap-3">
              <div v-for="item in mobileFeatures" :key="item.title" class="flex items-start gap-4 p-4 rounded-2xl bg-gray-50 border border-gray-100 hover:border-green-100 hover:bg-green-50/30 transition-colors">
                <div class="w-10 h-10 rounded-xl flex items-center justify-center shrink-0" :class="item.iconBg">
                  <span v-html="item.icon" :class="item.iconColor" />
                </div>
                <div>
                  <p class="font-bold text-gray-800 text-sm">{{ item.title }}</p>
                  <p class="text-xs text-gray-500 mt-0.5 leading-relaxed">{{ item.desc }}</p>
                </div>
              </div>
            </div>

            <a href="#contato"
              class="self-start inline-flex items-center gap-2 bg-green-600 hover:bg-green-700 text-white font-black px-6 py-3.5 rounded-2xl text-sm transition-all shadow-md hover:scale-[1.03]">
              Quero testar gratuitamente
              <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M17.25 8.25L21 12m0 0l-3.75 3.75M21 12H3"/></svg>
            </a>
          </div>
        </div>
      </div>
    </section>

    <!-- COMO FUNCIONA -->
    <section class="py-20 bg-white">
      <div class="max-w-5xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-14">
          <span class="text-xs font-black text-green-600 uppercase tracking-widest">Processo</span>
          <h2 class="mt-2 text-3xl sm:text-4xl font-black text-gray-900">Como começamos juntos</h2>
        </div>

        <div class="relative">
          <div class="hidden lg:block absolute top-10 left-[10%] right-[10%] h-0.5 bg-gradient-to-r from-green-200 via-orange-200 to-blue-200" />
          <div class="grid sm:grid-cols-2 lg:grid-cols-4 gap-8">
            <div v-for="(step, i) in etapas" :key="step.title" class="flex flex-col items-center text-center gap-3">
              <div class="relative w-20 h-20 rounded-2xl flex items-center justify-center shadow-md z-10" :class="step.bg">
                <span v-html="step.icon" :class="step.iconColor" />
                <span class="absolute -top-2 -right-2 w-6 h-6 rounded-full bg-white border-2 text-xs font-black flex items-center justify-center" :class="step.numColor">{{ i + 1 }}</span>
              </div>
              <p class="font-black text-gray-800 text-sm">{{ step.title }}</p>
              <p class="text-xs text-gray-500 leading-relaxed">{{ step.desc }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- PLANOS -->
    <section id="planos" class="py-20 bg-gray-50">
      <div class="max-w-6xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-14">
          <span class="text-xs font-black text-green-600 uppercase tracking-widest">Investimento</span>
          <h2 class="mt-2 text-3xl sm:text-4xl font-black text-gray-900">Planos do Sistema PetFlow</h2>
          <p class="mt-3 text-gray-500 max-w-xl mx-auto">Escolha o plano que melhor se encaixa no tamanho e momento da sua loja.</p>
        </div>

        <div class="grid md:grid-cols-3 gap-6 items-stretch">
          <div v-for="plano in planos" :key="plano.name"
            class="relative flex flex-col rounded-3xl border transition-transform hover:-translate-y-1 duration-200"
            :class="plano.featured
              ? 'bg-gradient-to-b from-green-700 to-green-900 border-green-600 shadow-2xl scale-[1.02]'
              : 'bg-white border-gray-100 shadow-sm'">

            <div v-if="plano.featured" class="absolute -top-3.5 inset-x-0 flex justify-center">
              <span class="bg-orange-500 text-white text-[10px] font-black px-4 py-1 rounded-full uppercase tracking-widest shadow">Mais Popular</span>
            </div>

            <div class="p-7 flex flex-col gap-5 flex-1">
              <div>
                <p class="text-xs font-black uppercase tracking-widest" :class="plano.featured ? 'text-green-300' : 'text-gray-400'">{{ plano.label }}</p>
                <h3 class="text-xl font-black mt-1" :class="plano.featured ? 'text-white' : 'text-gray-900'">{{ plano.name }}</h3>
                <p class="text-xs mt-1 leading-relaxed" :class="plano.featured ? 'text-green-200' : 'text-gray-500'">{{ plano.desc }}</p>
              </div>

              <div>
                <div class="flex items-end gap-1">
                  <span class="text-sm font-bold" :class="plano.featured ? 'text-green-300' : 'text-gray-400'">R$</span>
                  <span class="text-5xl font-black leading-none" :class="plano.featured ? 'text-white' : 'text-gray-900'">{{ plano.price }}</span>
                  <span class="text-sm font-semibold pb-1" :class="plano.featured ? 'text-green-300' : 'text-gray-400'">/mês</span>
                </div>
                <p class="text-xs mt-1" :class="plano.featured ? 'text-green-300/80' : 'text-gray-400'">+ R$ 997 de implantação única</p>
              </div>

              <ul class="flex flex-col gap-2.5 flex-1">
                <li v-for="item in plano.includes" :key="item.text"
                  class="flex items-start gap-2.5 text-xs"
                  :class="item.active
                    ? (plano.featured ? 'text-green-50' : 'text-gray-700')
                    : (plano.featured ? 'text-green-200/50' : 'text-gray-400')">
                  <svg class="w-4 h-4 flex-shrink-0 mt-0.5"
                    :class="item.active ? 'text-green-400' : (plano.featured ? 'text-green-200/40' : 'text-gray-300')"
                    fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                    <path v-if="item.active" stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5" />
                    <path v-else stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                  {{ item.text }}
                </li>
              </ul>

              <a href="#contato"
                class="mt-2 block text-center font-black text-sm px-5 py-3 rounded-2xl transition-all"
                :class="plano.featured
                  ? 'bg-orange-500 hover:bg-orange-400 text-white shadow-lg'
                  : 'bg-green-600 hover:bg-green-700 text-white'">
                {{ plano.cta }}
              </a>
            </div>
          </div>
        </div>

        <p class="text-center text-xs text-gray-400 mt-8">* Taxa de implantação única de R$ 297 - inclui configuração completa + treinamento da equipe.</p>
      </div>
    </section>

    <!-- DIFERENCIAIS -->
    <section class="py-20 bg-white">
      <div class="max-w-6xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-14">
          <span class="text-xs font-black text-green-600 uppercase tracking-widest">Diferenciais</span>
          <h2 class="mt-2 text-3xl sm:text-4xl font-black text-gray-900">Por que o PetFlow?</h2>
        </div>

        <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-5">
          <div v-for="d in diferenciais" :key="d.title"
            class="flex gap-4 p-5 rounded-2xl bg-gray-50 border border-gray-100 hover:border-green-100 hover:bg-green-50/30 transition-colors">
            <div class="w-10 h-10 flex-shrink-0 rounded-xl flex items-center justify-center" :class="d.iconBg">
              <span v-html="d.icon" :class="d.iconColor" />
            </div>
            <div>
              <p class="font-bold text-gray-800 text-sm">{{ d.title }}</p>
              <p class="text-xs text-gray-500 mt-0.5 leading-relaxed">{{ d.desc }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- FAQ -->
    <section class="py-20 bg-gray-50">
      <div class="max-w-3xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-12">
          <span class="text-xs font-black text-green-600 uppercase tracking-widest">Dúvidas</span>
          <h2 class="mt-2 text-3xl font-black text-gray-900">Perguntas Frequentes</h2>
        </div>

        <div class="flex flex-col gap-3">
          <div v-for="faq in faqs" :key="faq.q" class="rounded-2xl border border-gray-100 bg-white overflow-hidden">
            <button class="w-full flex items-center justify-between gap-4 px-5 py-4 text-left" @click="toggleFaq(faq.q)">
              <span class="font-bold text-gray-800 text-sm">{{ faq.q }}</span>
              <svg class="w-5 h-5 text-gray-400 flex-shrink-0 transition-transform duration-200"
                :class="openFaq === faq.q ? 'rotate-180' : ''"
                fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 8.25l-7.5 7.5-7.5-7.5" />
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
    <section id="contato" class="py-20 bg-gradient-to-br from-green-900 via-green-700 to-green-600 relative overflow-hidden">
      <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_top_left,rgba(240,112,16,0.2),transparent_55%)]" />
      <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_bottom_right,rgba(37,77,142,0.22),transparent_60%)]" />

      <div class="relative z-10 max-w-4xl mx-auto px-4 sm:px-6">
        <div class="text-center mb-12">
          <span class="text-xs font-black text-orange-300 uppercase tracking-widest">Próximo Passo</span>
          <h2 class="mt-2 text-3xl sm:text-4xl font-black text-white leading-tight">
            Pronto para ter controle total<br />da sua loja?
          </h2>
          <p class="mt-3 text-green-100/80 max-w-lg mx-auto">
            Preencha o formulário e nossa equipe entrará em contato em até 24 horas com uma proposta personalizada.
          </p>
        </div>

        <div class="bg-white rounded-3xl p-7 sm:p-10 shadow-2xl">
          <form @submit.prevent="enviarFormulario" class="grid sm:grid-cols-2 gap-5">
            <div class="flex flex-col gap-1.5">
              <label class="text-xs font-bold text-gray-700 uppercase tracking-wider">Nome Completo *</label>
              <input v-model="form.nome" type="text" required placeholder="Seu nome"
                class="border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition" />
            </div>
            <div class="flex flex-col gap-1.5">
              <label class="text-xs font-bold text-gray-700 uppercase tracking-wider">Nome da Loja *</label>
              <input v-model="form.loja" type="text" required placeholder="Nome do estabelecimento"
                class="border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition" />
            </div>
            <div class="flex flex-col gap-1.5">
              <label class="text-xs font-bold text-gray-700 uppercase tracking-wider">WhatsApp *</label>
              <input v-model="form.whatsapp" type="tel" required placeholder="(00) 00000-0000"
                class="border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition" />
            </div>
            <div class="flex flex-col gap-1.5">
              <label class="text-xs font-bold text-gray-700 uppercase tracking-wider">E-mail</label>
              <input v-model="form.email" type="email" placeholder="seu@email.com"
                class="border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition" />
            </div>
            <div class="flex flex-col gap-1.5 sm:col-span-2">
              <label class="text-xs font-bold text-gray-700 uppercase tracking-wider">Plano de Interesse</label>
              <div class="flex flex-wrap gap-2">
                <button v-for="opt in planoOpts" :key="opt" type="button" @click="toggleInteresse(opt)"
                  class="text-xs font-semibold px-3 py-1.5 rounded-xl border transition-all"
                  :class="form.interesses.includes(opt)
                    ? 'bg-green-600 text-white border-green-600'
                    : 'bg-gray-50 text-gray-600 border-gray-200 hover:border-green-400'">
                  {{ opt }}
                </button>
              </div>
            </div>
            <div class="flex flex-col gap-1.5 sm:col-span-2">
              <label class="text-xs font-bold text-gray-700 uppercase tracking-wider">Mensagem</label>
              <textarea v-model="form.mensagem" rows="3" placeholder="Conte um pouco sobre sua loja..."
                class="border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-800 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition resize-none" />
            </div>
            <div class="sm:col-span-2">
              <button type="submit" :disabled="enviando"
                class="w-full flex items-center justify-center gap-2 bg-green-600 hover:bg-green-700 disabled:opacity-60 text-white font-black text-base px-8 py-4 rounded-2xl transition-all shadow-lg">
                <svg v-if="!enviando" class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6 12L3.269 3.126A59.768 59.768 0 0121.485 12 59.77 59.77 0 013.27 20.876L5.999 12zm0 0h7.5" />
                </svg>
                <svg v-else class="w-5 h-5 animate-spin" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" />
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z" />
                </svg>
                {{ enviando ? 'Enviando...' : 'Quero o Sistema PetFlow' }}
              </button>
            </div>
          </form>

          <div v-if="enviado" class="mt-6 flex items-center gap-3 bg-green-50 border border-green-200 rounded-2xl p-4">
            <svg class="w-6 h-6 text-green-500 flex-shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <p class="text-sm text-green-700 font-semibold">Recebemos sua solicitação! Entraremos em contato em breve.</p>
          </div>
        </div>

        <div class="mt-8 text-center">
          <p class="text-green-200/80 text-sm mb-3">Prefere falar agora?</p>
          <a href="https://wa.me/5500000000000?text=Ol%C3%A1!%20Vi%20a%20proposta%20do%20sistema%20PetFlow%20e%20quero%20saber%20mais."
            target="_blank" rel="noopener noreferrer"
            class="inline-flex items-center gap-2.5 bg-[#25D366] hover:bg-[#20c45a] text-white font-black px-7 py-3.5 rounded-2xl text-sm transition-all shadow-lg hover:scale-105">
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
              <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z" />
            </svg>
            Conversar pelo WhatsApp
          </a>
        </div>
      </div>
    </section>

    <!-- FOOTER -->
    <footer class="bg-gray-900 text-gray-400 py-10">
      <div class="max-w-6xl mx-auto px-4 sm:px-6 flex flex-col sm:flex-row items-center justify-between gap-4">
        <div class="flex items-center gap-2">
          <div class="w-8 h-8 rounded-xl bg-green-600 flex items-center justify-center">
            <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 21h16.5M4.5 3h15M5.25 3v18m13.5-18v18M9 6.75h1.5m-1.5 3h1.5m-1.5 3h1.5m3-6H15m-1.5 3H15m-1.5 3H15M9 21v-3.375c0-.621.504-1.125 1.125-1.125h3.75c.621 0 1.125.504 1.125 1.125V21" />
            </svg>
          </div>
          <span class="text-white font-black">PetFlow</span>
        </div>
        <p class="text-xs text-center">© {{ new Date().getFullYear() }} PetFlow. Todos os direitos reservados.</p>
        <p class="text-xs">Sistema de Gestão</p>
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
  'Acesso em qualquer dispositivo',
  'Sem instalação',
  'Suporte humanizado',
  'Implantação assistida',
]

const heroStats = [
  { label: 'Faturamento', value: 'R$42k', sub: '+12% este mês', color: 'text-green-400' },
  { label: 'Clientes', value: '318', sub: '+8 essa semana', color: 'text-blue-300' },
  { label: 'Produtos', value: '1.2k', sub: 'em estoque', color: 'text-purple-300' },
  { label: 'Tarefas', value: '97%', sub: 'concluídas hoje', color: 'text-orange-300' },
]

const heroMini = [
  { value: '100%', label: 'na nuvem' },
  { value: '6', label: 'módulos' },
  { value: '0', label: 'instalação' },
]

const recentSales = [
  { id: 1, name: 'Maria Souza', time: 'há 2 min', amount: 'R$ 189,00', initials: 'MS', bg: 'bg-blue-600' },
  { id: 2, name: 'Carlos Pereira', time: 'há 15 min', amount: 'R$ 67,50', initials: 'CP', bg: 'bg-purple-600' },
  { id: 3, name: 'Ana Lima', time: 'há 38 min', amount: 'R$ 312,00', initials: 'AL', bg: 'bg-orange-600' },
]

const problemas = [
  { title: 'Estoque sem controle', desc: 'Produto faltando na hora errada ou parado sem giro - você perde venda e dinheiro.' },
  { title: 'Sem visão financeira', desc: 'Não sabe exatamente quanto entra, quanto sai e qual é o lucro real do mês.' },
  { title: 'Clientes sem histórico', desc: 'Sem cadastro organizado, você perde oportunidades de fidelizar e vender mais.' },
  { title: 'Equipe desalinhada', desc: 'Funcionários sem tarefas definidas, gerando retrabalho e baixa produtividade.' },
  { title: 'Vendas sem relatório', desc: 'Você não sabe o que mais vende, quem compra mais ou qual período performa melhor.' },
  { title: 'Decisões no achismo', desc: 'Sem dados claros, cada decisão importante vira um risco desnecessário.' },
]

const icons = {
  users: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.75" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z"/></svg>`,
  box: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.75" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M21 7.5l-9-4.5-9 4.5m18 0v9l-9 4.5m9-13.5l-9 4.5m0 0L3 7.5m9 4.5V21"/></svg>`,
  money: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.75" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18.75a60.07 60.07 0 0119.5 0m-18-12a60.07 60.07 0 0116.5 0M12 6v12m3-9.75c0-.621-1.343-1.125-3-1.125S9 7.629 9 8.25 10.343 9.375 12 9.375s3 .504 3 1.125-1.343 1.125-3 1.125-3 .504-3 1.125 1.343 1.125 3 1.125 3 .504 3 1.125"/></svg>`,
  team: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.75" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M18 18.72a9.094 9.094 0 003.741-.479 3 3 0 00-4.682-2.72m.94 3.198l.001.031c0 .225-.012.447-.037.666A11.944 11.944 0 0112 21c-2.17 0-4.207-.576-5.963-1.584A6.062 6.062 0 016 18.719m12 0a5.971 5.971 0 00-.941-3.197m0 0A5.995 5.995 0 0012 12.75a5.995 5.995 0 00-5.058 2.772m0 0a3 3 0 00-4.681 2.72 8.986 8.986 0 003.74.477m.94-3.197a5.971 5.971 0 00-.94 3.197M15 6.75a3 3 0 11-6 0 3 3 0 016 0zm6 3a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0zm-13.5 0a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0z"/></svg>`,
  wallet: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.75" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M21 12a2.25 2.25 0 00-2.25-2.25H5.25A2.25 2.25 0 003 12m18 0v6a2.25 2.25 0 01-2.25 2.25H5.25A2.25 2.25 0 013 18v-6m18 0V9M3 12V9m18 0a2.25 2.25 0 00-2.25-2.25H5.25A2.25 2.25 0 003 9m18 0V6a2.25 2.25 0 00-2.25-2.25H5.25A2.25 2.25 0 003 6v3"/></svg>`,
  clipboard: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.75" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"/></svg>`,
  chat: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-8 h-8"><path stroke-linecap="round" stroke-linejoin="round" d="M8.625 12a.375.375 0 11-.75 0 .375.375 0 01.75 0zm0 0H8.25m4.125 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm0 0H12m4.125 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm0 0h-.375M21 12c0 4.556-4.03 8.25-9 8.25a9.764 9.764 0 01-2.555-.337A5.972 5.972 0 015.41 20.97a5.969 5.969 0 01-.474-.065 4.48 4.48 0 00.978-2.025c.09-.457-.133-.901-.467-1.226C3.93 16.178 3 14.189 3 12c0-4.556 4.03-8.25 9-8.25s9 3.694 9 8.25z"/></svg>`,
  doc: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-8 h-8"><path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z"/></svg>`,
  monitor: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-8 h-8"><path stroke-linecap="round" stroke-linejoin="round" d="M3 5.25A2.25 2.25 0 015.25 3h13.5A2.25 2.25 0 0121 5.25v9.5A2.25 2.25 0 0118.75 17H5.25A2.25 2.25 0 013 14.75v-9.5zM8.25 21h7.5"/></svg>`,
  loop: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-8 h-8"><path stroke-linecap="round" stroke-linejoin="round" d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99"/></svg>`,
  shield: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75m-3-7.036A11.959 11.959 0 013.598 6 11.99 11.99 0 003 9.749c0 5.592 3.824 10.29 9 11.623 5.176-1.332 9-6.03 9-11.622 0-1.31-.21-2.571-.598-3.751h-.152c-3.196 0-6.1-1.248-8.25-3.285z"/></svg>`,
  support: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M8.625 12a.375.375 0 11-.75 0 .375.375 0 01.75 0zm0 0H8.25m4.125 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm0 0H12m4.125 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm0 0h-.375M21 12c0 4.556-4.03 8.25-9 8.25a9.764 9.764 0 01-2.555-.337A5.972 5.972 0 015.41 20.97a5.969 5.969 0 01-.474-.065 4.48 4.48 0 00.978-2.025c.09-.457-.133-.901-.467-1.226C3.93 16.178 3 14.189 3 12c0-4.556 4.03-8.25 9-8.25s9 3.694 9 8.25z"/></svg>`,
  refresh: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99"/></svg>`,
  phone: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M10.5 1.5H8.25A2.25 2.25 0 006 3.75v16.5a2.25 2.25 0 002.25 2.25h7.5A2.25 2.25 0 0018 20.25V3.75a2.25 2.25 0 00-2.25-2.25H13.5m-3 0V3h3V1.5m-3 0h3m-3 18.75h3"/></svg>`,
  heart: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z"/></svg>`,
  star: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.9" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M11.48 3.499a.562.562 0 011.04 0l2.125 5.111a.563.563 0 00.475.345l5.518.442c.499.04.701.663.321.988l-4.204 3.602a.563.563 0 00-.182.557l1.285 5.385a.562.562 0 01-.84.61l-4.725-2.885a.563.563 0 00-.586 0L6.982 20.54a.562.562 0 01-.84-.61l1.285-5.386a.562.562 0 00-.182-.557l-4.204-3.602a.563.563 0 01.321-.988l5.518-.442a.563.563 0 00.475-.345L11.48 3.5z"/></svg>`,
}

const modulos = [
  {
    title: 'Gestão de Clientes',
    desc: 'Cadastro completo de clientes, histórico de compras e relacionamento organizado.',
    iconBg: 'bg-blue-50',
    iconColor: 'text-blue-600',
    icon: icons.users,
    features: ['Ficha completa do cliente', 'Histórico de compras e serviços', 'Fácil consulta e pesquisa'],
  },
  {
    title: 'Controle de Produtos',
    desc: 'Estoque sempre atualizado com alertas de reposição e controle de giro.',
    iconBg: 'bg-purple-50',
    iconColor: 'text-purple-600',
    icon: icons.box,
    features: ['Cadastro de produtos e categorias', 'Alerta de estoque mínimo', 'Controle de fornecedores'],
  },
  {
    title: 'Gestão de Vendas',
    desc: 'Registre vendas, acompanhe faturamento e visualize o desempenho em tempo real.',
    iconBg: 'bg-green-50',
    iconColor: 'text-green-600',
    icon: icons.money,
    features: ['Registro rápido de vendas', 'Relatório de faturamento', 'Múltiplas formas de pagamento'],
  },
  {
    title: 'Gestão de Funcionários',
    desc: 'Controle de equipe com perfis, cargos e permissões de acesso por usuário.',
    iconBg: 'bg-amber-50',
    iconColor: 'text-amber-600',
    icon: icons.team,
    features: ['Perfis e permissões por cargo', 'Histórico de ações no sistema', 'Controle de acesso seguro'],
  },
  {
    title: 'Contas a Pagar',
    desc: 'Organize suas despesas, evite atrasos e tenha visão clara do fluxo de caixa.',
    iconBg: 'bg-red-50',
    iconColor: 'text-red-500',
    icon: icons.wallet,
    features: ['Calendário de vencimentos', 'Categorias de despesa', 'Relatório de fluxo de caixa'],
  },
  {
    title: 'Gestão de Atividades',
    desc: 'Distribua tarefas para a equipe, acompanhe o progresso e elimine gargalos.',
    iconBg: 'bg-teal-50',
    iconColor: 'text-teal-600',
    icon: icons.clipboard,
    features: ['Tarefas por funcionário', 'Prioridade e prazo', 'Acompanhamento em tempo real'],
  },
]

const mobileFeatures = [
  {
    title: 'Sem instalação',
    desc: 'Acesse pelo navegador do celular ou computador - sem baixar nada.',
    iconBg: 'bg-green-100', iconColor: 'text-green-600',
    icon: `<svg fill="none" stroke="currentColor" stroke-width="1.75" viewBox="0 0 24 24" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M10.5 1.5H8.25A2.25 2.25 0 006 3.75v16.5a2.25 2.25 0 002.25 2.25h7.5A2.25 2.25 0 0018 20.25V3.75a2.25 2.25 0 00-2.25-2.25H13.5m-3 0V3h3V1.5m-3 0h3m-3 18.75h3"/></svg>`,
  },
  {
    title: 'Dados em tempo real',
    desc: 'Vendas, estoque e financeiro atualizados na hora, de onde você estiver.',
    iconBg: 'bg-blue-100', iconColor: 'text-blue-600',
    icon: `<svg fill="none" stroke="currentColor" stroke-width="1.75" viewBox="0 0 24 24" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M3 13.125C3 12.504 3.504 12 4.125 12h2.25c.621 0 1.125.504 1.125 1.125v6.75C7.5 20.496 6.996 21 6.375 21h-2.25A1.125 1.125 0 013 19.875v-6.75zM9.75 8.625c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125v11.25c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V8.625zM16.5 4.125c0-.621.504-1.125 1.125-1.125h2.25C20.496 3 21 3.504 21 4.125v15.75c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V4.125z"/></svg>`,
  },
  {
    title: 'Funciona em qualquer tela',
    desc: 'Layout adaptado para celular, tablet e desktop sem perder nenhuma funcionalidade.',
    iconBg: 'bg-orange-100', iconColor: 'text-orange-600',
    icon: `<svg fill="none" stroke="currentColor" stroke-width="1.75" viewBox="0 0 24 24" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M9 17.25v1.007a3 3 0 01-.879 2.122L7.5 21h9l-.621-.621A3 3 0 0115 18.257V17.25m6-12V15a2.25 2.25 0 01-2.25 2.25H5.25A2.25 2.25 0 013 15V5.25A2.25 2.25 0 015.25 3h13.5A2.25 2.25 0 0121 5.25z"/></svg>`,
  },
]

const etapas = [
  {
    title: 'Diagnóstico',
    desc: 'Entendemos o seu momento e alinhamos o que precisa ser configurado.',
    bg: 'bg-green-600', iconColor: 'text-white', numColor: 'text-green-600 border-green-200',
    icon: icons.chat,
  },
  {
    title: 'Proposta',
    desc: 'Apresentamos o plano ideal para o seu tamanho e necessidade.',
    bg: 'bg-orange-500', iconColor: 'text-white', numColor: 'text-orange-500 border-orange-200',
    icon: icons.doc,
  },
  {
    title: 'Implantação',
    desc: 'Configuramos o sistema com seus dados e treinamos sua equipe.',
    bg: 'bg-blue-600', iconColor: 'text-white', numColor: 'text-blue-600 border-blue-200',
    icon: icons.monitor,
  },
  {
    title: 'Suporte',
    desc: 'Acompanhamos os primeiros passos e seguimos disponíveis para ajudar.',
    bg: 'bg-purple-600', iconColor: 'text-white', numColor: 'text-purple-600 border-purple-200',
    icon: icons.loop,
  },
]

const planos = [
  {
    label: 'Para começar',
    name: 'Básico',
    desc: 'Ideal para quem está começando e quer controle simples e rápido.',
    price: '197',
    featured: false,
    cta: 'Quero o Básico',
    includes: [
      { text: 'Controle de estoque', active: true },
      { text: 'Cadastro de produtos', active: true },
      { text: 'Cadastro de clientes', active: true },
      { text: 'Registro de vendas', active: true },
      { text: 'Relatórios de vendas e lucro', active: false },
      { text: 'Controle financeiro', active: false },
      { text: 'Multiusuários', active: false },
    ],
  },
  {
    label: 'Mais vendido',
    name: 'Profissional',
    desc: 'Para lojas que querem crescer e ter controle total da operação.',
    price: '397',
    featured: true,
    cta: 'Quero o Profissional',
    includes: [
      { text: 'Tudo do plano Básico', active: true },
      { text: 'Relatórios de vendas e lucro', active: true },
      { text: 'Controle financeiro (entradas e saídas)', active: true },
      { text: 'Alertas de estoque baixo', active: true },
      { text: 'Histórico de clientes', active: true },
      { text: 'Multiusuários', active: false },
    ],
  },
  {
    label: 'Escala e automação',
    name: 'Avançado',
    desc: 'Para quem quer gestão completa, escala e automação do negócio.',
    price: '497',
    featured: false,
    cta: 'Quero o Avançado',
    includes: [
      { text: 'Tudo do plano Profissional', active: true },
      { text: 'Multiusuários', active: true },
      { text: 'Dashboard completo', active: true },
      { text: 'Suporte prioritário', active: true },
      { text: 'Relatórios de vendas e lucro', active: true },
      { text: 'Controle financeiro', active: true },
    ],
  },
]

const diferenciais = [
  {
    title: 'Feito para o mercado pet',
    desc: 'Desenvolvido para as necessidades reais de casas de ração e mercados pet.',
    iconBg: 'bg-green-50', iconColor: 'text-green-600', icon: icons.heart,
  },
  {
    title: 'Implantação sem complicação',
    desc: 'Nossa equipe configura tudo, treina sua equipe e acompanha os primeiros 30 dias.',
    iconBg: 'bg-blue-50', iconColor: 'text-blue-600', icon: icons.monitor,
  },
  {
    title: 'Suporte humanizado',
    desc: 'Fale com pessoas reais via WhatsApp, sem chatbots ou filas de espera.',
    iconBg: 'bg-orange-50', iconColor: 'text-orange-500', icon: icons.support,
  },
  {
    title: 'Dados 100% seguros',
    desc: 'Hospedagem em nuvem com backup automático e acesso protegido por senha.',
    iconBg: 'bg-green-50', iconColor: 'text-green-600', icon: icons.shield,
  },
  {
    title: 'Atualizações incluídas',
    desc: 'Novos recursos e melhorias constantes sem nenhum custo adicional.',
    iconBg: 'bg-purple-50', iconColor: 'text-purple-600', icon: icons.refresh,
  },
  {
    title: 'Acesso pelo celular',
    desc: 'Use no smartphone, tablet ou computador - de qualquer lugar com internet.',
    iconBg: 'bg-amber-50', iconColor: 'text-amber-600', icon: icons.phone,
  },
]

const faqs = [
  {
    q: 'Preciso ter conhecimento técnico para usar?',
    a: 'Não. O sistema foi criado para ser simples e intuitivo. Nossa equipe faz a implantação e treina você e sua equipe do zero.',
  },
  {
    q: 'Funciona no celular?',
    a: 'Sim. O sistema funciona perfeitamente no smartphone, tablet e computador. Acesse de qualquer lugar com internet.',
  },
  {
    q: 'Posso cancelar quando quiser?',
    a: 'Sim. Não há fidelidade nos planos mensais. Para contratos anuais, há condições descritas no contrato.',
  },
  {
    q: 'O que acontece com meus dados se eu cancelar?',
    a: 'Você pode exportar todos os dados antes de cancelar. Eles ficam retidos por 90 dias e depois são excluídos.',
  },
  {
    q: 'Quanto tempo leva para começar a usar?',
    a: 'Em média de 5 a 10 dias úteis após a contratação, dependendo do volume de dados a configurar.',
  },
  {
    q: 'O sistema tem limite de produtos ou clientes?',
    a: 'Não. Você pode cadastrar quantos produtos, clientes e vendas quiser, independente do plano.',
  },
]

const planoOpts = ['Básico', 'Profissional', 'Avançado', 'Ainda não sei']

function toggleFaq(q: string) {
  openFaq.value = openFaq.value === q ? null : q
}

function toggleInteresse(opt: string) {
  const idx = form.interesses.indexOf(opt)
  if (idx >= 0) form.interesses.splice(idx, 1)
  else form.interesses.push(opt)
}

async function enviarFormulario() {
  enviando.value = true
  await new Promise(r => setTimeout(r, 1500))
  enviando.value = false
  enviado.value = true
  form.nome = ''
  form.loja = ''
  form.whatsapp = ''
  form.email = ''
  form.interesses = []
  form.mensagem = ''
}
</script>
