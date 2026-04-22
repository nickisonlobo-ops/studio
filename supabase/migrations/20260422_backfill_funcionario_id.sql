-- ─────────────────────────────────────────────────────────────────
-- Backfill: preenche agendamentos.funcionario_id (uuid) onde está NULL
-- usando o serviço vinculado → servico_funcionarios → funcionarios.email
--                                                   → profiles.id (uuid)
--
-- Execute uma única vez no SQL Editor do Supabase.
-- ─────────────────────────────────────────────────────────────────

UPDATE public.agendamentos a
SET funcionario_id = p.id
FROM
  public.agendamento_servicos        agsv
  JOIN public.servico_funcionarios   sf   ON sf.servico_id = agsv.servico_id
  JOIN public.funcionarios           f    ON f.id          = sf.funcionario_id
  JOIN public.profiles               p    ON lower(p.email) = lower(f.email)
WHERE agsv.agendamento_id = a.id
  AND a.funcionario_id IS NULL
  AND f.email IS NOT NULL
  AND p.email IS NOT NULL;
