create table if not exists public.categorias(
    id uuid primary key default gen_random_uuid(),
    usuario_id uuid references auth.users (id) on delete cascade,
    nome text not null check (char_length(trim(nome))>0),
    tipo text not null check (tipo in ('receita','despesa')),
    carga_inicial boolean not null default false,
    criado_em timestamptz not null default now()
);
create table if not exists public.lancamentos(
    id uuid primary key default gen_random_uuid(),
    usuario_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
    categoria_id uuid references public.categorias(id) on delete set null,
    tipo text not null check (tipo in ('receita','despesa')),
    descricao text not null,
    valor numeric(14,2) not null check (valor>0),
    data_lancamento date not null default current_date,
    criado_em timestamptz not null default now()
);
insert into public.categorias (usuario_id, nome, tipo, carga_inicial) values
(null,'Salário','receita','true'),
(null,'Investimentos','receita','true'),
(null,'Alimentação','despesa','true'),
(null,'Transporte','despesa','true');
-- habilita a segurança por linha - RLS Row level security
alter table public.categorias enable row level security;
alter table public.lancamentos enable row level security;
-- cria as políticas de acesso
create policy "categorias_visiveis_para_usuario"
on public.categorias for select to authenticated
using (carga_inicial = true or usuario_id = (select auth.uid()));

create policy "usuario_cria_categoria_propria"
on public.categorias for insert to authenticated
with check(usuario_id = (select auth.uid()) and carga_inicial=false);

-- lembrar que falta policy para editar e excluir!

create policy "usuario_le_proprios_lancamentos"
on public.lancamentos for select to authenticated
using (usuario_id = (select auth.uid()));

create policy "usuario_cria_proprio_lancamento"
on public.lancamentos for insert to authenticated
with check (usuario_id = (select auth.uid()));
--direitos de acesso do BD
grant select, insert, update, delete on public.categorias, public.lancamentos to authenticated;