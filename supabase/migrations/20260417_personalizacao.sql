-- ============================================================
-- PERSONALIZAÇÃO POR EMPRESA (cores, logo, nome)
-- Execute no Supabase SQL Editor
-- ============================================================

-- Tabela de personalização
CREATE TABLE IF NOT EXISTS public.empresa_personalizacao (
  id                 bigserial    PRIMARY KEY,
  empresa_id         bigint       NOT NULL UNIQUE REFERENCES public.empresas(id) ON DELETE CASCADE,
  cor_primaria       text         NOT NULL DEFAULT '#ec4899',
  cor_primaria_texto text         NOT NULL DEFAULT '#ffffff',
  cor_fundo          text         NOT NULL DEFAULT '#fdf2f8',
  cor_sidebar        text         NOT NULL DEFAULT '#ffffff',
  -- Gradientes (segunda cor, null = sem degradê)
  cor_primaria_grad  text,
  cor_fundo_grad     text,
  cor_sidebar_grad   text,
  grad_direction     text         NOT NULL DEFAULT '135deg',
  nome_empresa       text,
  logo_url           text,
  updated_at         timestamptz  DEFAULT now(),
  created_at         timestamptz  DEFAULT now()
);

-- RLS
ALTER TABLE public.empresa_personalizacao ENABLE ROW LEVEL SECURITY;

-- Leitura: qualquer usuário autenticado da mesma empresa
CREATE POLICY "personalizacao_select" ON public.empresa_personalizacao
  FOR SELECT USING (
    empresa_id IN (
      SELECT empresa_id FROM public.profiles WHERE id = auth.uid()
    )
  );

-- Escrita (upsert): somente admin/gerente da empresa
CREATE POLICY "personalizacao_upsert" ON public.empresa_personalizacao
  FOR ALL USING (
    empresa_id IN (
      SELECT empresa_id FROM public.profiles
      WHERE id = auth.uid() AND perfil IN ('admin', 'gerente')
    )
  );

-- Storage bucket para logos (execute manualmente se necessário)
-- INSERT INTO storage.buckets (id, name, public) VALUES ('empresa-assets', 'empresa-assets', true)
-- ON CONFLICT (id) DO NOTHING;

-- Policy de storage: leitura pública
-- CREATE POLICY "logos_public_read" ON storage.objects
--   FOR SELECT USING (bucket_id = 'empresa-assets');

-- Policy de storage: upload somente autenticados
-- CREATE POLICY "logos_auth_upload" ON storage.objects
--   FOR INSERT WITH CHECK (bucket_id = 'empresa-assets' AND auth.role() = 'authenticated');

-- Policy de storage: atualização somente do dono
-- CREATE POLICY "logos_auth_update" ON storage.objects
--   FOR UPDATE USING (bucket_id = 'empresa-assets' AND auth.role() = 'authenticated');
