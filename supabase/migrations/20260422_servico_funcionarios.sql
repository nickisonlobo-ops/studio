-- ─────────────────────────────────────────────────────────────────
-- Vínculo entre Serviços e Funcionários (N:N)
-- Execute no SQL Editor do Supabase
-- ─────────────────────────────────────────────────────────────────

DROP TABLE IF EXISTS public.servico_funcionarios;

CREATE TABLE public.servico_funcionarios (
  id             bigserial PRIMARY KEY,
  servico_id     bigint NOT NULL REFERENCES public.servicos(id)     ON DELETE CASCADE,
  funcionario_id bigint NOT NULL REFERENCES public.funcionarios(id) ON DELETE CASCADE,
  created_at     timestamptz DEFAULT now(),
  UNIQUE (servico_id, funcionario_id)
);

ALTER TABLE public.servico_funcionarios ENABLE ROW LEVEL SECURITY;

-- Autenticados da mesma empresa podem SELECT / INSERT / DELETE
DROP POLICY IF EXISTS "sf_auth_select" ON public.servico_funcionarios;
DROP POLICY IF EXISTS "sf_auth_insert" ON public.servico_funcionarios;
DROP POLICY IF EXISTS "sf_auth_delete" ON public.servico_funcionarios;

CREATE POLICY "sf_auth_select" ON public.servico_funcionarios
  FOR SELECT TO authenticated
  USING (
    servico_id IN (
      SELECT id FROM public.servicos
      WHERE empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid())
    )
  );

CREATE POLICY "sf_auth_insert" ON public.servico_funcionarios
  FOR INSERT TO authenticated
  WITH CHECK (
    servico_id IN (
      SELECT id FROM public.servicos
      WHERE empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid())
    )
  );

CREATE POLICY "sf_auth_delete" ON public.servico_funcionarios
  FOR DELETE TO authenticated
  USING (
    servico_id IN (
      SELECT id FROM public.servicos
      WHERE empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid())
    )
  );

-- Leitura pública (necessário para página de agendamento público)
DROP POLICY IF EXISTS "sf_public_read" ON public.servico_funcionarios;
CREATE POLICY "sf_public_read" ON public.servico_funcionarios
  FOR SELECT TO anon USING (true);

