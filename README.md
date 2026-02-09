# Projet AIRBNB sous DBTY : Création d'une pipeline ELT et de fichiers d'analyse de données

## Description du projet
Dans ce projet, j'ai créé une pipeline d'intégration de données de fichier d'AirBnb. Les fichiers CSV d'AirBNB sont récupérées sous Snowflake. La pipeline vérifie la qualité des données, transforme les données puis les dispatche dans les tables finales à l'aide de modèle DBT. Nous proposons aussi trois analyses des données ainsi traiter.

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

## Données utilisés
Le jeu de données a été téléchargé depuis le site https://insideairbnb.com/get-the-data/ qui regroupe les données Airbnb pour plusieurs villes. Pour notre travail, nous avons choisi la ville d'Amsterdam correspondant à un extrait du 11 septembre 2026.


    Division du fichier listings.csv.gz en 2 fichiers:
        ** [listings](../Airbnb_data/tree/main/listings.csv) avec un nombre de colonnes réduit et qui ne contient que les donneées qui touchent directement au listing (i.e. on a enlevé les données de l'hôte et sur les revues)
        ** [hosts](../Airbnb_data/tree/main/hosts.csv) ce fichier, extrait du fichier listings.csv.gz, ne contient que les infos concernant l'hoôte. Ici aussi, nous avons limité le nombre de colonnes par rapport à toutes les infos qu'on avait
        ** [reviews](../Airbnb_data/tree/main/reviews.csv) ce fichier a été téléchargé du jeu de données résumé où on n'a que 2 colonnes: le listing_id et la date du commentaire qui a été laissé.


## Axes étudiés

### Vision administrateur
* Création de la base de donnée et du schéma RAW, ainsi que création du rôle dbt permettant de connecter Snowflake et DBT.
   * fichier concerné : [init_droit.sql](Snowflake/init_droit.sql)
*   * Création récupération des données, et créations des tables du schéma RAW où DBT récupèrera les données.
  * fichier concerné :  [chargement_donnees.sql](Snowflake/chargement_donnees.sql)

### Vison Data Engineer 
* Création des snapsh

