# Analyse : Prix Super Hôte vs Non-Super Hôte

## Objectif métier
**Comparaison statistique des prix** entre Super Hôtes et hôtes normaux pour valider l'hypothèse : **"Super Hôte = prix plus élevés ?"**

## Logique d'analyse
**Dataset** : `curation_hosts x curation_listings` (Amsterdam)

Super Hôte (TRUE/FALSE)
-> INNER JOIN sur host_id
-> GROUP BY type_d_hote
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

* Super Hôtes = prix médian + élevé ?
* Super Hôtes = plus de locations Entire home/apt qui expliquerait une différence de prix ?
* Super Hôtes = prix plus stables (moins d'écart-type) ?

## Utilisation

* Graphiques :

  *  Bar chart : prix_moyen × type_d_hote

   * Boxplot : Distribution prix par type d'hôte
   * Insight : Stratégie tarifaire Super Hôte premium ?
