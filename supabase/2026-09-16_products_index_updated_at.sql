-- Le Cellier — évolutions proposées le 16/09/2026
-- À exécuter dans Supabase > SQL Editor. L'application fonctionne avec ou sans ce script.
-- Aucune donnée n'est modifiée, les RLS restent inchangées.

-- (1) Index sur user_id : les policies RLS filtrent chaque requête par user_id.
create index if not exists products_user_id_idx on public.products (user_id);

-- (2) updated_at fixé par le serveur à chaque modification (et non par l'horloge du téléphone).
create or replace function public.set_updated_at() returns trigger
language plpgsql
set search_path = ''
as $$ begin new.updated_at := now(); return new; end $$;

drop trigger if exists products_set_updated_at on public.products;
create trigger products_set_updated_at before update on public.products
for each row execute function public.set_updated_at();

-- ------------------------------------------------------------------
-- (3) PLUS TARD — seuil de stock faible par produit (non utilisé par l'app actuelle).
-- alter table public.products add column min_qty numeric null check (min_qty >= 0);

-- (4) FACULTATIF — limiter le bucket photos (les photos compressées font ~30 Ko).
-- update storage.buckets set file_size_limit = 2097152, allowed_mime_types = array['image/jpeg']
-- where id = 'photos';
