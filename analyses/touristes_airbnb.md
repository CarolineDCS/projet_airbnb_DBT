# Analyse : Part Airbnb dans le Tourisme Amsterdam

## Objectif métier
**Quantifie la part des touristes Airbnb** vs tourisme total à Amsterdam par année (benchmark légal/régulation).

## Logique d'estimation (5 étapes)

* % illégaux : 5.96% listings > 4 personnes max (limite légal à Amsterdam)
*  Nb locataires estimés : accommodates x 0.75 (taux réaliste)
* Pas d'estimation s'il n'y a qu'un locataire
*    Nb séjours estimés :
    *     x 0.5 : Benchmark officiel Airbnb (trouvé dans git des données Airbnb)

    *     x 0.8 : Tendance réelle observée chez les hôtes (reddit et autres)

*    Nb touristes Airbnb : séjours × locataires

*    % Airbnb/total : touristes Airbnb ÷ tourisme officiel

## Détail des CTE
| Étape | Calcul clé |
|-------|------------|
| `estimaton_locataire` | `accommodates × 0.75` |
| `estimation_location` | `reviews × 0.5` (benchmark Airbnb) / `× 0.8` (hôtes réels) |
| `estimation_tourist` | **Touristes Airbnb par listing par an** |
| Finale | **% Airbnb vs tourisme officiel** + YoY |

## Métriques finales (4 colonnes par an)
| Colonne | Signification |
|---------|---------------|
| `pct_tourist_per_year_ratio50pct` | **Part Airbnb benchmark 0.5** |
| `yoy_pct_ratio50pct` | **Évolution annuelle 0.5** |
| `pct_tourist_per_year_ratio80pct` | **Part Airbnb tendance 0.8** |
| `yoy_pct_ratio80pct` | **Évolution annuelle 0.8** |

## Utilisation
* Insight :
    * Airbnb = X% du tourisme Amsterdam
    * Evolution par an de ce pourcentage  
* Graphique : Comparaison benchmark Airbnb vs réalité hôtes



