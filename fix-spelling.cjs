const fs = require('fs');
let c = fs.readFileSync('app/pages/landing.vue', 'utf8');

const fixes = [
  ['Experimentar gratis', 'Experimentar grátis'],
  ['Criar minha conta gratis', 'Criar minha conta grátis'],
  ['Comece gratis', 'Comece grátis'],
  ['cta: \'Criar conta gratis\'', 'cta: \'Criar conta grátis\''],
  ['Comecar agora, de graca', 'Começar agora, de graça'],
  ['Comece hoje, de graca', 'Comece hoje, de graça'],
  ['por falta de organizacao.', 'por falta de organização.'],
  ['Seu estudio cheio, organizado', 'Seu estúdio cheio, organizado'],
  ['tudo em um so lugar.', 'tudo em um só lugar.'],
  ['+500 estudios ativos', '+500 estúdios ativos'],
  ['4.9 de satisfacao', '4.9 de satisfação'],
  ['Sem cartao de credito. Pronto', 'Sem cartão de crédito. Pronto'],
  ['Sem cartao de credito</span>', 'Sem cartão de crédito</span>'],
  ['negocio de beleza', 'negócio de beleza'],
  ['Nao importa a especialidade, se voce cuida de mulheres, essa plataforma e para voce.', 'Não importa a especialidade, se você cuida de mulheres, essa plataforma é para você.'],
  ['Proximos</p>', 'Próximos</p>'],
  ['Sem complicacao. Em 5 minutos sua conta esta criada e funcionando.', 'Sem complicação. Em 5 minutos sua conta está criada e funcionando.'],
  ['Investimento que cabe no seu orcamento', 'Investimento que cabe no seu orçamento'],
  ['section-label">Duvidas', 'section-label">Dúvidas'],
  ['Sua cliente merece uma experiencia incrivel', 'Sua cliente merece uma experiência incrível'],
  ['E voce merece um sistema que organiza tudo sem dor de cabeca. Comece hoje, de graca.', 'E você merece um sistema que organiza tudo sem dor de cabeça. Comece hoje, de graça.'],
  ["horarios na palma da mao, sem precisar ligar.", "horários na palma da mão, sem precisar ligar."],
  ["title: 'Confirmacao automatica'", "title: 'Confirmação automática'"],
  ["para clientes sem voce precisar fazer nada.", "para clientes sem você precisar fazer nada."],
  ["saidas e saldo", "saídas e saldo"],
  ["title: 'Notificacoes instantaneas'", "title: 'Notificações instantâneas'"],
  ["agendamento e feito, cancelado ou confirmado pela cliente.", "agendamento é feito, cancelado ou confirmado pela cliente."],
  ["title: 'Clientes sempre a mao'", "title: 'Clientes sempre à mão'"],
  ["Historico completo de cada cliente, servicos anteriores e preferencias registradas.", "Histórico completo de cada cliente, serviços anteriores e preferências registradas."],
  ["horarios da equipe. Evite conflitos e nunca perca um atendimento.", "horários da equipe. Evite conflitos e nunca perca um atendimento."],
  ["Historico completo de cada cliente: preferencias, ultimas visitas e contatos.", "Histórico completo de cada cliente: preferências, últimas visitas e contatos."],
  ["Cadastre produtos com preco e controle de estoque.", "Cadastre produtos com preço e controle de estoque."],
  ["salarios e acesso de cada profissional da equipe.", "salários e acesso de cada profissional da equipe."],
  ["title: 'Personalizacao'", "title: 'Personalização'"],
  ["nome do seu studio. A plataforma com a identidade do seu negocio.", "nome do seu estúdio. A plataforma com a identidade do seu negócio."],
  ["Crie orcamentos, registre vendas e acompanhe o status de cada negociacao.", "Crie orçamentos, registre vendas e acompanhe o status de cada negociação."],
  ["Cadastre seu studio em menos de 5 minutos. Sem burocracia e sem cartao de credito.", "Cadastre seu estúdio em menos de 5 minutos. Sem burocracia e sem cartão de crédito."],
  ["Adicione servicos, equipe e personalize as cores com o visual do seu negocio.", "Adicione serviços, equipe e personalize as cores com o visual do seu negócio."],
  ["sem conflito de horarios e o caixa do mes na palma da mao.", "sem conflito de horários e o caixa do mês na palma da mão."],
  ["desc: 'Para comecar e explorar'", "desc: 'Para começar e explorar'"],
  ["'Personalizacao de marca'", "'Personalização de marca'"],
  ["um servico?',      a: 'Sim! Cadastre lash, unhas, sobrancelha e outros servicos no mesmo sistema com precos individuais.'", "um serviço?',      a: 'Sim! Cadastre lash, unhas, sobrancelha e outros serviços no mesmo sistema com preços individuais.'"],
  ["A plataforma e totalmente responsiva no celular pelo navegador. Um app nativo esta a caminho!", "A plataforma é totalmente responsiva no celular pelo navegador. Um app nativo está a caminho!"],
  ["label: 'Estetica e Massagem'", "label: 'Estética e Massagem'"],
  ["Studio da Ana", "Estúdio da Ana"],
  ["Sao Paulo", "São Paulo"],
];

let count = 0;
for (const [from, to] of fixes) {
  if (c.includes(from)) {
    c = c.split(from).join(to);
    count++;
  } else {
    console.warn('NOT FOUND:', from.substring(0, 70));
  }
}

fs.writeFileSync('app/pages/landing.vue', c, 'utf8');
console.log('Done. Fixed:', count, 'of', fixes.length, 'items');
