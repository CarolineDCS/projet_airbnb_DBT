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
