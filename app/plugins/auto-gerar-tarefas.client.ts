import { gerarTarefasDiarias, chaveGeracaoHoje } from '~/composables/useGerarTarefas'
import { createSupabaseClient } from '~/lib/supabase'

/**
 * Plugin client-side: roda uma vez por dia (controle via localStorage).
 * Somente o admin dispara a geração automática de tarefas.
 * Qualquer usuário admin que abrir o app no dia ainda sem geração irá criar as instâncias.
 */
export default defineNuxtPlugin(async () => {
  // Só roda no cliente
  if (typeof window === 'undefined') return

  const chave = chaveGeracaoHoje()

  // Já gerou hoje? Sai sem fazer nada
  if (localStorage.getItem(chave)) return

  const supabase = createSupabaseClient()
  const { data: { session } } = await supabase.auth.getSession()

  if (!session) return

  // Somente admin dispara a geração automática
  if (session.user?.email !== 'admin@zoocultura.com') return

  const resultado = await gerarTarefasDiarias()

  // Marca como gerado hoje (mesmo se não havia modelos, evita chamadas repetidas)
  localStorage.setItem(chave, String(resultado.geradas))

  if (resultado.erro) {
    console.error('[PetFlow] Erro ao gerar tarefas diárias:', resultado.erro)
  } else if (resultado.geradas > 0) {
    console.info(`[PetFlow] ${resultado.geradas} tarefa(s) gerada(s) automaticamente para hoje.`)
  }
})
