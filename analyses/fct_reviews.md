# fct_reviews - Reviews Journalières Agrégées

Agrège le **nombre de reviews par jour et par listing** uniquement pour les listings vérifiés.

## Pourquoi ce modèle existe
Le CSV brut `reviews_snapshot` contient **plusieurs reviews pour le même jour/listing** (doublons naturels). 

Ce modèle **dédoublonne** via `COUNT(*)` → **1 ligne = 1 jour/listing** avec `number_reviews`.

## Ce qu'il filtre

reviews_snapshot (toutes reviews) 
-> WHERE listing_id IN (curation_listings)
-> DBT_VALID_TO IS NULL (version actuelle)
-> GROUP BY listing_id, review_date
-> fct_reviews propre

## Colonnes finales
| Nom            | Signification                |
|----------------|------------------------------|
| `listing_id`   | FK vers fct_listings         |
| `review_date`  | Date du jour                 |
| `number_reviews` | Nb reviews reçues ce jour  |