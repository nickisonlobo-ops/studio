-- Adiciona funcionario_id (bigint) em agendamento_servicos
-- Isso permite rastrear qual funcionário executou cada serviço
-- sem depender de UUIDs em agendamentos.funcionario_id

ALTER TABLE public.agendamento_servicos
  ADD COLUMN IF NOT EXISTS funcionario_id bigint REFERENCES public.funcionarios(id) ON DELETE SET NULL;
