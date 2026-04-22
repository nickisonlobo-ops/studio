-- Adiciona colunas extras à tabela contas_pagar
ALTER TABLE public.contas_pagar
  ADD COLUMN IF NOT EXISTS periodicidade text NULL DEFAULT 'avulsa',
  ADD COLUMN IF NOT EXISTS forma_pagamento text NULL,
  ADD COLUMN IF NOT EXISTS observacao text NULL;

-- Renomeia observacoes → observacao se a coluna antiga ainda existir
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public'
      AND table_name   = 'contas_pagar'
      AND column_name  = 'observacoes'
  ) THEN
    -- Copia dados da coluna antiga para a nova (caso já tenha dados)
    UPDATE public.contas_pagar SET observacao = observacoes WHERE observacao IS NULL AND observacoes IS NOT NULL;
    ALTER TABLE public.contas_pagar DROP COLUMN observacoes;
  END IF;
END $$;
