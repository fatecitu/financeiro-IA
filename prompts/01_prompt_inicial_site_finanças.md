# Prompt inicial — site de finanças pessoais

Crie neste repositório um site funcional de gestão de finanças pessoais, usando como fontes de verdade:

- `docs/design_system.md` — identidade visual, tipografia, espaçamento, componentes e temas.
- `supabase/schema.sql` — tabelas, colunas, regras de acesso, categorias iniciais e políticas RLS.

Antes de implementar, leia esses dois arquivos e inspecione a estrutura existente do projeto. Preserve os arquivos e decisões já existentes que forem compatíveis. Faça a implementação nos diretórios atuais (`index.html`, `css/`, `js/` e outros arquivos necessários), sem introduzir frameworks de aplicação ou ferramentas de build.

## Tecnologias e limites

- HTML semântico, CSS e JavaScript Vanilla.
- Tailwind CSS para a estilização, usando uma forma compatível com este projeto estático e documentando qualquer configuração necessária.
- Supabase JavaScript Client para autenticação e acesso ao banco.
- SweetAlert2 para confirmações, avisos e mensagens de sucesso ou erro.
- Lucide Icons para ícones; use a integração oficial apropriada para uma página estática e não use emojis como ícones.
- Não use React, Vue, Angular, TypeScript, jQuery ou bibliotecas de gráficos pesadas.
- Mantenha o código organizado em módulos/arquivos pequenos, com responsabilidades claras.

## Funcionalidades

### Acesso e sessão

- Criar uma tela de login com email e senha, além de opção para criar conta e recuperar senha.
- Usar Supabase Auth. Manter a sessão com o cliente oficial e permitir sair da conta.
- Exibir erros de autenticação em português, de forma clara e acessível.
- Enquanto não houver sessão, mostrar apenas a área de acesso; após autenticar, abrir o dashboard.
- Não inventar autenticação local nem armazenar senhas manualmente.

### Lançamentos

- Consultar, cadastrar, editar e excluir lançamentos da tabela `public.lancamentos`.
- Campos: tipo (`receita` ou `despesa`), descrição, valor positivo, data do lançamento e categoria opcional.
- Filtrar a lista por período, tipo e categoria; ordenar pela data mais recente e oferecer estados vazios e de carregamento.
- Exibir valores em Real brasileiro (`BRL`) e datas em formato brasileiro, sem perder a precisão decimal dos valores persistidos.
- Validar os dados no formulário antes de enviar e confirmar exclusões com SweetAlert2.
- Atualizar os dados visíveis após criar, editar ou excluir um lançamento.

### Categorias

- Listar categorias visíveis ao usuário em `public.categorias`, separadas por tipo.
- Permitir cadastrar, editar e excluir apenas categorias próprias (`carga_inicial = false`). Categorias iniciais (`carga_inicial = true`) são compartilhadas e devem aparecer como somente leitura.
- Validar nome não vazio e tipo receita/despesa. Tratar nomes duplicados e erros de restrição com mensagens amigáveis.
- Ao cadastrar ou editar um lançamento, permitir somente categorias compatíveis com o seu tipo.
- Se uma categoria for excluída, respeitar o comportamento do schema: o lançamento relacionado pode ficar com `categoria_id` nula.

### Dashboard

- Criar uma visão inicial com saldo do período, total de receitas, total de despesas e quantidade de lançamentos.
- Permitir selecionar mês/período e calcular os indicadores e listagens usando os lançamentos do usuário retornados pelo Supabase.
- Mostrar lançamentos recentes e um resumo de despesas por categoria. O resumo deve ter alternativa textual acessível e se adaptar quando não houver dados.
- Explicitar o período selecionado e definir com clareza a fórmula do saldo (receitas menos despesas).

## Design e experiência

- Siga `docs/design_system.md`: paleta roxa e verde-turquesa, cores semânticas, Poppins para títulos, Inter para textos, grid de 8 px, raios, cartões e contraste definidos.
- Implementar modo claro e escuro aplicando/removendo `dark` no elemento `<html>`, guardar a preferência do usuário e aplicar o mesmo tema ao SweetAlert2.
- Criar layout responsivo para celular e desktop, com navegação clara entre Dashboard, Lançamentos e Categorias.
- Usar rótulos visíveis, foco de teclado, estados de foco/erro, mensagens compreensíveis e estrutura semântica. Não depender só de cor para transmitir estado.
- Usar Lucide Icons com rótulo acessível ou `aria-hidden="true"` quando decorativos.
- Evitar conteúdo de demonstração disfarçado de dado real. Se usar dados de exemplo durante o desenvolvimento, isolá-los e deixar claro como removê-los.

## Integração e segurança Supabase

- Use apenas a URL do projeto Supabase e a chave pública `anon`/publishable no frontend. Nunca exponha `service_role`, segredo ou credencial privilegiada.
- Não enfraqueça nem contorne as políticas RLS do schema. Faça consultas e mutações autenticadas; trate falhas de rede, sessão expirada e permissões negadas.
- Para inserir categorias próprias, preencha `usuario_id` com o usuário autenticado e `carga_inicial` como `false`. Para lançamentos, associe o `usuario_id` autenticado e respeite `categoria_id` compatível com o tipo.
- Leia `supabase/schema.sql` antes de escrever consultas e use os nomes reais das colunas: `usuario_id`, `categoria_id`, `tipo`, `descricao`, `valor`, `data_lancamento`, `criado_em`, `nome` e `carga_inicial`.
- Centralize a inicialização/configuração do Supabase. Use `SUPABASE_URL` e `SUPABASE_ANON_KEY` em um `.env` local, forneça um `.env.example` sem valores reais e garanta que `.env` esteja no `.gitignore`.
- Como o navegador não lê arquivos `.env`, não tente carregá-lo com `fetch` nem inclua esses valores diretamente no JavaScript versionado. Sem adicionar framework ou ferramenta de build, disponibilize a configuração pública em tempo de execução por um mecanismo simples (por exemplo, um pequeno servidor local que lê o `.env` e entrega um `config.js` gerado). Documente também como fornecer as mesmas variáveis no ambiente de hospedagem.
- A URL e a chave `anon`/publishable são públicas por definição e ficarão visíveis no navegador; o `.env` organiza a configuração, mas não torna essas variáveis secretas. Nunca exponha a chave `service_role` ou qualquer segredo no cliente.
- Para operações de atualização e exclusão, restrinja também pela chave do registro; deixe a autorização final para a RLS.

## Entrega

Implemente a aplicação completa, não apenas um mockup. Inclua instruções para copiar `.env.example` para `.env`, configurar `SUPABASE_URL` e `SUPABASE_ANON_KEY`, aplicar o schema no projeto Supabase e iniciar o servidor local necessário para servir a página e sua configuração pública. Ao concluir, resuma os arquivos criados/alterados, as funcionalidades entregues e qualquer configuração manual ainda necessária. Não altere o schema ou crie tabelas/políticas adicionais sem uma necessidade concreta identificada na implementação.