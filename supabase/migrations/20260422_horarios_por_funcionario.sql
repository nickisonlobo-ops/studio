-- ─────────────────────────────────────────────────────────────────
-- Função RPC: horários ocupados filtrados por funcionário
-- Usada para checar disponibilidade individual de cada profissional
-- quando o cliente seleciona múltiplos serviços no agendamento público
-- ─────────────────────────────────────────────────────────────────

CREATE OR REPLACE FUNCTION public.get_horarios_ocupados_funcionario(
  p_empresa_id    bigint,
  p_data          date,
  p_funcionario_id bigint  -- NULL = retorna todos (mesmo comportamento que a função original)
)
RETURNS TABLE(inicio timestamptz, fim timestamptz)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  -- Agendamentos do funcionário na data
  -- agendamentos.funcionario_id é uuid (→ profiles), então filtramos pelos serviços
  -- vinculados ao funcionário via agendamento_servicos + servico_funcionarios
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
      p_funcionario_id IS NULL
      OR EXISTS (
        SELECT 1
        FROM agendamento_servicos agsv2
        JOIN servico_funcionarios sf ON sf.servico_id = agsv2.servico_id
        WHERE agsv2.agendamento_id = a.id
          AND sf.funcionario_id = p_funcionario_id
      )
    )
  GROUP BY a.id, a.data_hora

  UNION ALL

  -- Solicitações pendentes bloqueiam o horário (filtra por funcionário via servico_funcionarios)
  SELECT
    sa.data_hora                                          AS inicio,
    sa.data_hora + (sa.duracao_min * INTERVAL '1 minute') AS fim
  FROM solicitacoes_agendamento sa
  WHERE sa.empresa_id = p_empresa_id
    AND (sa.data_hora AT TIME ZONE 'America/Sao_Paulo')::date = p_data
    AND sa.status = 'pendente'
    AND (
      p_funcionario_id IS NULL
      OR EXISTS (
        SELECT 1
        FROM unnest(sa.servico_ids) AS sid
        JOIN servico_funcionarios sf ON sf.servico_id = sid
        WHERE sf.funcionario_id = p_funcionario_id
      )
    )
$$;

GRANT EXECUTE ON FUNCTION public.get_horarios_ocupados_funcionario(bigint, date, bigint) TO anon;
GRANT EXECUTE ON FUNCTION public.get_horarios_ocupados_funcionario(bigint, date, bigint) TO authenticated;
