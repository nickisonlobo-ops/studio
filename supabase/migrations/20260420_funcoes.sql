-- ============================================================
-- Funções e trigger — rode no SQL Editor do Supabase
-- ============================================================

-- ── setup_admin_account ───────────────────────────────────────
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

  -- Reutiliza empresa se já existir no profile
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
    IF v_perfil = 'admin' THEN v_perfil := 'funcionario'; END IF;
    INSERT INTO public.profiles (id, empresa_id, email, nome, perfil)
    VALUES (NEW.id, v_empresa_id, NEW.email, v_nome, v_perfil)
    ON CONFLICT (id) DO UPDATE SET
      empresa_id = EXCLUDED.empresa_id,
      perfil     = EXCLUDED.perfil,
      nome       = COALESCE(EXCLUDED.nome,  public.profiles.nome),
      email      = COALESCE(EXCLUDED.email, public.profiles.email);
  ELSE
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
