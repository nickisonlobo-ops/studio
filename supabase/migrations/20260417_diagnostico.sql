-- ============================================================
-- DIAGNÓSTICO — rode no Supabase SQL Editor
-- ============================================================

-- 1. Confirma que as funções existem
SELECT proname, prosecdef AS security_definer
FROM pg_proc
WHERE proname IN ('setup_admin_account', 'create_employee_profile', 'handle_new_user')
ORDER BY proname;

-- 2. Confirma que o trigger existe
SELECT tgname, tgenabled
FROM pg_trigger
WHERE tgname = 'on_auth_user_created';

-- 3. Ver todos os profiles (últimos 20)
SELECT id, empresa_id, perfil, email, created_at
FROM public.profiles
ORDER BY created_at DESC
LIMIT 20;

-- 4. Corrige manualmente um usuário existente com empresa_id NULL
-- Substitua 'SEU_EMAIL@aqui.com' pelo email do usuário
DO $$
DECLARE
  v_user_id    uuid;
  v_empresa_id bigint;
  v_nome       text;
  v_email      text := 'SEU_EMAIL@aqui.com'; -- ← mude aqui
BEGIN
  SELECT id, raw_user_meta_data->>'full_name', email
    INTO v_user_id, v_nome, v_email
    FROM auth.users
   WHERE email = v_email
   LIMIT 1;

  IF v_user_id IS NULL THEN
    RAISE NOTICE 'Usuário não encontrado: %', v_email;
    RETURN;
  END IF;

  -- Cria empresa
  INSERT INTO public.empresas (nome)
  VALUES (COALESCE(v_nome, split_part(v_email, '@', 1)))
  RETURNING id INTO v_empresa_id;

  -- Vincula profile
  INSERT INTO public.profiles (id, empresa_id, perfil, email, nome)
  VALUES (v_user_id, v_empresa_id, 'admin', v_email, v_nome)
  ON CONFLICT (id) DO UPDATE SET
    empresa_id = v_empresa_id,
    perfil     = 'admin';

  RAISE NOTICE 'OK — empresa_id % vinculada ao usuário %', v_empresa_id, v_user_id;
END;
$$;
