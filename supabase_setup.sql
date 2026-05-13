-- =============================================================
-- Florida Keys Trip Planner — Supabase setup
-- Run this entire file in your Supabase SQL Editor.
-- Project → SQL Editor → New query → paste this → Run.
-- One-time setup. Takes 5 seconds. Free tier, no cost.
-- =============================================================

-- 1. Create the table that holds all trip data.
--    Everyone shares one row with id='main'. The full state lives in the data JSONB column.
create table if not exists public.trip_data (
  id          text primary key default 'main',
  data        jsonb not null default '{}'::jsonb,
  last_writer text,
  updated_at  timestamptz not null default now()
);

-- 2. Make sure the shared row exists so the app has something to read on first load.
insert into public.trip_data (id, data) values ('main', '{}'::jsonb)
on conflict (id) do nothing;

-- 3. Enable Row Level Security (required so policies below take effect).
alter table public.trip_data enable row level security;

-- 4. Allow anyone with the public anon key to read and write this single row.
--    This is fine for a small family trip planner: the URL acts as the "password"
--    (no one will find your page unless you share it).
--    DO NOT use this pattern for sensitive data — switch to authenticated policies instead.

drop policy if exists "trip_data_select_anon" on public.trip_data;
drop policy if exists "trip_data_insert_anon" on public.trip_data;
drop policy if exists "trip_data_update_anon" on public.trip_data;

create policy "trip_data_select_anon"
  on public.trip_data for select
  using (true);

create policy "trip_data_insert_anon"
  on public.trip_data for insert
  with check (id = 'main');

create policy "trip_data_update_anon"
  on public.trip_data for update
  using (id = 'main')
  with check (id = 'main');

-- 5. Enable realtime broadcasts for this table so all connected devices see updates live.
alter publication supabase_realtime add table public.trip_data;

-- That's it. Now go to Settings → API in your Supabase dashboard,
-- copy the "Project URL" and "anon public" key, paste them into the
-- setup modal that appears the first time you open index.html.
