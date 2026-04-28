-- Adiciona rastreamento de origem nas contas a pagar
ALTER TABLE public.contas_pagar
  ADD COLUMN IF NOT EXISTS origem      text   NOT NULL DEFAULT 'manual'
                                       CHECK (origem IN ('manual','comissao')),
  ADD COLUMN IF NOT EXISTS comissao_id bigint REFERENCES public.comissoes(id)
                                       ON DELETE SET NULL;

-- Índice único para evitar duplicata ao re-concluir o mesmo agendamento
CREATE UNIQUE INDEX IF NOT EXISTS contas_pagar_comissao_id_unique
  ON public.contas_pagar (comissao_id)
  WHERE comissao_id IS NOT NULL;

COMMENT ON COLUMN public.contas_pagar.origem IS 'manual = lançado manualmente | comissao = gerado ao concluir agendamento';
