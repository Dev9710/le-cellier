-- Le Cellier — date d'achat d'un produit (17/09/2026)
-- Deux colonnes facultatives : l'année, et le mois (possible seulement si l'année est connue).
-- Les produits existants restent sans date d'achat. Les RLS ne changent pas.
-- À exécuter dans Supabase > SQL Editor.

alter table public.products
  add column if not exists purchase_year  smallint null,
  add column if not exists purchase_month smallint null;

alter table public.products drop constraint if exists products_purchase_year_check;
alter table public.products add constraint products_purchase_year_check
  check (purchase_year is null or purchase_year between 1900 and 2100);

alter table public.products drop constraint if exists products_purchase_month_check;
alter table public.products add constraint products_purchase_month_check
  check (purchase_month is null or (purchase_month between 1 and 12 and purchase_year is not null));
