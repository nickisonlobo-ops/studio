-- ─────────────────────────────────────────────────────────────────
-- Simplificação: solicita\u00e7\u00f5es do link público vão direto para
-- a tabela agendamentos com status = 'solicitado'
-- Execute no SQL Editor do Supabase
-- ─────────────────────────────────────────────────────────────────

-- 1. Tornar cliente_id nullable (solicita\u00e7\u00f5es públicas não têm cliente cadastrado)
ALTER TABLE public.agendamentos ALTER COLUMN cliente_id DROP NOT NULL;

-- 2. Colunas para dados do solicitante (cliente sem cadastro)
ALTER TABLE public.agendamentos
  ADD COLUMN IF NOT EXISTS nome_solicitante     text,
  ADD COLUMN IF NOT EXISTS telefone_solicitante text;

-- 3. Atualizar constraint de status para incluir 'solicitado'
ALTER TABLE public.agendamentos DROP CONSTRAINT IF EXISTS agendamentos_status_check;
ALTER TABLE public.agendamentos
  ADD CONSTRAINT agendamentos_status_check
  CHECK (status IN ('solicitado','agendado','confirmado','concluido','cancelado','faltou'));

-- 4. RLS: anon pode inserir apenas agendamentos com status='solicitado'
DROP POLICY IF EXISTS "agendamentos_anon_insert" ON public.agendamentos;
CREATE POLICY "agendamentos_anon_insert" ON public.agendamentos
  FOR INSERT TO anon
  WITH CHECK (status = 'solicitado');

-- 5. RLS: anon pode inserir servi\u00e7os vinculados \u00e0 solicita\u00e7\u00e3o
DROP POLICY IF EXISTS "ag_servicos_anon_insert" ON public.agendamento_servicos;
CREATE POLICY "ag_servicos_anon_insert" ON public.agendamento_servicos
  FOR INSERT TO anon WITH CHECK (true);

-- 6. RLS: authenticated também pode inserir solicita\u00e7\u00f5es (usuário logado acessando link público)
-- Verifica se já existe uma política de INSERT para authenticated antes de adicionar
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE tablename = 'agendamentos'
      AND policyname = 'agendamentos_auth_solicitado'
  ) THEN
    EXECUTE $policy$
      CREATE POLICY "agendamentos_auth_solicitado" ON public.agendamentos
        FOR INSERT TO authenticated
        WITH CHECK (
          status = 'solicitado'
          OR empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid())
        )
    $policy$;
  END IF;
END
$$;
