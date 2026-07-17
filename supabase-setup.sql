create table if not exists public.bookkeeping_states (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.bookkeeping_states enable row level security;

create policy "Users read their own books" on public.bookkeeping_states
for select using (auth.uid() = user_id);
create policy "Users create their own books" on public.bookkeeping_states
for insert with check (auth.uid() = user_id);
create policy "Users update their own books" on public.bookkeeping_states
for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Users delete their own books" on public.bookkeeping_states
for delete using (auth.uid() = user_id);

insert into storage.buckets (id, name, public)
values ('receipts', 'receipts', false)
on conflict (id) do nothing;

create policy "Users upload their own receipts" on storage.objects
for insert with check (bucket_id = 'receipts' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "Users read their own receipts" on storage.objects
for select using (bucket_id = 'receipts' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "Users update their own receipts" on storage.objects
for update using (bucket_id = 'receipts' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "Users delete their own receipts" on storage.objects
for delete using (bucket_id = 'receipts' and (storage.foldername(name))[1] = auth.uid()::text);
