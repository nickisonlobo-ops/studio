-- Adiciona percentual de comissão ao serviço
ALTER TABLE public.servicos
  ADD COLUMN IF NOT EXISTS comissao_percentual numeric(5,2) DEFAULT NULL;

-- Tabela de comissões geradas ao concluir agendamentos
CREATE TABLE IF NOT EXISTS public.comissoes (
  id              bigserial PRIMARY KEY,
  empresa_id      bigint NOT NULL REFERENCES public.empresas(id)    ON DELETE CASCADE,
  agendamento_id  bigint NOT NULL REFERENCES public.agendamentos(id) ON DELETE CASCADE,
  funcionario_id  bigint          REFERENCES public.funcionarios(id) ON DELETE SET NULL,
  servico_id      bigint          REFERENCES public.servicos(id)     ON DELETE SET NULL,
  servico_nome    text,
  valor_servico   numeric(10,2) NOT NULL DEFAULT 0,
  percentual      numeric(5,2)  NOT NULL DEFAULT 0,
  valor_comissao  numeric(10,2) NOT NULL DEFAULT 0,
  data            date          NOT NULL,
  created_at      timestamptz   DEFAULT now(),

  CONSTRAINT comissoes_agendamento_servico_unique UNIQUE (agendamento_id, servico_id)
);

ALTER TABLE public.comissoes ENABLE ROW LEVEL SECURITY;

-- Somente usuários da mesma empresa enxergam/gravam
CREATE POLICY "comissoes_empresa_select"
  ON public.comissoes FOR SELECT
  USING (
    empresa_id IN (
      SELECT e.id FROM public.empresas e
      JOIN public.profiles p ON p.id = auth.uid()
      WHERE p.empresa_id = e.id
    )
  );

CREATE POLICY "comissoes_empresa_insert"
  ON public.comissoes FOR INSERT
  WITH CHECK (
    empresa_id IN (
      SELECT e.id FROM public.empresas e
      JOIN public.profiles p ON p.id = auth.uid()
      WHERE p.empresa_id = e.id
    )
  );

CREATE POLICY "comissoes_empresa_update"
  ON public.comissoes FOR UPDATE
  USING (
    empresa_id IN (
      SELECT e.id FROM public.empresas e
      JOIN public.profiles p ON p.id = auth.uid()
      WHERE p.empresa_id = e.id
    )
  );
