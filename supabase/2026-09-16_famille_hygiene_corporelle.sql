-- Le Cellier — nouvelle famille « Hygiène corporelle » (16/09/2026)
-- Déplace les produits rangés en Ménager > Hygiène vers Hygiène corporelle > Autre.
-- Tu pourras ensuite choisir le type précis (Douche & bain, Cheveux…) depuis la fiche de chaque produit.
-- À exécuter dans Supabase > SQL Editor.

-- 1. Vérifier les produits concernés (lecture seule)
select id, name, category, subcategory
from public.products
where category = 'Ménager' and subcategory = 'Hygiène';

-- 2. Les déplacer
update public.products
set category = 'Hygiène corporelle', subcategory = 'Autre'
where category = 'Ménager' and subcategory = 'Hygiène';
