# Analyse : Part Airbnb dans le Tourisme Amsterdam

## Objectif métier
**Quantifie la part des touristes Airbnb** vs tourisme total à Amsterdam par année (benchmark /régulation).

## Logique d'estimation (5 étapes)

*    pourcentage illégaux : 5.96% listings >4 personnes par Airbnb (limite Amsterdam)

*    Nb locataires estimés :
     * accommodates × 0.75 (realistic fill rate) pour 2 à 4 locataires permis
     * 1 s'il ne peut avoir plus de locataire
     *  4 pour les locations illégales (pour plus de 4 personnes) afin qu'elles n'influencent pas trop les résultats

*    Nb séjours estimés : reviews annuelles × 0.5/0.8 (taux conversion)
  * le ratio 0.5 est celui proposé par le site qui fournit les datas
  * le ration 0.8 est celui ressenti par les hotes (reddit, etc.)

*    Nb touristes Airbnb : séjours × locataires

*    % Airbnb/total : Airbnb tourists ÷ tourisme officiel


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
| `pct_tourist_per_year_ratio50pct` | Part Airbnb 50% de reviews |
| `yoy_pct_ratio50pct` | Évolution annuelle |
| `pct_tourist_per_year_ratio80pct` | Part Airbnb 80% de reviews |
| `yoy_pct_ratio80pct` | **Évolution annuelle** |

## Utilisation

* Insight : 
  * Airbnb représente X% du tourisme Amsterdam (argument régulation)
  * Evolution de ce pourcentage
* Graphique : Line chart % Airbnb vs tourisme total (2019-2025)

## Note
Attention l'année 2025 n'est pas complète, elle s'arrête le 11 septembre 2025
