# Projet AIRBNB sous DBTY : Création d'une pipeline ELT et de fichiers d'analyse de données

## Description du projet
Dans ce projet, j'ai créé une pipeline d'intégration de données de fichier d'AirBnb. Les fichiers CSV d'AirBNB sont récupérées sous Snowflake. La pipeline vérifie la qualité des données, transforme les données puis les dispatche dans les tables finales à l'aide de modèle DBT. Nous proposons aussi quatre analyses des données ainsi traitées.

## Stack technique
 * **Snowflake** : Gestionnaire de bases de données
 * **CSV** : Format principal pour l'échange et le stockage intermédiaire de données brutes, la préparation des fichiers sources pour les pipelines ELT, l'export rapide depuis LibreOffice/Excel, et le chargement initial scalable vers Snowflake via COPY INTO.
 * **dbt (Data Build Tool)** : Outil central de transformation des données en SQL au sein d'une pipeline ELT, permettant la définition et la gestion des modèles de données, la modularisation du code analytique, et l’automatisation complète des dépendances via les graphes DAG. DBT assure la reproductibilité et la traçabilité des transformations tout en s’intégrant nativement à Snowflake.
 * **Modèles dbt (models)** : Composants principaux de la pipeline analytique définissant les transformations SQL, la structuration logique des données sources, et la production d’un modèle analytique cohérent et maintenable au sein du data warehouse.
 * **Macros dbt** : Fonctions réutilisables écrites en Jinja servant à automatiser des patterns SQL complexes, à paramétrer dynamiquement les transformations, et à centraliser la logique métier répétitive (conditions, filtres, calculs standardisés).
 * **Seeds dbt** : Fichiers CSV intégrés au dépôt dbt et chargés directement en tables Snowflake pour fournir des référentiels statiques nécessaires à l'analyse de nos données.
 * **Tests dbt** : Mécanisme intégré de contrôle qualité permettant de valider automatiquement l’intégrité des données (unicité, non-nullité, relations entre tables), de garantir la fiabilité de chaque modèle, et de sécuriser les mises en production via des validations systématiques.
 * **Snapshots dbt** : Fonctionnalité dédiée au suivi des évolutions des données dans le temps, permettant de capturer et historiser les changements ligne à ligne selon une logique de type SCD (Slowly Changing Dimensions), essentielle pour les analyses temporelles.
 * **Analyses dbt (analysis files)** : Requêtes SQL exploratoires intégrées au projet, utilisées pour produire des analyses ad hoc, et faciliter la compréhension métier sans perturber les pipelines de production.

## Données utilisées
* Le jeu de données airbnb a été téléchargé depuis le site https://insideairbnb.com/get-the-data/ qui regroupe les données Airbnb pour plusieurs villes. Pour notre travail, nous avons choisi la ville d'Amsterdam correspondant à un extrait du 11 septembre 2026.


Division du fichier listings.csv.gz en 2 fichiers:
  * [listings](https://github.com/CarolineDCS/Airbnb_data/blob/main/listings.csv) avec un nombre de colonnes réduit et qui ne contient que les donneées qui touchent directement au listing (i.e. on a enlevé les données de l'hôte et sur les revues)
  * [hosts](https://github.com/CarolineDCS/Airbnb_data/blob/main/hosts.csv) ce fichier, extrait du fichier listings.csv.gz, ne contient que les infos concernant l'hoôte. Ici aussi, nous avons limité le nombre de colonnes par rapport à toutes les infos qu'on avait
  * [reviews](https://github.com/CarolineDCS/Airbnb_data/blob/main/reviews.csv) ce fichier a été téléchargé du jeu de données résumé où on n'a que 2 colonnes: le listing_id et la date du commentaire qui a été laissé.

* Jeu de données du nombre de touriste par séjour à Amsterdam par année : [touristes par an](seeds/tourists_per_year.csv) . L'année 2025 est une approximation comptant sur une augmentation de 3% du nombre de touristes par séjour.


## Axes étudiés

### Vision administrateur
* Création de la base de donnée et du schéma RAW, ainsi que création du rôle dbt permettant de connecter Snowflake et DBT.
   * fichier concerné : [init_droit.sql](Snowflake/init_droit.sql)
*   * Création récupération des données, et créations des tables du schéma RAW où DBT récupèrera les données.
  * fichier concerné :  [chargement_donnees.sql](Snowflake/chargement_donnees.sql)

### Vison Data Engineer 
Le projet est structuré autour du squelette standard de dbt, avec les dossiers principaux models, tests, seeds, snapshots, macros, ainsi que le fichier central dbt_project.yml pour la configuration globale du projet. La logique suit un flux ELT complet : les données brutes sont d’abord chargées dans Snowflake, puis font l’objet de transformations progressives dans dbt jusqu’aux modèles analytiques finaux, directement exploitables pour l’exploration et l’analyse.

* Création du fichier [sources.yml](models/sources.yml) afin de tester la qualité des données des tables du schema RAW
* Création des tests personalisés ([repertoire tests])(tests) afin de tester plus finement la qualité des données (notamment en vérifiant le format de ces dernières) 
* Création des snapshots : En excluant les données ne vérifiant pas les tests précédents nous allons créer 3 snapshots, l'un pour les hôtes [hosts_snapshot](snapshots/hosts_snapshot.sql), l'un pour les annonces [listings_snaphots](snapshots/listings_snapshot.sql) et un denier pour les reviews [reviews_snaphot](snapshots/reviews_snapshot.sql)
* Création de la seed pour récupérer le nombre de touristes à Amsterdam par **séjour** et par an [tourists_per_year](seeds/tourists_per_year.csv), et la seed [tests_stat_prix.csv](seeds/tests/tests_stat_prix.csv) pour tester les macros statistique ([macros_statistiques.sql](macros/macros_statistiques.sql)).
* Création des modèles ([repertoire models/curation](models/curation)),de modèles ([repertoire models/tests](models/tests)) pour tester les macros ([repertoire macros](macros)), ainsi que des tests de validité de données ([repertoire tests](tests)) et [schema.yml](models/curation/schema.yml) .
  <picture>
 <img alt="lineage_dbt" src="images/lineage.png" title="Le lineage du projet">
</picture>

### Vision  Analytics Engineer
* Analyse de la distribution des prix par quartier à Amsterdam ([Explications])(docs/prix_quartier.md).
   * Resultats : [fichier csv](images/prix_quartier.csv)  
* Analyse de la disistribution des super-hôtes Airbnb par quartier à Amsterdam ([Explications])(docs/super_hote.md).
    <picture>
 <img alt="Résultat de l'analyse de la distribution des super-hôtes Airbnb par quartier à Amsterdam." src="images/repartion_super_host.png" title="Risistribution des super-hôtes Airbnb par quartier à Amsterdam" >
</picture>
* Étude de la relation entre la qualification super-hôte et le prix ([Explications])(docs/prix_super_hote.md).
 <picture>
 <img alt="Résultat de l'analyse de la relation entre la qualification super-hôte et le prix à Amsterdam." src="images/prix_super_hote.png" title="Relation entre la qualification super-hôte et le prix à Amsterdam" >
</picture>
* Étude du nombre de touristes passant par Airbnb pour se loger à Amstedam ([Explications])(docs/nb_tourist_airbnb.md). 
* <picture>
 <img alt="Résultat de l'analyse du nombre de touristes passant par Airbnb pour se loger à Amstedam." src="images/toursistes_airbnb.png" title=" Nombre de touristes passant par Airbnb pour se loger à Amstedam" >
</picture>


## Mise en place du projet
* Sous Snoflake : exécutez [init_droit.sql](Snowflake/init_droit.sql), puis  [chargement_donnees.sql](Snowflake/chargement_donnees.sql)
* Sous DBT :
  * créez un projet avec les données de ce github
  * connectez votre snowflake avec ce projet
  * exétutez les commandes suivantes : 
   * Pour nettoyer DBT : dbt clean
   * Pour ajouter le package dbt_utils qui sert pour les tests : dbt deps
   * Pour lancer le projet sans les tests de base et le lancer en développement : dbt build --exclude "resource_type:test"
     * En effet les tests de bases sur les données initiales échouent
     * Si vous voulez voir les données qui ne passe pas les tests, sur snowflake, elles se situent dans le schéma "AIRBNB.DATA_QUALITY_TESTS"
     * Les snapshots se trouve sur Snowflake dans le schéma : AIRBNB.SNAPSHOTS
     * Les modèles en développement se trouvent sur Snowflake dans le schéma : AIRBNB.CURATION_DEV
   * Si vous souhaitez voir les tests qui échouent : dbt test
   * Pour mettre les modèles en production : dbt build --vars:'{"curation_schema":"curation_prod"}' --select "resource_type:model"
      * Les modèles en développement se trouvent sur Snowflake dans le schéma : AIRBNB.CURATION_PROD

