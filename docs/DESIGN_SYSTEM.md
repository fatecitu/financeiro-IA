# Design System - Finanças Pessoais

**Versão:** 1.0
**Tecnologias**: HTML, CSS, Javascript Vanilla, Tailwind CSS, SweetAlert2 e Supabase.

## 1. Objetivo

Padronizar a aparência e experiência do aplicativo de gestão de despesas pessoais,
garantindo consistência nos modos claro (light) e escuro (dark).

## 2. Cores
### 2.1 Identidade Visual
| Papel | Cor | Hexadecimal | Utilização |
|---|---|---|---|
| Primária | Roxo Nubank | #820AD1 | Botões principais, links e elementos ativos |
| Secundária | Verde Turquesa | #0D9488 | Destaques e ações complementares |

### 2.2 Cores Neutras
| Elemento | Light Mode | Dark Mode |
|---|---|---|
| Fundo da página | #F8FAFC | #0F172A |
| Fundo de Cartões | #FFFFFF | #1E293B |
| Texto Principal | #0F172A | #F8FAFC |
| Texto Secundário | #64748B | #94A3B8 |
| Bordas | #E2E8F0 | #334155 |

### 2.3 Cores Semânticas
| Significado | Light Mode | Dark Mode | Exemplo |
|---|---|---|---|
| Sucesso | #16A34A | #4ADE80 | Receita recebida |
| Erro / despesa | #DC2626 | #F87171 | Despesa ou falha |
| Atenção | #D97706 | #FBBF24 | Alerta, Conta próxima ao vencimento |
| Informação | #0284C7 | #388DF8 | Mensagem informativa |

**Regra:** Nunca utilizar somente a cor para transmitir um significado; acrescentar texto ou ícone. Verificar contraste adequado entre texto e fundo.

## 3. Fontes e Tipografia

- **Títulos:** Poppins, com alternativa sans-serif.
- **Textos e Formulários:** Inter, com alternativa sans-serif.
- **Titulo Principal (H1):** 32px, peso 700.
- **Título de Seção (H2):** 24px, peso 600.
- **Título de Cartão (H3):** 20 px, peso 600.
- **Texto Padrão:** 16px, peso 400, altura de linha 1.5
- **Texto Auxiliar:** 14px, peso 400.
- **Valores Financeiros:** 24px, peso 600, alinhamento decimal consistente.

## 4. Espaçamento - 8pt Grid
Usar uma escala em múltiplos de 8px. O valor de 4px pode ser usado para ajustes pequenos.

| Token | Valor | Exemplo |
|---|---|---|
| XS | 4 px | Espaço entre ícone e texto |
| SM | 8 px | Elementos relacionados |
| MD | 16 px | Espaço interno de campos |
| LG | 24 px | Espaço interno de cartões |
| XL | 32 px | Separação entre seções |
| 2XL | 48 px | Separação entre grandes blocos |