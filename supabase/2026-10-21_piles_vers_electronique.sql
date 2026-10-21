-- Le Cellier — le type « Piles & bougies » (Ménager) est scindé (21/10/2026) :
--   piles  → famille « Appareils électroniques », type « Piles » ;
--   bougies → reste dans « Ménager », type « Bougies ».
-- Un produit dont le nom ne permet pas de trancher garde « Piles & bougies » :
-- l'app le conserve tel quel, à corriger à la main (Modifier).
-- À exécuter dans Supabase > SQL Editor.

-- 1. Aperçu (facultatif) : ce qui va bouger.
select name, category, subcategory
from public.products
where category = 'Ménager' and subcategory = 'Piles & bougies'
order by name;

-- 2. Piles, accus, batteries → Appareils électroniques > Piles.
update public.products
set category = 'Appareils électroniques', subcategory = 'Piles', updated_at = now()
where category = 'Ménager' and subcategory = 'Piles & bougies'
  and name ~* '(pile|accu|batter|lr ?0?[36]|aaa?\M)';

-- 3. Bougies → Ménager > Bougies.
update public.products
set subcategory = 'Bougies', updated_at = now()
where category = 'Ménager' and subcategory = 'Piles & bougies'
  and name ~* 'bougie';

-- 4. Reste à classer à la main (devrait être vide).
select name, category, subcategory
from public.products
where subcategory = 'Piles & bougies';
