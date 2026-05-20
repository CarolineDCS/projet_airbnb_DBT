# Analysis: Airbnb's Share of Tourism in Amsterdam

## Business Objective
**Quantify the share of Airbnb tourists** relative to total tourism in Amsterdam by year.

## Datasets Used

* [Airbnb listings](https://github.com/CarolineDCS/Airbnb_data/blob/main/listings.csv) (Amsterdam only)
* [tourists per year ](../seeds/tourists_per_year.csv) (Amsterdam only)
 
## Estimation logic (5 steps)

*    Percentage of illegal listings: 5.96% of listings for more than 4 people per Airbnb (Amsterdam does not allow more than 4 guests per Airbnb.)

*    Estimated number of guests:
     * accommodates × 0.75 (realistic rate) for 2 to 4 possible guests
     * 1 if no more than one guest is allowed
     *  4 for illegal listings (for more than 4 people) so they do not overly influence the results

*    Estimated number of stays: annual reviews × 0.5/0.8 (conversion rate)
  * the 0.5 ratio is the one proposed by the site providing the data
  * the 0.8 ratio is the one reported by hosts (Reddit, etc.)

*    Number of Airbnb tourists: estimated number of stays × estimated number of guests

*    Percentage of tourists in Amsterdam staying in an Airbnb (per stay): Number of Airbnb tourists in Amsterdam ÷ official number of tourists in Amsterdam


## CTE Details 
| Step | Key Calculation |
|-------|------------|
| `tenant_estimate` | `accommodates × 0.75` (realistic ratio) |
| `rental_estimate` | `reviews × 0.5/0.8` (estimated rentals) |
| `tourist_estimate` | Airbnb tourists per listing per year |
| Final | % Airbnb vs. official tourism + YoY |

## Final Metrics (4 columns per year)
| Column | Meaning |
|---------|---------------|
| `pct_tourist_per_year_ratio50pct` | Airbnb share with a 0.5 ratio |
| `yoy_pct_ratio50pct` | Year-over-year change with a 0.5 ratio |
| `pct_tourist_per_year_ratio80pct` | Airbnb share with a 0.8 ratio |
| `yoy_pct_ratio80pct` | Year-over-year change with a ratio of 0.8 |

## Usage

* Insight: 
  * Airbnb accounts for X% of tourism in Amsterdam
  * Change in this percentage
* Chart: Line chart showing Airbnb % vs. total tourism (2019–2025)

## Note
Please note that the year 2025 is incomplete; for Airbnb data, it ends on September 11, 2025. However, the number of tourists in Amsterdam covers the entire year 2025.

# Analyse : Part de location Airbnb dans le tourisme à Amsterdam

## Objectif métier
**Quantifie la part des touristes Airbnb** vs tourisme total à Amsterdam par année.

## Data set utilisés

* [listings airbnb](https://github.com/CarolineDCS/Airbnb_data/blob/main/listings.csv) (Amsterdam uniquement)
* [touristes par an ](../seeds/tourists_per_year.csv) (Amsterdam uniquement)
 
## Logique d'estimation (5 étapes)

*    pourcentage de listing illégaux : 5.96% listings pour plus de 4 personnes par Airbnb (Amsterdam ne permet pas plus de 4 locataires par Airbnb.)

*    Nombre de locataires estimés :
     * accommodates × 0.75 (taux réaliste) pour 2 à 4 locataires possibles
     * 1 s'il ne peut avoir plus d'un locataire
     *  4 pour les locations illégales (pour plus de 4 personnes) afin qu'elles n'influencent pas trop les résultats

*    Nombre de séjours estimés : reviews annuelles × 0.5/0.8 (taux conversion)
  * le ratio 0.5 est celui proposé par le site qui fournit les datas
  * le ration 0.8 est celui ressenti par les hotes (reddit, etc.)

*    Nombre de touristes Airbnb : nombre de séjours estimés × nombre de locataires estimés

*    Pourcentage de touristes à Amsterdam résidant dans un Airbnb (par séjour) : Nombre de touristes Airbnb à Amsterdam ÷ nombre de touristes officiel à Amsterdam


## détail des CTE 
| Étape | Calcul clé |
|-------|------------|
| `estimaton_locataire` | `accommodates × 0.75` (ratio réaliste) |
| `estimation_location` | `reviews × 0.5/0.8` (locations estimées) |
| `estimation_tourist` | Airbnb touristes par listing par an |
| Finale | % Airbnb vs tourisme officiel + YoY |

## Métriques finales (4 colonnes par an)
| Colonne | Signification |
|---------|---------------|
| `pct_tourist_per_year_ratio50pct` | Part Airbnb avec le ratio 0.5 |
| `yoy_pct_ratio50pct` | Évolution annuelle avec le ratio 0.5 |
| `pct_tourist_per_year_ratio80pct` | Part Airbnb avec le ratio 0.8 |
| `yoy_pct_ratio80pct` | Évolution annuelle avec le ratio 0.8 |

## Utilisation

* Insight : 
  * Airbnb représente X% du tourisme Amsterdam
  * Evolution de ce pourcentage
* Graphique : Line chart % Airbnb vs tourisme total (2019-2025)

## Note
Attention l'année 2025 n'est pas complète, pour les données Airbnb elle s'arrête le 11 septembre 2025. En revanche le nombre de touristes à Amsterdam concerne toute l'année 2025.
