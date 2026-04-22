-- ─────────────────────────────────────────────────────────────────
-- Atualiza a função RPC: filtra horários ocupados por serviço
-- (não mais por profissional)
--
-- Motivação: o agendamento do Serviço 1 às 08h não deve bloquear
-- o horário do Serviço 2, mesmo que o mesmo profissional atenda ambos.
-- Cada serviço mostra apenas os seus próprios agendamentos como bloqueados.
-- ─────────────────────────────────────────────────────────────────

DROP FUNCTION IF EXISTS public.get_horarios_ocupados_funcionario(bigint, date, bigint);

CREATE OR REPLACE FUNCTION public.get_horarios_ocupados_funcionario(
  p_empresa_id  bigint,
  p_data        date,
  p_servico_id  bigint  -- NULL = retorna todos da empresa (fallback)
)
RETURNS TABLE(inicio timestamptz, fim timestamptz)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  -- Agendamentos confirmados que contêm o serviço específico
  SELECT
    a.data_hora                                                              AS inicio,
    a.data_hora + (COALESCE(SUM(s.duracao_min), 60) * INTERVAL '1 minute') AS fim
  FROM agendamentos a
  LEFT JOIN agendamento_servicos agsv ON agsv.agendamento_id = a.id
  LEFT JOIN servicos s                ON s.id = agsv.servico_id
  WHERE a.empresa_id = p_empresa_id
    AND (a.data_hora AT TIME ZONE 'America/Sao_Paulo')::date = p_data
    AND a.status NOT IN ('cancelado', 'faltou')
    AND (
      p_servico_id IS NULL
      OR EXISTS (
        SELECT 1
        FROM agendamento_servicos agsv2
        WHERE agsv2.agendamento_id = a.id
          AND agsv2.servico_id = p_servico_id
      )
    )
  GROUP BY a.id, a.data_hora

  UNION ALL

  -- Solicitações pendentes que incluem o serviço específico
  SELECT
    sa.data_hora                                           AS inicio,
    sa.data_hora + (sa.duracao_min * INTERVAL '1 minute') AS fim
  FROM solicitacoes_agendamento sa
  WHERE sa.empresa_id = p_empresa_id
    AND (sa.data_hora AT TIME ZONE 'America/Sao_Paulo')::date = p_data
    AND sa.status = 'pendente'
    AND (
      p_servico_id IS NULL
      OR p_servico_id = ANY(sa.servico_ids)
    )
$$;

GRANT EXECUTE ON FUNCTION public.get_horarios_ocupados_funcionario(bigint, date, bigint) TO anon;
GRANT EXECUTE ON FUNCTION public.get_horarios_ocupados_funcionario(bigint, date, bigint) TO authenticated;
