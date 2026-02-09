# Macros Statistiques pour Analyses des prix

Ensemble de **5 macros réutilisables** pour analyses statistiques Airbnb (boxplots, distributions).

## Macros disponibles

###  calcul_q1(nom_colonne)

PERCENTILE_DISC(0.25) WITHIN GROUP (ORDER BY nom_colonne)

1er quartile (25e percentile) -> debut de la boîte boxplot

### calcul_q3(nom_colonne)

PERCENTILE_DISC(0.75) WITHIN GROUP (ORDER BY nom_colonne)

3e quartile (75e percentile) -> fin de la boîte boxplot

### inter_quartile(nom_colonne)

calcul_q3(nom_colonne) - calcul_q1(nom_colonne)

Écart interquartile = longueur de la boîte boxplot

###  pct_distribution(nb_categorie, total)

ROUND(100.0 * nb_categorie / total, 2)

Pourcentage avec arrondi 2 décimales

### stddev_safe(nom_colonne)

CASE WHEN COUNT(DISTINCT nom_colonne) <= 1 THEN 0 
     ELSE STDDEV(nom_colonne) 
END

Écart-type sécurisé : retourne 0 si toutes valeurs identiques (évite NULL)

## Tests des macros

* Avec le modèle modele_test_prix.sql situé dans models/tests
* Avec le modèle test.pct_distribution situé dans models/tests

## Utilisation dans mes analyses

* Etude des prix 
    * analyse prix : {{ calcul_q1('l.price') }}, {{ calcul_q3('l.price') }}, {{ inter_quartile('l.price') }}
    * analyse % : {{ pct_distribution('nb_super_host', 'nb_host') }}
    * dispersion : {{ stddev_safe('price') }}
* Dans les autres :  pct_distribution

## Avantages

* Boxplot complet : Q1/Q3/interquartile
* % toujours arrondis
* Écart-type robuste (gère constantes)
* Macros imbriquées (inter_quartile = Q3-Q1)
