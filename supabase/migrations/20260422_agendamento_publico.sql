-- ─────────────────────────────────────────────────────────────────
-- Agendamento público (link para clientes solicitarem horário)
-- Execute no SQL Editor do Supabase
-- ─────────────────────────────────────────────────────────────────

-- 1. Colunas de horário na tabela de personalização da empresa
ALTER TABLE public.empresa_personalizacao
  ADD COLUMN IF NOT EXISTS horario_abertura  text    NOT NULL DEFAULT '08:00',
  ADD COLUMN IF NOT EXISTS horario_fechamento text    NOT NULL DEFAULT '18:00',
  ADD COLUMN IF NOT EXISTS intervalo_min      integer NOT NULL DEFAULT 30;

-- 2. Dias de funcionamento por dia da semana  (0 = Dom … 6 = Sáb)
CREATE TABLE IF NOT EXISTS public.empresa_dias_funcionamento (
  id          bigserial PRIMARY KEY,
  empresa_id  bigint    NOT NULL REFERENCES public.empresas(id) ON DELETE CASCADE,
  dia_semana  integer   NOT NULL CHECK (dia_semana BETWEEN 0 AND 6),
  ativo       boolean   NOT NULL DEFAULT true,
  UNIQUE (empresa_id, dia_semana)
);

-- 3. Solicitações de agendamento enviadas pelas clientes (sem login)
CREATE TABLE IF NOT EXISTS public.solicitacoes_agendamento (
  id            bigserial   PRIMARY KEY,
  empresa_id    bigint      NOT NULL REFERENCES public.empresas(id) ON DELETE CASCADE,
  nome_cliente  text        NOT NULL,
  telefone      text        NOT NULL,
  email         text,
  servico_ids   bigint[]    NOT NULL DEFAULT '{}',
  data_hora     timestamptz NOT NULL,
  duracao_min   integer     NOT NULL DEFAULT 60,
  status        text        NOT NULL DEFAULT 'pendente'
                            CHECK (status IN ('pendente','confirmado','recusado','cancelado')),
  observacoes   text,
  created_at    timestamptz DEFAULT now()
);

-- ─────────────────────────────────────────────────────────────────
-- RLS
-- ─────────────────────────────────────────────────────────────────
ALTER TABLE public.empresa_dias_funcionamento  ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.solicitacoes_agendamento    ENABLE ROW LEVEL SECURITY;

-- Serviços: leitura pública para serviços ativos (necessário para a página de agendamento)
DROP POLICY IF EXISTS "servicos_public_read" ON public.servicos;
CREATE POLICY "servicos_public_read" ON public.servicos
  FOR SELECT TO anon USING (ativo = true);

-- Dias de funcionamento: leitura pública + CRUD para autenticados da empresa
DROP POLICY IF EXISTS "dias_func_public_read"  ON public.empresa_dias_funcionamento;
DROP POLICY IF EXISTS "dias_func_auth_select"  ON public.empresa_dias_funcionamento;
DROP POLICY IF EXISTS "dias_func_auth_insert"  ON public.empresa_dias_funcionamento;
DROP POLICY IF EXISTS "dias_func_auth_update"  ON public.empresa_dias_funcionamento;
DROP POLICY IF EXISTS "dias_func_auth_delete"  ON public.empresa_dias_funcionamento;
CREATE POLICY "dias_func_public_read" ON public.empresa_dias_funcionamento
  FOR SELECT TO anon USING (true);
CREATE POLICY "dias_func_auth_select" ON public.empresa_dias_funcionamento
  FOR SELECT TO authenticated
  USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "dias_func_auth_insert" ON public.empresa_dias_funcionamento
  FOR INSERT TO authenticated
  WITH CHECK (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "dias_func_auth_update" ON public.empresa_dias_funcionamento
  FOR UPDATE TO authenticated
  USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "dias_func_auth_delete" ON public.empresa_dias_funcionamento
  FOR DELETE TO authenticated
  USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));

-- Solicitações: qualquer pessoa (anon ou autenticado) pode inserir; autenticados da empresa gerenciam
DROP POLICY IF EXISTS "solicitacoes_anon_insert"   ON public.solicitacoes_agendamento;
DROP POLICY IF EXISTS "solicitacoes_auth_insert"   ON public.solicitacoes_agendamento;
DROP POLICY IF EXISTS "solicitacoes_auth_select"   ON public.solicitacoes_agendamento;
DROP POLICY IF EXISTS "solicitacoes_auth_update"   ON public.solicitacoes_agendamento;
DROP POLICY IF EXISTS "solicitacoes_auth_delete"   ON public.solicitacoes_agendamento;
-- Anon (cliente sem login) pode inserir
CREATE POLICY "solicitacoes_anon_insert" ON public.solicitacoes_agendamento
  FOR INSERT TO anon WITH CHECK (true);
-- Authenticated (usuário logado acessando o link público) também pode inserir
CREATE POLICY "solicitacoes_auth_insert" ON public.solicitacoes_agendamento
  FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "solicitacoes_auth_select" ON public.solicitacoes_agendamento
  FOR SELECT TO authenticated
  USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "solicitacoes_auth_update" ON public.solicitacoes_agendamento
  FOR UPDATE TO authenticated
  USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "solicitacoes_auth_delete" ON public.solicitacoes_agendamento
  FOR DELETE TO authenticated
  USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));

-- ─────────────────────────────────────────────────────────────────
-- Função RPC: horários ocupados (agendamentos + solicitações pendentes)
-- Chamada pelo frontend sem exigir login para calcular slots livres
-- ─────────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.get_horarios_ocupados_completo(
  p_empresa_id bigint,
  p_data       date
)
RETURNS TABLE(inicio timestamptz, fim timestamptz)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  -- Agendamentos confirmados/agendados — duração = soma dos serviços vinculados
  -- Usa AT TIME ZONE 'America/Sao_Paulo' para comparar corretamente datas locais
  SELECT
    a.data_hora                                                             AS inicio,
    a.data_hora + (COALESCE(SUM(s.duracao_min), 60) * INTERVAL '1 minute') AS fim
  FROM agendamentos a
  LEFT JOIN agendamento_servicos agsv ON agsv.agendamento_id = a.id
  LEFT JOIN servicos s                ON s.id = agsv.servico_id
  WHERE a.empresa_id = p_empresa_id
    AND (a.data_hora AT TIME ZONE 'America/Sao_Paulo')::date = p_data
    AND a.status NOT IN ('cancelado', 'faltou')
  GROUP BY a.id, a.data_hora

  UNION ALL

  -- Solicitações pendentes — bloqueiam o horário até serem confirmadas ou recusadas
  SELECT
    sa.data_hora                                                  AS inicio,
    sa.data_hora + (sa.duracao_min * INTERVAL '1 minute')         AS fim
  FROM solicitacoes_agendamento sa
  WHERE sa.empresa_id = p_empresa_id
    AND (sa.data_hora AT TIME ZONE 'America/Sao_Paulo')::date = p_data
    AND sa.status = 'pendente'
$$;

GRANT EXECUTE ON FUNCTION public.get_horarios_ocupados_completo(bigint, date) TO anon;
GRANT EXECUTE ON FUNCTION public.get_horarios_ocupados_completo(bigint, date) TO authenticated;
