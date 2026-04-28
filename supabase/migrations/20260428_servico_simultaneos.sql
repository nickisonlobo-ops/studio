-- ─────────────────────────────────────────────────────────────────
-- Serviços Simultâneos: permite linkar dois serviços que podem ser
-- realizados ao mesmo tempo (ex: cabelo + unhas no salão).
-- Armazena ambas as direções (A→B e B→A) para consulta simples.
-- ─────────────────────────────────────────────────────────────────

DROP TABLE IF EXISTS public.servico_simultaneos;

CREATE TABLE public.servico_simultaneos (
  id             bigserial   PRIMARY KEY,
  servico_id     bigint      NOT NULL REFERENCES public.servicos(id) ON DELETE CASCADE,
  servico_par_id bigint      NOT NULL REFERENCES public.servicos(id) ON DELETE CASCADE,
  created_at     timestamptz DEFAULT now(),
  CONSTRAINT servico_simultaneos_unique UNIQUE (servico_id, servico_par_id),
  CONSTRAINT servico_simultaneos_diff   CHECK  (servico_id <> servico_par_id)
);

ALTER TABLE public.servico_simultaneos ENABLE ROW LEVEL SECURITY;

-- ── SELECT ────────────────────────────────────────────────────
DROP POLICY IF EXISTS "ss_auth_select" ON public.servico_simultaneos;
CREATE POLICY "ss_auth_select" ON public.servico_simultaneos
  FOR SELECT TO authenticated
  USING (
    servico_id IN (
      SELECT id FROM public.servicos
      WHERE empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid())
    )
  );

-- ── INSERT ────────────────────────────────────────────────────
DROP POLICY IF EXISTS "ss_auth_insert" ON public.servico_simultaneos;
CREATE POLICY "ss_auth_insert" ON public.servico_simultaneos
  FOR INSERT TO authenticated
  WITH CHECK (
    servico_id IN (
      SELECT id FROM public.servicos
      WHERE empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid())
    )
  );

-- ── DELETE ────────────────────────────────────────────────────
DROP POLICY IF EXISTS "ss_auth_delete" ON public.servico_simultaneos;
CREATE POLICY "ss_auth_delete" ON public.servico_simultaneos
  FOR DELETE TO authenticated
  USING (
    servico_id IN (
      SELECT id FROM public.servicos
      WHERE empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid())
    )
  );

-- Leitura pública (necessário para página de agendamento público)
DROP POLICY IF EXISTS "ss_public_read" ON public.servico_simultaneos;
CREATE POLICY "ss_public_read" ON public.servico_simultaneos
  FOR SELECT TO anon USING (true);

