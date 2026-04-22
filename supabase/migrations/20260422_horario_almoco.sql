-- ─────────────────────────────────────────────────────────────────
-- Horário de almoço/pausa na empresa
-- Execute no SQL Editor do Supabase
-- ─────────────────────────────────────────────────────────────────

ALTER TABLE public.empresa_personalizacao
  ADD COLUMN IF NOT EXISTS almoco_inicio text DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS almoco_fim    text DEFAULT NULL;
