# Analysis: Distribution of Superhosts by Amsterdam Neighborhood

## Business Objective
**Rank Amsterdam neighborhoods** by **percentage of Superhosts** to identify **premium areas**.

## Analysis Logic
**Dataset**: 
* [airbnb hosts](https://github.com/CarolineDCS/Airbnb_data/blob/main/hosts.csv) (Amsterdam only)
*  [airbnb listings](https://github.com/CarolineDCS/Airbnb_data/blob/main/listings.csv) (Amsterdam only)

* By neighborhood: percentage of Superhosts + ascending rank (percentage of Superhosts from lowest to highest)

 
## CTE details 
| CTE | Role |
|-----|------|
| `superhost_characteristics` |  percentage + rank by neighborhood** |
| `city_wide_characteristics` | percentage + rank across all Amsterdam data |

## Calculated metrics

* pct_super_host = {{ pct_distribution(nb_super_host, nb_host) }}
* sales_rank = RANK() OVER (ORDER BY pct_super_host ASC)



## Final result (5 columns)
| Column | Meaning |
|---------|---------------|
| `neighborhood` | ‘Entire city’ + Amsterdam neighborhoods |
| `nb_super_host` | Number of Superhosts |
| `nb_host` | Total number of hosts |
| `pct_super_host` | Percentage of Superhosts |
| `sales_rank` | 1 = fewest Superhosts, N = most Superhosts |

## Usage

* Dashboard: “Amsterdam Superhost Map”
* Insight: Where are Superhosts concentrated?


# Analyse : Répartition Super Hôtes par Quartier d'Amsterdam

## Objectif métier
**Classement des quartiers** d'Amsterdam par **pourcentage de Super Hôtes** pour identifier les **zones premium**.

## Logique d'analyse
**Dataset** : 
* [hosts airbnb](https://github.com/CarolineDCS/Airbnb_data/blob/main/hosts.csv) (Amsterdam uniquement)
*  [listings airbnb](https://github.com/CarolineDCS/Airbnb_data/blob/main/listings.csv) (Amsterdam uniquement)

* Par quartier : pourcentage de Super Hôtes + rang croissant ( pourcentage de super hotes du plus petit au plus grand)

 
## détail des CTE 
| CTE | Rôle |
|-----|------|
| `caracteristiques_super_hote` |  pourcentage + rang par quartier** |
| `caracteristiques_au_niveau_de_la_ville` | pourcentage + rang sur l'ensemble des données d'Amsterdam |

## Métriques calculées

* pct_super_host = {{ pct_distribution(nb_super_host, nb_host) }}
* sales_rank = RANK() OVER (ORDER BY pct_super_host ASC)



## Résultat final (5 colonnes)
| Colonne | Signification |
|---------|---------------|
| `neighbourhood` | 'Ville entière' + quartiers Amsterdam |
| `nb_super_host` | Nombre de Super Hôtes |
| `nb_host` | Nombre total d'hôtes |
| `pct_super_host` | pourcentage de Super Hôtes |
| `sales_rank` | 1 = le moins de Super Hôtes, N = le plus de Super Hôtes |

## Utilisation

* Dashboard : "map Super Hôtes Amsterdam"
* Insight : Où se concentrent les Super Hôtes ?
