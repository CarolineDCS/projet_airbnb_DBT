# Analysis: Rental Prices Offered by Superhosts vs. Non-Superhosts

## Business Objective
**Statistical comparison of prices** between Superhosts and regular hosts to validate or invalidate the hypothesis: **“Do Superhosts offer rentals at higher prices?”**

## Analysis Logic
**Dataset**: 
* [Airbnb hosts](https://github.com/CarolineDCS/Airbnb_data/blob/main/hosts.csv) (Amsterdam only)
*  [airbnb listings](https://github.com/CarolineDCS/Airbnb_data/blob/main/listings.csv) (Amsterdam only)

Superhost (TRUE/FALSE)
-> INNER JOIN on host_id between listings and hosts
-> GROUP BY host type (Superhost or not)
-> 8 price metrics + percentage of Entire home/apt 


## Comparative metrics (Superhost/non-Superhost)

| Metric | Superhost | Non-Superhost |
|----------|------------|----------------|
| `nb_host` | Total hosts | Total hosts |
| `nb_listing` | Total listings | Total listings |
| `pct_entire_home` | % of entire homes | % of entire homes |
| `median_price` | **Median price** | Median price |
| `average_price` | **Average price** | Average price |
| `price_standard_deviance` | **Dispersion** | Dispersion |
| `minimum_price` | Minimum price | Minimum price |
| `maximum_price` | Maximum price | Maximum price |

## Hypotheses to Test

* Is the median price of a listing offered by a Superhost higher?
* Do Superhosts offer more “Entire home/apt” listings, which would explain a price difference?
* Are the prices of listings offered by Superhosts more stable (lower standard deviation) than those of listings offered by non-Superhosts?

## Usage

* Charts:

  *  Bar chart: average_price x host_type

   * Boxplot: Price distribution by host type
   * Insight: Premium Super Host pricing strategy?

# Analyse : Prix location proposée par un Super Hôte vs Prix location proposée Non-Super Hôte

## Objectif métier
**Comparaison statistique des prix** entre Super Hôtes et hôtes normaux pour valider ou invalider l'hypothèse : **"Super Hôte propose des locations avec des prix plus élevés ?"**

## Logique d'analyse
**Dataset** : 
* [hosts airbnb](https://github.com/CarolineDCS/Airbnb_data/blob/main/hosts.csv) (Amsterdam uniquement)
*  [listings airbnb](https://github.com/CarolineDCS/Airbnb_data/blob/main/listings.csv) (Amsterdam uniquement)

Super Hôte (TRUE/FALSE)
-> INNER JOIN sur host_id entre les listings et les hotes
-> GROUP BY par type d'hote (Super Hote ou pas)
-> 8 métriques prix + pourcentage Entire home/apt 


## Métriques comparatives (super hôte/ pas super hôte)

| Métrique | Super Hôte | Non-Super Hôte |
|----------|------------|----------------|
| `nb_hote` | Total hôtes | Total hôtes |
| `nb_location` | Total listings | Total listings |
| `pct_entire_home` | % apparts complets | % apparts complets |
| `prix_median` | **Médiane prix** | Médiane prix |
| `prix_moyen` | **Moyenne prix** | Moyenne prix |
| `ecart_type_du_prix` | **Dispersion** | Dispersion |
| `prix_minimum` | Prix mini | Prix mini |
| `prix_maximum` | Prix maxi | Prix maxi |

## Hypothèses à tester

* Le prix médian d'une location proposé par un Super Höte est-il plus élevé ?
* Les Super Hôtes propose-t-il plus de locations Entire home/apt qui expliquerait une différence de prix ?
* Les prix des locations proposées par Super Hôtes sont-ils plus stables (moins d'écart-type) que ceux des locations proposées par des non Super Hôte ?

## Utilisation

* Graphiques :

  *  Bar chart : prix_moyen x type_d_hote

   * Boxplot : Distribution prix par type d'hôte
   * Insight : Stratégie tarifaire Super Hôte premium ?
