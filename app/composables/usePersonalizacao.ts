import { useState } from '#app'
import { ref } from 'vue'
import { createSupabaseClient } from '~/lib/supabase'
import { useEmpresa } from './useEmpresa'

export interface PersonalizacaoConfig {
  cor_primaria: string
  cor_primaria_texto: string
  cor_fundo: string
  cor_sidebar: string
  cor_card: string
  cor_card_texto: string
  nome_empresa: string
  logo_url: string | null
  logo_size: string
  // Gradiente opcional — segunda cor
  cor_primaria_grad: string | null
  cor_fundo_grad: string | null
  cor_sidebar_grad: string | null
  cor_card_grad: string | null
  // Direção do gradiente
  grad_direction: string
}

const DEFAULTS: PersonalizacaoConfig = {
  cor_primaria: '#6b7280',
  cor_primaria_texto: '#ffffff',
  cor_fundo: '#f9fafb',
  cor_sidebar: '#ffffff',
  cor_card: '#ffffff',
  cor_card_texto: '#374151',
  nome_empresa: 'UpStudio',
  logo_url: null,
  logo_size: 'md',
  cor_primaria_grad: null,
  cor_fundo_grad: null,
  cor_sidebar_grad: null,
  cor_card_grad: null,
  grad_direction: '135deg',
}

export function usePersonalizacao() {
  const supabase = createSupabaseClient()
  const { empresaId, loadEmpresa } = useEmpresa()

  const config = useState<PersonalizacaoConfig>('personalizacao_config', () => ({ ...DEFAULTS }))
  const loading = ref(false)
  const saving = ref(false)
  const uploadingLogo = ref(false)
  const error = ref<string | null>(null)

  async function loadPersonalizacao(apply = true) {
    await loadEmpresa()
    if (!empresaId.value) return

    const { data, error: err } = await supabase
      .from('empresa_personalizacao')
      .select('*')
      .eq('empresa_id', empresaId.value)
      .maybeSingle()

    if (err) {
      console.error('[usePersonalizacao] load error:', err.message)
      return
    }

    if (data) {
      config.value = {
        cor_primaria:        data.cor_primaria        ?? DEFAULTS.cor_primaria,
        cor_primaria_texto:  data.cor_primaria_texto  ?? DEFAULTS.cor_primaria_texto,
        cor_fundo:           data.cor_fundo           ?? DEFAULTS.cor_fundo,
        cor_sidebar:         data.cor_sidebar         ?? DEFAULTS.cor_sidebar,
        cor_card:            data.cor_card            ?? DEFAULTS.cor_card,
        cor_card_texto:      data.cor_card_texto      ?? DEFAULTS.cor_card_texto,
        nome_empresa:        data.nome_empresa        ?? DEFAULTS.nome_empresa,
        logo_url:            data.logo_url            ?? null,
        logo_size:           data.logo_size           ?? DEFAULTS.logo_size,
        cor_primaria_grad:   data.cor_primaria_grad   ?? null,
        cor_fundo_grad:      data.cor_fundo_grad      ?? null,
        cor_sidebar_grad:    data.cor_sidebar_grad    ?? null,
        cor_card_grad:       data.cor_card_grad       ?? null,
        grad_direction:      data.grad_direction      ?? DEFAULTS.grad_direction,
      }
    }

    if (apply) applyTheme(config.value)
  }

  async function savePersonalizacao(newConfig: PersonalizacaoConfig) {
    await loadEmpresa()
    if (!empresaId.value) {
      error.value = 'Empresa não identificada. Faça login novamente.'
      return false
    }

    saving.value = true
    error.value = null

    const payload = {
      empresa_id:          empresaId.value,
      cor_primaria:        newConfig.cor_primaria,
      cor_primaria_texto:  newConfig.cor_primaria_texto,
      cor_fundo:           newConfig.cor_fundo,
      cor_sidebar:         newConfig.cor_sidebar,
      cor_card:            newConfig.cor_card           ?? DEFAULTS.cor_card,
      cor_card_texto:      newConfig.cor_card_texto     ?? DEFAULTS.cor_card_texto,
      nome_empresa:        newConfig.nome_empresa,
      logo_url:            newConfig.logo_url,
      logo_size:           newConfig.logo_size          ?? DEFAULTS.logo_size,
      cor_primaria_grad:   newConfig.cor_primaria_grad   ?? null,
      cor_fundo_grad:      newConfig.cor_fundo_grad      ?? null,
      cor_sidebar_grad:    newConfig.cor_sidebar_grad    ?? null,
      cor_card_grad:       newConfig.cor_card_grad       ?? null,
      grad_direction:      newConfig.grad_direction      ?? DEFAULTS.grad_direction,
      updated_at:          new Date().toISOString(),
    }

    const { data, error: err } = await supabase
      .from('empresa_personalizacao')
      .upsert(payload, { onConflict: 'empresa_id' })
      .select()
      .single()

    saving.value = false

    if (err) {
      error.value = 'Erro ao salvar personalização: ' + err.message
      console.error('[usePersonalizacao] save error:', err)
      return false
    }

    if (!data) {
      error.value = 'Não foi possível salvar. Verifique suas permissões.'
      return false
    }

    config.value = { ...newConfig }
    applyTheme(config.value)
    return true
  }

  async function uploadLogo(file: File): Promise<string | null> {
    await loadEmpresa()
    if (!empresaId.value) return null

    uploadingLogo.value = true
    error.value = null

    // Valida tipo e tamanho
    const allowedTypes = ['image/png', 'image/jpeg', 'image/webp', 'image/svg+xml']
    if (!allowedTypes.includes(file.type)) {
      error.value = 'Formato inválido. Use PNG, JPG, WebP ou SVG.'
      uploadingLogo.value = false
      return null
    }
    if (file.size > 2 * 1024 * 1024) {
      error.value = 'Arquivo muito grande. Máximo 2MB.'
      uploadingLogo.value = false
      return null
    }

    const ext = file.name.split('.').pop()
    const path = `logos/${empresaId.value}/logo.${ext}`

    const { error: uploadErr } = await supabase.storage
      .from('empresa-assets')
      .upload(path, file, { upsert: true, contentType: file.type })

    uploadingLogo.value = false

    if (uploadErr) {
      error.value = 'Erro ao enviar logo: ' + uploadErr.message
      return null
    }

    const { data } = supabase.storage
      .from('empresa-assets')
      .getPublicUrl(path)

    return `${data.publicUrl}?t=${Date.now()}`
  }

  function applyTheme(cfg: PersonalizacaoConfig) {
    if (typeof document === 'undefined') return
    const root = document.documentElement

    const dir = cfg.grad_direction ?? '135deg'

    // ── Cor primária (com ou sem gradiente) ─────────────────────
    const primaryBg = cfg.cor_primaria_grad
      ? `linear-gradient(${dir}, ${cfg.cor_primaria}, ${cfg.cor_primaria_grad})`
      : cfg.cor_primaria

    // ── Fundo (com ou sem gradiente) ────────────────────────────
    const bgValue = cfg.cor_fundo_grad
      ? `linear-gradient(${dir}, ${cfg.cor_fundo}, ${cfg.cor_fundo_grad})`
      : cfg.cor_fundo

    // ── Sidebar (com ou sem gradiente) ──────────────────────────
    const sidebarBg = cfg.cor_sidebar_grad
      ? `linear-gradient(${dir}, ${cfg.cor_sidebar}, ${cfg.cor_sidebar_grad})`
      : cfg.cor_sidebar

    // ── Variáveis base ──────────────────────────────────────────
    root.style.setProperty('--color-primary',        cfg.cor_primaria)
    root.style.setProperty('--color-primary-text',   cfg.cor_primaria_texto)
    root.style.setProperty('--color-bg',             bgValue)
    root.style.setProperty('--color-sidebar',        sidebarBg)
    root.style.setProperty('--color-primary-bg',     primaryBg)
    root.style.setProperty('--grad-direction',       dir)

    // ── Variantes automáticas ───────────────────────────────────
    root.style.setProperty('--color-primary-5',      hexToRgba(cfg.cor_primaria, 0.05))
    root.style.setProperty('--color-primary-10',     hexToRgba(cfg.cor_primaria, 0.10))
    root.style.setProperty('--color-primary-12',     hexToRgba(cfg.cor_primaria, 0.12))
    root.style.setProperty('--color-primary-15',     hexToRgba(cfg.cor_primaria, 0.15))
    root.style.setProperty('--color-primary-20',     hexToRgba(cfg.cor_primaria, 0.20))
    root.style.setProperty('--color-primary-30',     hexToRgba(cfg.cor_primaria, 0.30))
    root.style.setProperty('--color-primary-light',  hexToRgba(cfg.cor_primaria, 0.12))
    root.style.setProperty('--color-primary-border', hexToRgba(cfg.cor_primaria, 0.30))

    // Shades claras/escuras derivadas via luminância
    root.style.setProperty('--color-primary-50',  lighten(cfg.cor_primaria, 0.90))
    root.style.setProperty('--color-primary-100', lighten(cfg.cor_primaria, 0.80))
    root.style.setProperty('--color-primary-200', lighten(cfg.cor_primaria, 0.60))
    root.style.setProperty('--color-primary-300', lighten(cfg.cor_primaria, 0.40))
    root.style.setProperty('--color-primary-400', lighten(cfg.cor_primaria, 0.20))
    root.style.setProperty('--color-primary-500', cfg.cor_primaria)
    root.style.setProperty('--color-primary-600', darken(cfg.cor_primaria, 0.10))
    root.style.setProperty('--color-primary-700', darken(cfg.cor_primaria, 0.20))
    root.style.setProperty('--color-primary-800', darken(cfg.cor_primaria, 0.35))
    root.style.setProperty('--color-primary-900', darken(cfg.cor_primaria, 0.50))

    // ── Injeta CSS global para sobrescrever classes Tailwind pink ──
    injectGlobalThemeCSS(cfg)
  }

  function injectGlobalThemeCSS(cfg: PersonalizacaoConfig) {
    const styleId = 'upstudio-theme-override'
    let el = document.getElementById(styleId) as HTMLStyleElement | null
    if (!el) {
      el = document.createElement('style')
      el.id = styleId
      document.head.appendChild(el)
    }

    const p   = cfg.cor_primaria
    const p2  = cfg.cor_primaria_grad
    const dir = cfg.grad_direction ?? '135deg'

    // Gradiente principal usado nos cabeçalhos das páginas
    const headerGrad = p2
      ? `linear-gradient(${dir}, ${darken(p, 0.10)}, ${p}, ${p2})`
      : `linear-gradient(${dir}, ${darken(p, 0.15)}, ${p}, ${lighten(p, 0.15)})`

    el.textContent = `
      /* ── Backgrounds ── */
      .bg-pink-50  { background-color: ${lighten(p, 0.90)} !important; }
      .bg-pink-100 { background-color: ${lighten(p, 0.80)} !important; }
      .bg-pink-200 { background-color: ${lighten(p, 0.60)} !important; }
      .bg-pink-300 { background-color: ${lighten(p, 0.40)} !important; }
      .bg-pink-400 { background-color: ${lighten(p, 0.20)} !important; }
      .bg-pink-500 { background-color: ${p} !important; }
      .bg-pink-600 { background-color: ${darken(p, 0.10)} !important; }
      .bg-pink-700 { background-color: ${darken(p, 0.20)} !important; }
      .bg-pink-800 { background-color: ${darken(p, 0.35)} !important; }
      .bg-pink-900 { background-color: ${darken(p, 0.50)} !important; }
      .bg-rose-400 { background-color: ${lighten(p, 0.15)} !important; }

      /* ── Textos ── */
      .text-pink-400 { color: ${lighten(p, 0.20)} !important; }
      .text-pink-500 { color: ${p} !important; }
      .text-pink-600 { color: ${darken(p, 0.10)} !important; }
      .text-pink-700 { color: ${darken(p, 0.20)} !important; }
      .text-pink-300 { color: ${lighten(p, 0.40)} !important; }
      .text-pink-100 { color: ${lighten(p, 0.80)} !important; }

      /* ── Bordas ── */
      .border-pink-100 { border-color: ${lighten(p, 0.80)} !important; }
      .border-pink-200 { border-color: ${lighten(p, 0.60)} !important; }
      .border-pink-300 { border-color: ${lighten(p, 0.40)} !important; }
      .border-pink-500 { border-color: ${p} !important; }

      /* ── Ring/focus ── */
      .focus\\:ring-pink-300:focus { --tw-ring-color: ${lighten(p, 0.40)} !important; }
      .focus\\:ring-pink-400:focus { --tw-ring-color: ${lighten(p, 0.20)} !important; }

      /* ── Gradientes (cabeçalhos das páginas) ── */
      .from-pink-600 { --tw-gradient-from: ${darken(p, 0.10)} !important; }
      .from-pink-500 { --tw-gradient-from: ${p} !important; }
      .from-pink-400 { --tw-gradient-from: ${lighten(p, 0.20)} !important; }
      .via-pink-500  { --tw-gradient-via: ${p} !important; }
      .to-pink-600   { --tw-gradient-to: ${darken(p, 0.10)} !important; }
      .to-pink-400   { --tw-gradient-to: ${lighten(p, 0.20)} !important; }
      .to-rose-400   { --tw-gradient-to: ${p2 ?? lighten(p, 0.15)} !important; }

      /* ── Gradiente composto nos headers das páginas ── */
      .bg-gradient-to-br.from-pink-600 {
        background-image: ${headerGrad} !important;
      }

      /* ── Hover states ── */
      .hover\\:bg-pink-50:hover  { background-color: ${lighten(p, 0.90)} !important; }
      .hover\\:bg-pink-100:hover { background-color: ${lighten(p, 0.80)} !important; }
      .hover\\:bg-pink-400:hover { background-color: ${lighten(p, 0.20)} !important; }
      .hover\\:bg-pink-600:hover { background-color: ${darken(p, 0.10)} !important; }
      .hover\\:text-pink-500:hover { color: ${p} !important; }
      .hover\\:text-pink-600:hover { color: ${darken(p, 0.10)} !important; }
      .hover\\:text-pink-700:hover { color: ${darken(p, 0.20)} !important; }
      .hover\\:border-pink-200:hover { border-color: ${lighten(p, 0.60)} !important; }
      .hover\\:border-pink-300:hover { border-color: ${lighten(p, 0.40)} !important; }
      .hover\\:border-pink-400:hover { border-color: ${lighten(p, 0.20)} !important; }

      /* ── Shadow pink ── */
      .shadow-pink-200\\/40 { --tw-shadow-color: ${hexToRgba(p, 0.4)} !important; box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), 0 4px 6px -1px ${hexToRgba(p, 0.4)} !important; }
      .shadow-pink-900\\/40 { --tw-shadow-color: ${hexToRgba(darken(p, 0.50), 0.4)} !important; }

      /* ── exact-active-class da nav bottom ── */
      .text-pink-600.bg-pink-100 { background-color: ${lighten(p, 0.80)} !important; color: ${darken(p, 0.10)} !important; }

      /* ── Classe hardcoded #ff46a2 gerada pelo Tailwind JIT ── */
      .text-\\[\\#ff46a2\\] { color: ${p} !important; }
      .hover\\:text-\\[\\#ff46a2\\]:hover { color: ${p} !important; }
      .bg-\\[\\#ff46a2\\] { background-color: ${p} !important; }
      .hover\\:bg-\\[\\#ff46a2\\]:hover { background-color: ${p} !important; }
      .border-\\[\\#ff46a2\\] { border-color: ${p} !important; }

      /* ── Spinner de loading ── */
      .border-t-transparent { border-top-color: transparent !important; }

      /* ── Cards (fundo + texto) ── */
      .bg-white.rounded-3xl,
      .bg-white.rounded-2xl {
        ${cfg.cor_card_grad
          ? `background: linear-gradient(${cfg.grad_direction ?? '135deg'}, ${cfg.cor_card}, ${cfg.cor_card_grad}) !important;`
          : `background-color: ${cfg.cor_card} !important;`}
      }
      .bg-white.rounded-3xl *,
      .bg-white.rounded-2xl * {
        --tw-card-text: ${cfg.cor_card_texto};
      }
      .bg-white.rounded-3xl .text-gray-800,
      .bg-white.rounded-2xl .text-gray-800 { color: ${cfg.cor_card_texto} !important; }
      .bg-white.rounded-3xl .text-gray-700,
      .bg-white.rounded-2xl .text-gray-700 { color: ${cfg.cor_card_texto} !important; }
      .bg-white.rounded-3xl .text-gray-600,
      .bg-white.rounded-2xl .text-gray-600 { color: ${hexToRgba(cfg.cor_card_texto, 0.8)} !important; }
      .bg-white.rounded-3xl .text-gray-500,
      .bg-white.rounded-2xl .text-gray-500 { color: ${hexToRgba(cfg.cor_card_texto, 0.65)} !important; }
      .bg-white.rounded-3xl .text-gray-400,
      .bg-white.rounded-2xl .text-gray-400 { color: ${hexToRgba(cfg.cor_card_texto, 0.5)} !important; }
      .bg-white.rounded-3xl .text-gray-300,
      .bg-white.rounded-2xl .text-gray-300 { color: ${hexToRgba(cfg.cor_card_texto, 0.35)} !important; }
      .bg-white.rounded-3xl .bg-gray-50,
      .bg-white.rounded-2xl .bg-gray-50 { background-color: ${hexToRgba(cfg.cor_card_texto, 0.04)} !important; }
      .bg-white.rounded-3xl .bg-gray-50\/50,
      .bg-white.rounded-2xl .bg-gray-50\/50 { background-color: ${hexToRgba(cfg.cor_card_texto, 0.02)} !important; }
      .bg-white.rounded-3xl .border-gray-100,
      .bg-white.rounded-2xl .border-gray-100 { border-color: ${hexToRgba(cfg.cor_card_texto, 0.08)} !important; }
      .bg-white.rounded-3xl .divide-gray-50 > * + *,
      .bg-white.rounded-2xl .divide-gray-50 > * + * { border-color: ${hexToRgba(cfg.cor_card_texto, 0.05)} !important; }
    `
  }

  function hexToRgba(hex: string, alpha: number): string {
    const r = parseInt(hex.slice(1, 3), 16)
    const g = parseInt(hex.slice(3, 5), 16)
    const b = parseInt(hex.slice(5, 7), 16)
    return `rgba(${r}, ${g}, ${b}, ${alpha})`
  }

  /** Mistura a cor com branco (amount 0–1: 1 = branco puro) */
  function lighten(hex: string, amount: number): string {
    const r = parseInt(hex.slice(1, 3), 16)
    const g = parseInt(hex.slice(3, 5), 16)
    const b = parseInt(hex.slice(5, 7), 16)
    const lr = Math.round(r + (255 - r) * amount)
    const lg = Math.round(g + (255 - g) * amount)
    const lb = Math.round(b + (255 - b) * amount)
    return `rgb(${lr}, ${lg}, ${lb})`
  }

  /** Mistura a cor com preto (amount 0–1: 1 = preto puro) */
  function darken(hex: string, amount: number): string {
    const r = parseInt(hex.slice(1, 3), 16)
    const g = parseInt(hex.slice(3, 5), 16)
    const b = parseInt(hex.slice(5, 7), 16)
    const dr = Math.round(r * (1 - amount))
    const dg = Math.round(g * (1 - amount))
    const db = Math.round(b * (1 - amount))
    return `rgb(${dr}, ${dg}, ${db})`
  }

  function resetToDefaults() {
    config.value = { ...DEFAULTS }
    applyTheme(config.value)
  }

  return {
    config,
    loading,
    saving,
    uploadingLogo,
    error,
    loadPersonalizacao,
    savePersonalizacao,
    uploadLogo,
    applyTheme,
    resetToDefaults,
    DEFAULTS,
  }
}
