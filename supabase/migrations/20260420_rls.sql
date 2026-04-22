-- ============================================================
-- RLS (Row Level Security) — rode no SQL Editor do Supabase
-- Rode APÓS o 20260420_schema_completo.sql
-- ============================================================

-- Habilita RLS em todas as tabelas
ALTER TABLE public.empresas               ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles               ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.clientes               ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.funcionarios           ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.veiculos               ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.vendas                 ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.vendas_itens           ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.produtos_casa_racao    ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.contas_pagar           ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.atividades_funcionarios ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.propostas              ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.servicos               ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.agendamentos           ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.agendamento_servicos   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.empresa_personalizacao ENABLE ROW LEVEL SECURITY;

-- ── empresas ──────────────────────────────────────────────────
DROP POLICY IF EXISTS "empresas_select" ON public.empresas;
CREATE POLICY "empresas_select" ON public.empresas FOR SELECT TO authenticated
  USING (id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));

-- ── profiles ──────────────────────────────────────────────────
DROP POLICY IF EXISTS "profiles_select_own"  ON public.profiles;
DROP POLICY IF EXISTS "profiles_insert_own"  ON public.profiles;
DROP POLICY IF EXISTS "profiles_update_own"  ON public.profiles;
CREATE POLICY "profiles_select_own" ON public.profiles FOR SELECT TO authenticated USING (id = auth.uid());
CREATE POLICY "profiles_insert_own" ON public.profiles FOR INSERT TO authenticated WITH CHECK (id = auth.uid());
CREATE POLICY "profiles_update_own" ON public.profiles FOR UPDATE TO authenticated USING (id = auth.uid());

-- ── clientes ─────────────────────────────────────────────────
DROP POLICY IF EXISTS "clientes_select" ON public.clientes;
DROP POLICY IF EXISTS "clientes_insert" ON public.clientes;
DROP POLICY IF EXISTS "clientes_update" ON public.clientes;
DROP POLICY IF EXISTS "clientes_delete" ON public.clientes;
CREATE POLICY "clientes_select" ON public.clientes FOR SELECT TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "clientes_insert" ON public.clientes FOR INSERT TO authenticated WITH CHECK (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "clientes_update" ON public.clientes FOR UPDATE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "clientes_delete" ON public.clientes FOR DELETE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));

-- ── funcionarios ─────────────────────────────────────────────
DROP POLICY IF EXISTS "funcionarios_select" ON public.funcionarios;
DROP POLICY IF EXISTS "funcionarios_insert" ON public.funcionarios;
DROP POLICY IF EXISTS "funcionarios_update" ON public.funcionarios;
DROP POLICY IF EXISTS "funcionarios_delete" ON public.funcionarios;
CREATE POLICY "funcionarios_select" ON public.funcionarios FOR SELECT TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "funcionarios_insert" ON public.funcionarios FOR INSERT TO authenticated WITH CHECK (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "funcionarios_update" ON public.funcionarios FOR UPDATE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "funcionarios_delete" ON public.funcionarios FOR DELETE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));

-- ── veiculos ─────────────────────────────────────────────────
DROP POLICY IF EXISTS "veiculos_select"      ON public.veiculos;
DROP POLICY IF EXISTS "veiculos_insert"      ON public.veiculos;
DROP POLICY IF EXISTS "veiculos_update"      ON public.veiculos;
DROP POLICY IF EXISTS "veiculos_delete"      ON public.veiculos;
DROP POLICY IF EXISTS "veiculos_public_read" ON public.veiculos;
CREATE POLICY "veiculos_select"      ON public.veiculos FOR SELECT TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "veiculos_insert"      ON public.veiculos FOR INSERT TO authenticated WITH CHECK (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "veiculos_update"      ON public.veiculos FOR UPDATE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "veiculos_delete"      ON public.veiculos FOR DELETE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "veiculos_public_read" ON public.veiculos FOR SELECT TO anon USING (status IN ('disponivel', 'reservado'));

-- ── vendas ───────────────────────────────────────────────────
DROP POLICY IF EXISTS "vendas_select" ON public.vendas;
DROP POLICY IF EXISTS "vendas_insert" ON public.vendas;
DROP POLICY IF EXISTS "vendas_update" ON public.vendas;
DROP POLICY IF EXISTS "vendas_delete" ON public.vendas;
CREATE POLICY "vendas_select" ON public.vendas FOR SELECT TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "vendas_insert" ON public.vendas FOR INSERT TO authenticated WITH CHECK (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "vendas_update" ON public.vendas FOR UPDATE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "vendas_delete" ON public.vendas FOR DELETE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));

-- ── vendas_itens ─────────────────────────────────────────────
DROP POLICY IF EXISTS "vendas_itens_select" ON public.vendas_itens;
DROP POLICY IF EXISTS "vendas_itens_insert" ON public.vendas_itens;
DROP POLICY IF EXISTS "vendas_itens_delete" ON public.vendas_itens;
CREATE POLICY "vendas_itens_select" ON public.vendas_itens FOR SELECT TO authenticated USING (venda_id IN (SELECT id FROM public.vendas WHERE empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid())));
CREATE POLICY "vendas_itens_insert" ON public.vendas_itens FOR INSERT TO authenticated WITH CHECK (venda_id IN (SELECT id FROM public.vendas WHERE empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid())));
CREATE POLICY "vendas_itens_delete" ON public.vendas_itens FOR DELETE TO authenticated USING (venda_id IN (SELECT id FROM public.vendas WHERE empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid())));

-- ── produtos_casa_racao ──────────────────────────────────────
DROP POLICY IF EXISTS "produtos_select" ON public.produtos_casa_racao;
DROP POLICY IF EXISTS "produtos_insert" ON public.produtos_casa_racao;
DROP POLICY IF EXISTS "produtos_update" ON public.produtos_casa_racao;
DROP POLICY IF EXISTS "produtos_delete" ON public.produtos_casa_racao;
CREATE POLICY "produtos_select" ON public.produtos_casa_racao FOR SELECT TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "produtos_insert" ON public.produtos_casa_racao FOR INSERT TO authenticated WITH CHECK (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "produtos_update" ON public.produtos_casa_racao FOR UPDATE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "produtos_delete" ON public.produtos_casa_racao FOR DELETE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));

-- ── contas_pagar ─────────────────────────────────────────────
DROP POLICY IF EXISTS "contas_pagar_select" ON public.contas_pagar;
DROP POLICY IF EXISTS "contas_pagar_insert" ON public.contas_pagar;
DROP POLICY IF EXISTS "contas_pagar_update" ON public.contas_pagar;
DROP POLICY IF EXISTS "contas_pagar_delete" ON public.contas_pagar;
CREATE POLICY "contas_pagar_select" ON public.contas_pagar FOR SELECT TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "contas_pagar_insert" ON public.contas_pagar FOR INSERT TO authenticated WITH CHECK (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "contas_pagar_update" ON public.contas_pagar FOR UPDATE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "contas_pagar_delete" ON public.contas_pagar FOR DELETE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));

-- ── atividades_funcionarios ──────────────────────────────────
DROP POLICY IF EXISTS "atividades_select" ON public.atividades_funcionarios;
DROP POLICY IF EXISTS "atividades_insert" ON public.atividades_funcionarios;
DROP POLICY IF EXISTS "atividades_update" ON public.atividades_funcionarios;
DROP POLICY IF EXISTS "atividades_delete" ON public.atividades_funcionarios;
CREATE POLICY "atividades_select" ON public.atividades_funcionarios FOR SELECT TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "atividades_insert" ON public.atividades_funcionarios FOR INSERT TO authenticated WITH CHECK (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "atividades_update" ON public.atividades_funcionarios FOR UPDATE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "atividades_delete" ON public.atividades_funcionarios FOR DELETE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));

-- ── propostas ────────────────────────────────────────────────
DROP POLICY IF EXISTS "propostas_select" ON public.propostas;
DROP POLICY IF EXISTS "propostas_insert" ON public.propostas;
DROP POLICY IF EXISTS "propostas_update" ON public.propostas;
DROP POLICY IF EXISTS "propostas_delete" ON public.propostas;
CREATE POLICY "propostas_select" ON public.propostas FOR SELECT TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "propostas_insert" ON public.propostas FOR INSERT TO authenticated WITH CHECK (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "propostas_update" ON public.propostas FOR UPDATE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "propostas_delete" ON public.propostas FOR DELETE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));

-- ── servicos ─────────────────────────────────────────────────
DROP POLICY IF EXISTS "servicos_select" ON public.servicos;
DROP POLICY IF EXISTS "servicos_insert" ON public.servicos;
DROP POLICY IF EXISTS "servicos_update" ON public.servicos;
DROP POLICY IF EXISTS "servicos_delete" ON public.servicos;
CREATE POLICY "servicos_select" ON public.servicos FOR SELECT TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "servicos_insert" ON public.servicos FOR INSERT TO authenticated WITH CHECK (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "servicos_update" ON public.servicos FOR UPDATE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "servicos_delete" ON public.servicos FOR DELETE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));

-- ── agendamentos ─────────────────────────────────────────────
DROP POLICY IF EXISTS "agendamentos_select" ON public.agendamentos;
DROP POLICY IF EXISTS "agendamentos_insert" ON public.agendamentos;
DROP POLICY IF EXISTS "agendamentos_update" ON public.agendamentos;
DROP POLICY IF EXISTS "agendamentos_delete" ON public.agendamentos;
CREATE POLICY "agendamentos_select" ON public.agendamentos FOR SELECT TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "agendamentos_insert" ON public.agendamentos FOR INSERT TO authenticated WITH CHECK (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "agendamentos_update" ON public.agendamentos FOR UPDATE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "agendamentos_delete" ON public.agendamentos FOR DELETE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));

-- ── agendamento_servicos ─────────────────────────────────────
DROP POLICY IF EXISTS "ag_servicos_select" ON public.agendamento_servicos;
DROP POLICY IF EXISTS "ag_servicos_insert" ON public.agendamento_servicos;
DROP POLICY IF EXISTS "ag_servicos_update" ON public.agendamento_servicos;
DROP POLICY IF EXISTS "ag_servicos_delete" ON public.agendamento_servicos;
CREATE POLICY "ag_servicos_select" ON public.agendamento_servicos FOR SELECT TO authenticated USING (agendamento_id IN (SELECT id FROM public.agendamentos WHERE empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid())));
CREATE POLICY "ag_servicos_insert" ON public.agendamento_servicos FOR INSERT TO authenticated WITH CHECK (agendamento_id IN (SELECT id FROM public.agendamentos WHERE empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid())));
CREATE POLICY "ag_servicos_update" ON public.agendamento_servicos FOR UPDATE TO authenticated USING (agendamento_id IN (SELECT id FROM public.agendamentos WHERE empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid())));
CREATE POLICY "ag_servicos_delete" ON public.agendamento_servicos FOR DELETE TO authenticated USING (agendamento_id IN (SELECT id FROM public.agendamentos WHERE empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid())));

-- ── empresa_personalizacao ───────────────────────────────────
DROP POLICY IF EXISTS "personalizacao_select"      ON public.empresa_personalizacao;
DROP POLICY IF EXISTS "personalizacao_insert"      ON public.empresa_personalizacao;
DROP POLICY IF EXISTS "personalizacao_update"      ON public.empresa_personalizacao;
DROP POLICY IF EXISTS "personalizacao_public_read" ON public.empresa_personalizacao;
CREATE POLICY "personalizacao_select"      ON public.empresa_personalizacao FOR SELECT TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "personalizacao_insert"      ON public.empresa_personalizacao FOR INSERT TO authenticated WITH CHECK (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "personalizacao_update"      ON public.empresa_personalizacao FOR UPDATE TO authenticated USING (empresa_id IN (SELECT empresa_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "personalizacao_public_read" ON public.empresa_personalizacao FOR SELECT TO anon USING (true);
