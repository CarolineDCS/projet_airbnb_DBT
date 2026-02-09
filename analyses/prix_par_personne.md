# Macro : Prix par Personne

## Objectif
**Calcule le prix unitaire par personne** pour normalisation des tarifs Airbnb.

## Syntaxe
{{ prix_par_personne('l.price', 'l.accommodates') }}

## Logique
prix_par_personne = nom_colonne_prix / nom_colonne_nb_personne

Exemple : 150€ / 4 personnes = 37.5€/personne

| Paramètre | Description |
|-----------|-------------|
| nom_colonne_prix | Colonne prix (ex: l.price) |
| nom_colonne_nb_personne |Colonne capacité (ex: l.accommodates) |

## Utilisation dans mes analyses

prix_quartiers.sql : {{ prix_par_personne('price', 'accommodates') }} as prix_par_personne
-> avg_prix_personne = moyenne normalisée par capacité

Avantage

text
* Comparaison équitable : apparts 1 personne vs 4 personnes
* Analyse tarifaire par personne (plus pertinent que prix brut)
* Réutilisable tous modèles listings