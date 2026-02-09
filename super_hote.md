# Analyse : Répartition Super Hôtes par Quartier Amsterdam

## Objectif métier
**Classement des quartiers** d'Amsterdam par **% de Super Hôtes** pour identifier les **zones premium**.

## Logique d'analyse
**Dataset** : Annonces Airbnb Amsterdam uniquement (curation_hosts x curation_listings)

* Par quartier : % Super Hôtes + RANK() croissant ( pourcentage dde super hotes du plus petit au plus grand)

*  Amsterdam globale : benchmark ville entière

 
## détail des CTE 
| CTE | Rôle |
|-----|------|
| `caracteristiques_super_hote` | **% + RANK par quartier** |
| `caracteristiques_au_niveau_de_la_ville` | **Benchmark Amsterdam** |

## Métriques calculées

* pct_super_host = {{ pct_distribution(nb_super_host, nb_host) }}
* sales_rank = RANK() OVER (ORDER BY pct_super_host ASC)



## Résultat final (5 colonnes)
| Colonne | Signification |
|---------|---------------|
| `neighbourhood` | 'Ville entière' + quartiers Amsterdam |
| `nb_super_host` | Nombre Super Hôtes |
| `nb_host` | Total hôtes |
| `pct_super_host` | % Super Hôtes |
| `sales_rank` | 1 = pire quartier, N = meilleur |

## Utilisation

* Dashboard : "map Super Hôtes Amsterdam"
* Insight : Où se concentrent les Super Hôtes ?
