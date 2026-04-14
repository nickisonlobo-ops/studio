import { createSupabaseClient } from '~/lib/supabase'

export interface ResultadoGeracao {
  geradas: number
  ignoradas: number
  erro: string | null
}

/**
 * Gera instâncias de atividades a partir dos modelos (registros sem data_atividade).
 *
 * Regras de periodicidade:
 *  - diaria    �?' gera toda vez que chamado (dia de hoje)
 *  - quinzenal �?' gera nos dias 1 e 16 do mês
 *  - mensal    �?' gera no dia 1 do mês
 *
 * Deduplicação: não cria se já existe registro com o mesmo
 * funcionario_id + titulo + data_atividade para hoje.
 */
export async function gerarTarefasDiarias(): Promise<ResultadoGeracao> {
  const supabase = createSupabaseClient()
  const hoje = new Date()
  const todayIso = hoje.toISOString().slice(0, 10)
  const diaDoMes = hoje.getDate()

  // Buscar todos os modelos (sem data_atividade)
  const { data: modelos, error: fetchErr } = await supabase
    .from('atividades_funcionarios')
    .select('id, funcionario_id, titulo, descricao, prioridade, periodicidade, hora_inicio, hora_fim, observacao')
    .is('data_atividade', null)

  if (fetchErr) return { geradas: 0, ignoradas: 0, erro: fetchErr.message }
  if (!modelos || modelos.length === 0) return { geradas: 0, ignoradas: 0, erro: null }

  // Verifica o que já existe hoje (evita duplicatas)
  const { data: existentes } = await supabase
    .from('atividades_funcionarios')
    .select('funcionario_id, titulo')
    .eq('data_atividade', todayIso)

  const jaExiste = new Set(
    (existentes ?? []).map(a => `${a.funcionario_id}::${a.titulo}`)
  )

  const inserir: object[] = []
  let ignoradas = 0

  for (const m of modelos) {
    // Verifica se deve gerar baseado na periodicidade
    let deveGerar = false
    if (m.periodicidade === 'diaria') {
      deveGerar = true
    } else if (m.periodicidade === 'quinzenal') {
      deveGerar = diaDoMes === 1 || diaDoMes === 16
    } else if (m.periodicidade === 'mensal') {
      deveGerar = diaDoMes === 1
    }

    if (!deveGerar) { ignoradas++; continue }

    // Verifica duplicata
    if (jaExiste.has(`${m.funcionario_id}::${m.titulo}`)) { ignoradas++; continue }

    inserir.push({
      funcionario_id:  m.funcionario_id,
      titulo:          m.titulo,
      descricao:       m.descricao,
      status:          'pendente',
      prioridade:      m.prioridade ?? 'media',
      periodicidade:   m.periodicidade ?? 'diaria',
      data_atividade:  todayIso,
      hora_inicio:     m.hora_inicio,
      hora_fim:        m.hora_fim,
      observacao:      m.observacao,
    })
  }

  if (inserir.length === 0) return { geradas: 0, ignoradas, erro: null }

  const { error: insertErr } = await supabase
    .from('atividades_funcionarios')
    .insert(inserir)

  if (insertErr) return { geradas: 0, ignoradas, erro: insertErr.message }

  return { geradas: inserir.length, ignoradas, erro: null }
}

/** Chave do localStorage para controle de geração diária */
export function chaveGeracaoHoje(): string {
  return `ztasks_gerado_${new Date().toISOString().slice(0, 10)}`
}
