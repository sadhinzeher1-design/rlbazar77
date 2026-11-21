-- RL Bazar Supabase setup
-- 1) Create an admin user in Supabase Dashboard > Authentication > Users.
-- 2) Replace ADMIN_EMAIL below with that exact email and run this script.

create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  customer_name text not null,
  customer_phone text not null,
  customer_address text not null,
  items jsonb not null,
  subtotal numeric not null,
  delivery_charge numeric not null default 80,
  total numeric not null,
  status text not null default 'New'
);

create table if not exists public.admin_users (
  user_id uuid primary key references auth.users(id) on delete cascade,
  email text unique not null
);

alter table public.orders enable row level security;
alter table public.admin_users enable row level security;

-- Add the first admin (replace the email string below before running).
insert into public.admin_users (user_id, email)
select id, email from auth.users where lower(email) = lower('ADMIN_EMAIL')
on conflict (user_id) do update set email = excluded.email;

-- Admin can see only their own admin_users row.
drop policy if exists "Admins can read own admin record" on public.admin_users;
create policy "Admins can read own admin record" on public.admin_users
for select to authenticated using (user_id = auth.uid());

-- Anyone can submit an order, but public visitors cannot read or update orders.
drop policy if exists "Public can submit orders" on public.orders;
create policy "Public can submit orders" on public.orders
for insert to anon, authenticated
with check (customer_name <> '' and customer_phone <> '' and customer_address <> ''
  and subtotal >= 0 and delivery_charge >= 0 and total >= 0);
-- Only users listed in admin_users can view orders.
drop policy if exists "Admins can view orders" on public.orders;
create policy "Admins can view orders" on public.orders
for select to authenticated
using (exists (select 1 from public.admin_users a where a.user_id = auth.uid()));
-- Only admins can change order status.
drop policy if exists "Admins can update orders" on public.orders;
create policy "Admins can update orders" on public.orders
for update to authenticated
using (exists (select 1 from public.admin_users a where a.user_id = auth.uid())
with check (exists (select 1 from public.admin_users a where a.user_id = auth.uid()));
