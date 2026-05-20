# Statistical Macros for Rental Price Analysis

A set of **5 reusable macros** for Airbnb statistical analysis (box plots, distributions).

## Available Macros

### calcul_q1(column_name)

* PERCENTILE_DISC(0.25) WITHIN GROUP (ORDER BY column_name)

* 1st quartile (25th percentile) → left side of the boxplot

### calcul_q3(column_name)


 * PERCENTILE_DISC(0.75) WITHIN GROUP (ORDER BY column_name)

* 3rd quartile (75th percentile) → right side of the boxplot

### inter_quartile (column_name)

* q3_calc(column_name) - q1_calc(column_name)

* Interquartile range = width of the boxplot

 ### distribution_pct(category_count, total)

* ROUND(100.0 * category_count / total, 2)

* Percentage rounded to 2 decimal places

 ### stddev_safe(column_name)

* CASE WHEN COUNT(DISTINCT column_name) <= 1 THEN 0 
     ELSE STDDEV(column_name) 
END

* Safe standard deviation: returns 0 if all values are identical (avoids NULL)

## Advantages


* Complete boxplot: Q1/Q3/interquartile
* Percentages always rounded
* Robust standard deviation (handles identical values)
* Nested macros (inter_quartile = Q3-Q1)

# Macro: Price per Person

## Objective
**Calculates the unit price per person** for standardizing Airbnb rates.

## Syntax
{{ price_per_person(‘l.price’, ‘l.accommodates’) }}

## Logic


* price_per_person = price_column_name / number_of_people_column_name

* Example: €150 / 4 people = €37.50/person

## Benefits

* Fair comparison: rental for 1 person vs. rental for 4 people
* Price analysis per person (more relevant than the total price)
* Can be used with all listing templates 

# Macros Statistiques pour analyses des prix de location

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
* Écart-type robuste (gère les valeurs identiques)
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
