# Analysis: Price Distribution by Neighborhood in Amsterdam 

## Business Objective
**Comprehensive Airbnb price statistics** by neighborhood in Amsterdam to create a **box plot** and provide pricing insights.

## Analysis Logic
Dataset: [Airbnb listings](https://github.com/CarolineDCS/Airbnb_data/blob/main/listings.csv) (Amsterdam only)

listings 
-> Calculate price per person per rental
-> GROUP BY neighborhood
-> 14 statistical metrics + percentage of ‘Entire home/apt’ listings


## Metrics calculated by neighborhood
| Metric | Boxplot/Stat Role |
|----------|------------------|
| `avg_rental_price` | Average rental price |
| `median_rental_price` | Median rental price (boxplot line) |
| `Q1_rental_price` / `Q3_rental_price` | Q1 and Q3: Boxplot boxes |
| `interquartile_range_rental_price` | Interquartile range: length of the boxplot box |
| `range_rental_price` | Total dispersion |
| `min_rental_price` / `max_rental_price` | Boxplot whiskers |
| `rental_price_range` | Full range |

## Main columns

* nb_location → Volume per neighborhood
* avg_rental_price → Average price per neighborhood
* median_rental_price → Median price per neighborhood (more robust)
* Q1/Q3_rental_price/interquartile → Boxplot
* price_standard_dev → Variation around the mean
* pct_entire_home → % of full-size apartments


## Usage

* Dashboard: Box plot of prices by neighborhood
* Insight: “Which neighborhood has the greatest price variation?”
* Comparison: Average price vs. median price (are there any outliers?)

# Analyse : Distribution Prix par Quartier à Amsterdam 

## Objectif métier
**Statistiques complètes des prix Airbnb** par quartier d'Amsterdam pour créé un  **boxplot** + insights des prix.

## Logique d'analyse
Dataset : [listings airbnb](https://github.com/CarolineDCS/Airbnb_data/blob/main/listings.csv) (Amsterdam uniquement)

listings 
-> calcul du prix par personne possible par location
-> GROUP BY quartier
-> 14 métriques statistiques + pourcentage de logement de type 'Entire home/apt'


## Métriques calculées par quartier
| Métrique | Rôle Boxplot/Stat |
|----------|------------------|
| `avg_prix_location` | Moyenne du prix de location |
| `median_prix_location` | Médiane du prix de location (trait boxplot) |
| `Q1_prix_location` / `Q3_prix_location` | Q1 et Q3 : Boîtes boxplot |
| `ecart_inter_quartile_location` | écart interquartile : longeur de la boîte boxplot |
| `ecart_type_prix_location` | Dispersion totale |
| `min_prix_location` / `max_prix_location` | Moustaches de la boite boxplot |
| `etendue_prix_location` | Plage complète |

## Colonnes principales

* nb_location → Volume par quartier
* avg_prix_location → Prix moyen par quartier
* median_prix_location → Prix médian par quartier (plus robuste)
* Q1/Q3_prix_location/interquartile → Boxplot boîtes
* ecart_type_prix → Dispersion autour de la moyen
* pct_entire_home → % apparts complets



## Utilisation

* Dashboard : Boxplot prix par quartier quartier
* Insight : "Quel quartier a la plus forte dispersion prix ?"
* Comparaison : Prix moyen vs médian (présence ou non d'outliers ?)
