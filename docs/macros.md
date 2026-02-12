# Macros Statistiques pour Analyses Pricing

Ensemble de **5 macros réutilisables** pour analyses statistiques Airbnb (boxplots, distributions).

## Macros disponibles

### calcul_q1(nom_colonne)

* PERCENTILE_DISC(0.25) WITHIN GROUP (ORDER BY nom_colonne)

* 1er quartile (25e percentile) → gauche de la boîte boxplot

### calcul_q3(nom_colonne)


 * PERCENTILE_DISC(0.75) WITHIN GROUP (ORDER BY nom_colonne)

* 3e quartile (75e percentile) → droite de la boîte boxplot

### inter_quartile(nom_colonne)

* calcul_q3(nom_colonne) - calcul_q1(nom_colonne)

* Écart interquartile = largeur de la boîte boxplot

 ### pct_distribution(nb_categorie, total)

* ROUND(100.0 * nb_categorie / total, 2)

* Pourcentage avec arrondi 2 décimales

 ### stddev_safe(nom_colonne)

* CASE WHEN COUNT(DISTINCT nom_colonne) <= 1 THEN 0 
     ELSE STDDEV(nom_colonne) 
END

* Écart-type sécurisé : retourne 0 si toutes valeurs identiques (évite NULL)

## Avantages


* Boxplot complet : Q1/Q3/interquartile
* pourcentage toujours arrondis
* Écart-type robuste (gère constantes)
* Macros imbriquées (inter_quartile = Q3-Q1)

# Macro : Prix par Personne

## Objectif
**Calcule le prix unitaire par personne** pour normalisation des tarifs Airbnb.

## Syntaxe
{{ prix_par_personne('l.price', 'l.accommodates') }}

## Logique


* prix_par_personne = nom_colonne_prix / nom_colonne_nb_personne

* Exemple : 150€ / 4 personnes = 37.5€/personne

## Avantages

 * comparaison équitable : location pour 1 personne vs pour 4 personnes
* Analyse tarifaire par personne (plus pertinent que prix brut)
* Réutilisable tous modèles listings 
