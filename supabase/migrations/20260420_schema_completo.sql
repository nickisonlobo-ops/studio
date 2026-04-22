-- Schema completo executável
-- Ordem de criação respeita dependências de chave estrangeira

-- ─────────────────────────────────────────────
-- 1. empresas (sem dependências)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.empresas (
  id bigserial NOT NULL,
  nome text NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT empresas_pkey PRIMARY KEY (id)
);

-- ─────────────────────────────────────────────
-- 2. profiles (depende de auth.users e empresas)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.profiles (
  id uuid NOT NULL,
  empresa_id bigint,
  perfil text NOT NULL DEFAULT 'funcionario'::text,
  email text,
  nome text,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT profiles_pkey PRIMARY KEY (id),
  CONSTRAINT profiles_perfil_check CHECK (perfil = ANY (ARRAY['admin'::text, 'gerente'::text, 'funcionario'::text])),
  CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id),
  CONSTRAINT profiles_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresas(id)
);

-- ─────────────────────────────────────────────
-- 3. clientes (depende de empresas)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.clientes (
  id bigserial NOT NULL,
  empresa_id bigint NOT NULL,
  nome text NOT NULL,
  email text,
  telefone text,
  cpf text,
  endereco text,
  ativo boolean NOT NULL DEFAULT true,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT clientes_pkey PRIMARY KEY (id),
  CONSTRAINT clientes_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresas(id)
);

-- ─────────────────────────────────────────────
-- 4. funcionarios (depende de empresas)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.funcionarios (
  id bigserial NOT NULL,
  empresa_id bigint NOT NULL,
  nome text NOT NULL,
  cargo text,
  email text,
  telefone text,
  ativo boolean NOT NULL DEFAULT true,
  created_at timestamp with time zone DEFAULT now(),
  cpf integer,
  endereco text,
  idade integer,
  salario integer,
  CONSTRAINT funcionarios_pkey PRIMARY KEY (id),
  CONSTRAINT funcionarios_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresas(id)
);

-- ─────────────────────────────────────────────
-- 5. servicos (depende de empresas)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.servicos (
  id bigserial NOT NULL,
  empresa_id bigint NOT NULL,
  nome text NOT NULL,
  descricao text,
  categoria text NOT NULL DEFAULT 'outro'::text,
  duracao_min integer NOT NULL DEFAULT 60,
  preco numeric NOT NULL DEFAULT 0,
  ativo boolean NOT NULL DEFAULT true,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT servicos_pkey PRIMARY KEY (id),
  CONSTRAINT servicos_categoria_check CHECK (categoria = ANY (ARRAY['cilios'::text, 'unhas'::text, 'combo'::text, 'outro'::text])),
  CONSTRAINT servicos_duracao_min_check CHECK (duracao_min > 0),
  CONSTRAINT servicos_preco_check CHECK (preco >= 0::numeric),
  CONSTRAINT servicos_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresas(id)
);

-- ─────────────────────────────────────────────
-- 6. veiculos (depende de empresas)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.veiculos (
  id bigserial NOT NULL,
  empresa_id bigint NOT NULL,
  marca text,
  modelo text,
  ano_fabricacao integer,
  ano_modelo integer,
  tipo text,
  placa text,
  cor text,
  km integer,
  combustivel text,
  cambio text,
  chassi text,
  renavam text,
  cilindrada integer,
  tipo_moto text,
  preco_custo numeric,
  preco_venda numeric NOT NULL DEFAULT 0,
  status text NOT NULL DEFAULT 'disponivel'::text,
  fotos text[],
  observacao text,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT veiculos_pkey PRIMARY KEY (id),
  CONSTRAINT veiculos_status_check CHECK (status = ANY (ARRAY['disponivel'::text, 'reservado'::text, 'vendido'::text, 'inativo'::text])),
  CONSTRAINT veiculos_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresas(id)
);

-- ─────────────────────────────────────────────
-- 7. produtos_casa_racao (depende de empresas)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.produtos_casa_racao (
  id bigserial NOT NULL,
  empresa_id bigint NOT NULL,
  nome text NOT NULL,
  descricao text,
  preco numeric NOT NULL DEFAULT 0,
  estoque integer NOT NULL DEFAULT 0,
  ativo boolean NOT NULL DEFAULT true,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT produtos_casa_racao_pkey PRIMARY KEY (id),
  CONSTRAINT produtos_casa_racao_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresas(id)
);

-- ─────────────────────────────────────────────
-- 8. empresa_personalizacao (depende de empresas)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.empresa_personalizacao (
  id bigserial NOT NULL,
  empresa_id bigint NOT NULL,
  cor_primaria text NOT NULL DEFAULT '#6b7280'::text,
  cor_primaria_texto text NOT NULL DEFAULT '#ffffff'::text,
  cor_fundo text NOT NULL DEFAULT '#f9fafb'::text,
  cor_sidebar text NOT NULL DEFAULT '#ffffff'::text,
  cor_primaria_grad text,
  cor_fundo_grad text,
  cor_sidebar_grad text,
  cor_card text NOT NULL DEFAULT '#ffffff'::text,
  cor_card_texto text NOT NULL DEFAULT '#374151'::text,
  cor_card_grad text,
  grad_direction text NOT NULL DEFAULT '135deg'::text,
  logo_size text NOT NULL DEFAULT 'md'::text,
  nome_empresa text,
  logo_url text,
  updated_at timestamp with time zone DEFAULT now(),
  created_at timestamp with time zone DEFAULT now(),
  cor_botao text NOT NULL DEFAULT '#6b7280'::text,
  cor_botao_texto text NOT NULL DEFAULT '#ffffff'::text,
  cor_icone text NOT NULL DEFAULT '#6b7280'::text,
  CONSTRAINT empresa_personalizacao_pkey PRIMARY KEY (id),
  CONSTRAINT empresa_personalizacao_empresa_id_key UNIQUE (empresa_id),
  CONSTRAINT empresa_personalizacao_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresas(id)
);

-- ─────────────────────────────────────────────
-- 9. contas_pagar (depende de empresas)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.contas_pagar (
  id bigserial NOT NULL,
  empresa_id bigint NOT NULL,
  descricao text NOT NULL,
  valor numeric NOT NULL,
  data_vencimento date NOT NULL,
  data_pagamento date,
  status text NOT NULL DEFAULT 'pendente'::text,
  categoria text,
  observacoes text,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT contas_pagar_pkey PRIMARY KEY (id),
  CONSTRAINT contas_pagar_status_check CHECK (status = ANY (ARRAY['pendente'::text, 'pago'::text, 'vencido'::text, 'cancelado'::text])),
  CONSTRAINT contas_pagar_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresas(id)
);

-- ─────────────────────────────────────────────
-- 10. agendamentos (depende de empresas, clientes, profiles)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.agendamentos (
  id bigserial NOT NULL,
  empresa_id bigint NOT NULL,
  cliente_id bigint NOT NULL,
  funcionario_id uuid,
  data_hora timestamp with time zone NOT NULL,
  status text NOT NULL DEFAULT 'agendado'::text,
  observacoes text,
  valor_total numeric,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT agendamentos_pkey PRIMARY KEY (id),
  CONSTRAINT agendamentos_status_check CHECK (status = ANY (ARRAY['agendado'::text, 'confirmado'::text, 'concluido'::text, 'cancelado'::text, 'faltou'::text])),
  CONSTRAINT agendamentos_valor_total_check CHECK (valor_total >= 0::numeric),
  CONSTRAINT agendamentos_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresas(id),
  CONSTRAINT agendamentos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id),
  CONSTRAINT agendamentos_funcionario_id_fkey FOREIGN KEY (funcionario_id) REFERENCES public.profiles(id)
);

-- ─────────────────────────────────────────────
-- 11. agendamento_servicos (depende de agendamentos, servicos)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.agendamento_servicos (
  id bigserial NOT NULL,
  agendamento_id bigint NOT NULL,
  servico_id bigint NOT NULL,
  preco_cobrado numeric NOT NULL,
  CONSTRAINT agendamento_servicos_pkey PRIMARY KEY (id),
  CONSTRAINT agendamento_servicos_preco_cobrado_check CHECK (preco_cobrado >= 0::numeric),
  CONSTRAINT agendamento_servicos_agendamento_id_fkey FOREIGN KEY (agendamento_id) REFERENCES public.agendamentos(id),
  CONSTRAINT agendamento_servicos_servico_id_fkey FOREIGN KEY (servico_id) REFERENCES public.servicos(id)
);

-- ─────────────────────────────────────────────
-- 12. propostas (depende de empresas, clientes, veiculos)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.propostas (
  id bigserial NOT NULL,
  empresa_id bigint NOT NULL,
  cliente_id bigint,
  veiculo_id bigint,
  valor numeric,
  status text NOT NULL DEFAULT 'aberta'::text,
  observacoes text,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT propostas_pkey PRIMARY KEY (id),
  CONSTRAINT propostas_status_check CHECK (status = ANY (ARRAY['aberta'::text, 'aceita'::text, 'recusada'::text, 'expirada'::text])),
  CONSTRAINT propostas_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresas(id),
  CONSTRAINT propostas_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id),
  CONSTRAINT propostas_veiculo_id_fkey FOREIGN KEY (veiculo_id) REFERENCES public.veiculos(id)
);

-- ─────────────────────────────────────────────
-- 13. vendas (depende de empresas, clientes, veiculos)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.vendas (
  id bigserial NOT NULL,
  empresa_id bigint NOT NULL,
  cliente_id bigint,
  veiculo_id bigint,
  preco_veiculo numeric,
  data_venda date NOT NULL DEFAULT CURRENT_DATE,
  status text NOT NULL DEFAULT 'concluida'::text,
  observacoes text,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT vendas_pkey PRIMARY KEY (id),
  CONSTRAINT vendas_status_check CHECK (status = ANY (ARRAY['concluida'::text, 'cancelada'::text, 'pendente'::text])),
  CONSTRAINT vendas_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresas(id),
  CONSTRAINT vendas_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id),
  CONSTRAINT vendas_veiculo_id_fkey FOREIGN KEY (veiculo_id) REFERENCES public.veiculos(id)
);

-- ─────────────────────────────────────────────
-- 14. vendas_itens (depende de vendas)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.vendas_itens (
  id bigserial NOT NULL,
  venda_id bigint NOT NULL,
  produto_id bigint,
  descricao text,
  quantidade integer NOT NULL DEFAULT 1,
  preco_unitario numeric NOT NULL DEFAULT 0,
  valor_total numeric GENERATED ALWAYS AS (quantidade::numeric * preco_unitario) STORED,
  CONSTRAINT vendas_itens_pkey PRIMARY KEY (id),
  CONSTRAINT vendas_itens_venda_id_fkey FOREIGN KEY (venda_id) REFERENCES public.vendas(id)
);

-- ─────────────────────────────────────────────
-- 15. atividades_funcionarios (depende de empresas, funcionarios)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.atividades_funcionarios (
  id bigserial NOT NULL,
  empresa_id bigint NOT NULL,
  funcionario_id bigint,
  titulo text NOT NULL,
  descricao text,
  data_atividade date DEFAULT CURRENT_DATE,
  status text NOT NULL DEFAULT 'pendente'::text,
  created_at timestamp with time zone DEFAULT now(),
  periodicidade text,
  prioridade text NOT NULL DEFAULT 'media'::text,
  hora_inicio time without time zone,
  hora_fim time without time zone,
  observacao text,
  dias_semana text[],
  CONSTRAINT atividades_funcionarios_pkey PRIMARY KEY (id),
  CONSTRAINT atividades_funcionarios_status_check CHECK (status = ANY (ARRAY['pendente'::text, 'em_andamento'::text, 'concluida'::text, 'cancelada'::text])),
  CONSTRAINT atividades_funcionarios_periodicidade_check CHECK (periodicidade IS NULL OR (periodicidade = ANY (ARRAY['diaria'::text, 'quinzenal'::text, 'mensal'::text]))),
  CONSTRAINT atividades_funcionarios_prioridade_check CHECK (prioridade = ANY (ARRAY['baixa'::text, 'media'::text, 'alta'::text, 'urgente'::text])),
  CONSTRAINT atividades_funcionarios_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresas(id),
  CONSTRAINT atividades_funcionarios_funcionario_id_fkey FOREIGN KEY (funcionario_id) REFERENCES public.funcionarios(id)
);
