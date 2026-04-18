-- ============================================================
-- SETUP COMPLETO DO BANCO DE DADOS
-- Execute no Supabase SQL Editor (projeto limpo)
-- ============================================================


-- ══════════════════════════════════════════════════════════════
-- 1. TABELAS BASE
-- ══════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.empresas (
  id         bigserial    PRIMARY KEY,
  nome       text         NOT NULL,
  created_at timestamptz  DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.profiles (
  id         uuid         PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  empresa_id bigint       REFERENCES public.empresas(id),
  perfil     text         NOT NULL DEFAULT 'funcionario' CHECK (perfil IN ('admin','gerente','funcionario')),
  email      text,
  nome       text,
  created_at timestamptz  DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.clientes (
  id         bigserial    PRIMARY KEY,
  empresa_id bigint       NOT NULL REFERENCES public.empresas(id) ON DELETE CASCADE,
  nome       text         NOT NULL,
  email      text,
  telefone   text,
  cpf        text,
  endereco   text,
  ativo      boolean      NOT NULL DEFAULT true,
  created_at timestamptz  DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.funcionarios (
  id         bigserial    PRIMARY KEY,
  empresa_id bigint       NOT NULL REFERENCES public.empresas(id) ON DELETE CASCADE,
  nome       text         NOT NULL,
  cargo      text,
  email      text,
  telefone   text,
  ativo      boolean      NOT NULL DEFAULT true,
  created_at timestamptz  DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.veiculos (
  id                bigserial    PRIMARY KEY,
  empresa_id        bigint       NOT NULL REFERENCES public.empresas(id) ON DELETE CASCADE,
  marca             text,
  modelo            text,
  ano_fabricacao    int,
  ano_modelo        int,
  tipo              text,
  placa             text,
  cor               text,
  km                int,
  combustivel       text,
  cambio            text,
  chassi            text,
  renavam           text,
  cilindrada        int,
  tipo_moto         text,
  preco_custo       numeric(12,2),
  preco_venda       numeric(12,2) NOT NULL DEFAULT 0,
  status            text         NOT NULL DEFAULT 'disponivel'
                                 CHECK (status IN ('disponivel','reservado','vendido','inativo')),
  fotos             text[],
  observacao        text,
  created_at        timestamptz  DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.vendas (
  id           bigserial    PRIMARY KEY,
  empresa_id   bigint       NOT NULL REFERENCES public.empresas(id) ON DELETE CASCADE,
  cliente_id   bigint       REFERENCES public.clientes(id) ON DELETE SET NULL,
  veiculo_id   bigint       REFERENCES public.veiculos(id) ON DELETE SET NULL,
  preco_veiculo numeric(12,2),
  data_venda   date         NOT NULL DEFAULT CURRENT_DATE,
  status       text         NOT NULL DEFAULT 'concluida'
                            CHECK (status IN ('concluida','cancelada','pendente')),
  observacoes  text,
  created_at   timestamptz  DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.vendas_itens (
  id              bigserial    PRIMARY KEY,
  venda_id        bigint       NOT NULL REFERENCES public.vendas(id) ON DELETE CASCADE,
  produto_id      bigint,
  descricao       text,
  quantidade      int          NOT NULL DEFAULT 1,
  preco_unitario  numeric(12,2) NOT NULL DEFAULT 0,
  valor_total     numeric(12,2) GENERATED ALWAYS AS (quantidade * preco_unitario) STORED
);

CREATE TABLE IF NOT EXISTS public.produtos_casa_racao (
  id         bigserial    PRIMARY KEY,
  empresa_id bigint       NOT NULL REFERENCES public.empresas(id) ON DELETE CASCADE,
  nome       text         NOT NULL,
  descricao  text,
  preco      numeric(12,2) NOT NULL DEFAULT 0,
  estoque    int           NOT NULL DEFAULT 0,
  ativo      boolean       NOT NULL DEFAULT true,
  created_at timestamptz   DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.contas_pagar (
  id             bigserial    PRIMARY KEY,
  empresa_id     bigint       NOT NULL REFERENCES public.empresas(id) ON DELETE CASCADE,
  descricao      text         NOT NULL,
  valor          numeric(12,2) NOT NULL,
  data_vencimento date        NOT NULL,
  data_pagamento  date,
  status         text         NOT NULL DEFAULT 'pendente'
                              CHECK (status IN ('pendente','pago','vencido','cancelado')),
  categoria      text,
  observacoes    text,
  created_at     timestamptz  DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.atividades_funcionarios (
  id               bigserial    PRIMARY KEY,
  empresa_id       bigint       NOT NULL REFERENCES public.empresas(id) ON DELETE CASCADE,
  funcionario_id   bigint       REFERENCES public.funcionarios(id) ON DELETE SET NULL,
  titulo           text         NOT NULL,
  descricao        text,
  data_atividade   date         NOT NULL DEFAULT CURRENT_DATE,
  status           text         NOT NULL DEFAULT 'pendente'
                                CHECK (status IN ('pendente','em_andamento','concluida','cancelada')),
  created_at       timestamptz  DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.propostas (
  id           bigserial    PRIMARY KEY,
  empresa_id   bigint       NOT NULL REFERENCES public.empresas(id) ON DELETE CASCADE,
  cliente_id   bigint       REFERENCES public.clientes(id) ON DELETE SET NULL,
  veiculo_id   bigint       REFERENCES public.veiculos(id) ON DELETE SET NULL,
  valor        numeric(12,2),
  status       text         NOT NULL DEFAULT 'aberta'
                            CHECK (status IN ('aberta','aceita','recusada','expirada')),
  observacoes  text,
  created_at   timestamptz  DEFAULT now()
);

-- Studio
CREATE TABLE IF NOT EXISTS public.servicos (
  id          bigserial    PRIMARY KEY,
  empresa_id  bigint       NOT NULL REFERENCES public.empresas(id) ON DELETE CASCADE,
  nome        text         NOT NULL,
  descricao   text,
  categoria   text         NOT NULL DEFAULT 'outro'
                           CHECK (categoria IN ('cilios','unhas','combo','outro')),
  duracao_min int          NOT NULL DEFAULT 60 CHECK (duracao_min > 0),
  preco       numeric(10,2) NOT NULL DEFAULT 0 CHECK (preco >= 0),
  ativo       boolean      NOT NULL DEFAULT true,
  created_at  timestamptz  DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.agendamentos (
  id             bigserial    PRIMARY KEY,
  empresa_id     bigint       NOT NULL REFERENCES public.empresas(id)  ON DELETE CASCADE,
  cliente_id     bigint       NOT NULL REFERENCES public.clientes(id)  ON DELETE RESTRICT,
  funcionario_id uuid                  REFERENCES public.profiles(id)  ON DELETE SET NULL,
  data_hora      timestamptz  NOT NULL,
  status         text         NOT NULL DEFAULT 'agendado'
                              CHECK (status IN ('agendado','confirmado','concluido','cancelado','faltou')),
  observacoes    text,
  valor_total    numeric(10,2) CHECK (valor_total >= 0),
  created_at     timestamptz  DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.agendamento_servicos (
  id             bigserial    PRIMARY KEY,
  agendamento_id bigint       NOT NULL REFERENCES public.agendamentos(id) ON DELETE CASCADE,
  servico_id     bigint       NOT NULL REFERENCES public.servicos(id)     ON DELETE RESTRICT,
  preco_cobrado  numeric(10,2) NOT NULL CHECK (preco_cobrado >= 0),
  UNIQUE (agendamento_id, servico_id)
);


-- ══════════════════════════════════════════════════════════════
-- 2. ÍNDICES
-- ══════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_profiles_empresa_id           ON public.profiles (empresa_id);
CREATE INDEX IF NOT EXISTS idx_clientes_empresa_id           ON public.clientes (empresa_id);
CREATE INDEX IF NOT EXISTS idx_funcionarios_empresa_id       ON public.funcionarios (empresa_id);
CREATE INDEX IF NOT EXISTS idx_veiculos_empresa_id           ON public.veiculos (empresa_id);
CREATE INDEX IF NOT EXISTS idx_vendas_empresa_id             ON public.vendas (empresa_id);
CREATE INDEX IF NOT EXISTS idx_contas_pagar_empresa_id       ON public.contas_pagar (empresa_id);
CREATE INDEX IF NOT EXISTS idx_atividades_empresa_id         ON public.atividades_funcionarios (empresa_id);
CREATE INDEX IF NOT EXISTS idx_servicos_empresa_id           ON public.servicos (empresa_id);
CREATE INDEX IF NOT EXISTS idx_agendamentos_empresa_id       ON public.agendamentos (empresa_id);
CREATE INDEX IF NOT EXISTS idx_agendamentos_data_hora        ON public.agendamentos (data_hora);
CREATE INDEX IF NOT EXISTS idx_ag_servicos_agendamento       ON public.agendamento_servicos (agendamento_id);


-- ══════════════════════════════════════════════════════════════
-- 3. ROW LEVEL SECURITY
-- ══════════════════════════════════════════════════════════════

ALTER TABLE public.empresas              ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles              ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.clientes              ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.funcionarios          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.veiculos              ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.vendas                ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.vendas_itens          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.produtos_casa_racao   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.contas_pagar          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.atividades_funcionarios ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.propostas             ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.servicos              ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.agendamentos          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.agendamento_servicos  ENABLE ROW LEVEL SECURITY;

-- Helper macro: empresa_id do usuário autenticado
-- Usado internamente nas policies abaixo

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

-- ── macro reutilizável (subquery padrão) ─────────────────────
-- As policies abaixo usam o mesmo padrão: empresa_id do usuário

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
CREATE POLICY "veiculos_public_read" ON public.veiculos FOR SELECT TO anon USING (status IN ('disponivel','reservado'));

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


-- ══════════════════════════════════════════════════════════════
-- 4. FUNÇÕES E TRIGGERS
-- ══════════════════════════════════════════════════════════════

-- ── setup_admin_account ───────────────────────────────────────
-- Chamada pelo cliente no primeiro acesso do admin.
-- Cria a empresa e vincula ao profile como admin.
DROP FUNCTION IF EXISTS public.setup_admin_account(text);
CREATE OR REPLACE FUNCTION public.setup_admin_account(p_empresa_nome text)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_empresa_id bigint;
  v_user_id    uuid;
  v_email      text;
  v_nome       text;
BEGIN
  v_user_id := auth.uid();
  IF v_user_id IS NULL THEN RAISE EXCEPTION 'Usuário não autenticado.'; END IF;

  SELECT email, raw_user_meta_data->>'full_name'
    INTO v_email, v_nome
    FROM auth.users WHERE id = v_user_id;

  SELECT empresa_id INTO v_empresa_id
    FROM public.profiles WHERE id = v_user_id AND empresa_id IS NOT NULL LIMIT 1;

  IF v_empresa_id IS NULL THEN
    INSERT INTO public.empresas (nome)
    VALUES (COALESCE(NULLIF(trim(p_empresa_nome), ''), 'Minha Empresa'))
    RETURNING id INTO v_empresa_id;
  END IF;

  INSERT INTO public.profiles (id, empresa_id, perfil, email, nome)
  VALUES (v_user_id, v_empresa_id, 'admin', v_email, v_nome)
  ON CONFLICT (id) DO UPDATE SET
    empresa_id = v_empresa_id,
    perfil     = 'admin',
    email      = COALESCE(EXCLUDED.email, profiles.email),
    nome       = COALESCE(EXCLUDED.nome,  profiles.nome);

  RETURN json_build_object('empresa_id', v_empresa_id);
END;
$$;
GRANT EXECUTE ON FUNCTION public.setup_admin_account(text) TO authenticated;


-- ── create_employee_profile ───────────────────────────────────
-- Chamada pelo admin para criar/corrigir profile de funcionário.
DROP FUNCTION IF EXISTS public.create_employee_profile(uuid, bigint, text, text, text);
CREATE OR REPLACE FUNCTION public.create_employee_profile(
  p_user_id    uuid,
  p_empresa_id bigint,
  p_email      text,
  p_nome       text,
  p_perfil     text DEFAULT 'funcionario'
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF p_perfil NOT IN ('funcionario', 'gerente') THEN
    RAISE EXCEPTION 'Perfil inválido: %. Use funcionario ou gerente.', p_perfil;
  END IF;

  INSERT INTO public.profiles (id, empresa_id, email, nome, perfil)
  VALUES (p_user_id, p_empresa_id, p_email, p_nome, p_perfil)
  ON CONFLICT (id) DO UPDATE SET
    empresa_id = EXCLUDED.empresa_id,
    email      = COALESCE(EXCLUDED.email, public.profiles.email),
    nome       = COALESCE(EXCLUDED.nome,  public.profiles.nome),
    perfil     = EXCLUDED.perfil;
END;
$$;
REVOKE ALL ON FUNCTION public.create_employee_profile(uuid, bigint, text, text, text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.create_employee_profile(uuid, bigint, text, text, text) TO authenticated;


-- ── handle_new_user (trigger) ─────────────────────────────────
-- Cria profile ao cadastrar novo usuário.
-- Admin: profile sem empresa_id (setup_admin_account resolve no login)
-- Funcionário: profile com empresa_id vindo do metadata
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_empresa_id bigint;
  v_perfil     text;
  v_nome       text;
BEGIN
  v_nome   := COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1));
  v_perfil := COALESCE(NEW.raw_user_meta_data->>'perfil', 'funcionario');

  BEGIN
    v_empresa_id := (NEW.raw_user_meta_data->>'empresa_id')::bigint;
  EXCEPTION WHEN OTHERS THEN
    v_empresa_id := NULL;
  END;

  IF v_empresa_id IS NOT NULL THEN
    -- Funcionário criado pelo admin
    IF v_perfil = 'admin' THEN v_perfil := 'funcionario'; END IF;

    INSERT INTO public.profiles (id, empresa_id, email, nome, perfil)
    VALUES (NEW.id, v_empresa_id, NEW.email, v_nome, v_perfil)
    ON CONFLICT (id) DO UPDATE SET
      empresa_id = EXCLUDED.empresa_id,
      perfil     = EXCLUDED.perfil,
      nome       = COALESCE(EXCLUDED.nome,  public.profiles.nome),
      email      = COALESCE(EXCLUDED.email, public.profiles.email);
  ELSE
    -- Admin novo: profile sem empresa_id
    INSERT INTO public.profiles (id, email, nome, perfil)
    VALUES (NEW.id, NEW.email, v_nome, 'admin')
    ON CONFLICT (id) DO NOTHING;
  END IF;

  RETURN NEW;
EXCEPTION WHEN OTHERS THEN
  RAISE WARNING '[handle_new_user] erro para % (%): %', NEW.id, NEW.email, SQLERRM;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


-- ── fn_recalcular_valor_total (trigger agendamentos) ─────────
CREATE OR REPLACE FUNCTION public.fn_recalcular_valor_total()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_agendamento_id bigint;
  v_total          numeric(10,2);
BEGIN
  IF TG_OP = 'DELETE' THEN
    v_agendamento_id := OLD.agendamento_id;
  ELSE
    v_agendamento_id := NEW.agendamento_id;
  END IF;

  SELECT COALESCE(SUM(preco_cobrado), 0)
    INTO v_total
    FROM public.agendamento_servicos
   WHERE agendamento_id = v_agendamento_id;

  UPDATE public.agendamentos SET valor_total = v_total WHERE id = v_agendamento_id;
  RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS trg_recalcular_valor_total ON public.agendamento_servicos;
CREATE TRIGGER trg_recalcular_valor_total
  AFTER INSERT OR UPDATE OR DELETE ON public.agendamento_servicos
  FOR EACH ROW EXECUTE FUNCTION public.fn_recalcular_valor_total();
