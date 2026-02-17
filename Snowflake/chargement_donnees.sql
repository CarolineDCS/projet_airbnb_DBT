USE WAREHOUSE COMPUTE_WH;
USE DATABASE AIRBNB;
USE SCHEMA RAW;    
    
create or replace api integration integration_jeu_de_donnees_github
api_provider = git_https_api
api_allowed_prefixes = ('https://github.com/CarolineDCS')
enabled = true;

create or replace git repository jeu_de_donnees_airbnb
api_integration = integration_jeu_de_donnees_github
origin = 'https://github.com/CarolineDCS/Airbnb_data.git';

create or replace file format format_jeu_de_donnees
type = csv
skip_header = 1
field_optionally_enclosed_by = '"';


CREATE TABLE AIRBNB.RAW.HOSTS
(
    host_id                STRING,
    host_name              STRING,
    host_since             DATE,
    host_location          STRING,
    host_response_rate     STRING,
    host_is_superhost      STRING,
    host_identity_verified STRING
);


insert INTO AIRBNB.RAW.HOSTS (SELECT $1 as host_id,
                                     $2 as host_name,
                                     $3 as host_since,
                                     $4 as host_location,
                                     $5 as host_response_rate,
                                     $6 as host_is_superhost,
                                     $7 as host_identity_verified
                              from @jeu_de_donnees_airbnb/branches/main/hosts.csv
                          (FILE_FORMAT => 'format_jeu_de_donnees'));



CREATE TABLE AIRBNB.RAW.LISTINGS
(
    id                     STRING,
    listing_url            STRING,
    name                   STRING,
    description            STRING,
    neighbourhood_overview STRING,
    host_id                STRING,
    neighbourhood_cleansed STRING,
    latitude               STRING,
    longitude              STRING,
    property_type          STRING,
    room_type              STRING,
    accommodates           integer,
    bathrooms              FLOAT,
    bedrooms               FLOAT,
    amenities              STRING,
    price                  STRING,
    minimum_nights         INTEGER,
    maximum_nights         INTEGER
);



INSERT INTO AIRBNB.RAW.LISTINGS (SELECT $1  AS id,
                                        $2  AS listing_url,
                                        $3  AS name,
                                        $4  AS description,
                                        $5  AS neighbourhood_overview,
                                        $6  AS host_id,
                                        $7 AS neighbourhood_cleansed,
                                        $8  AS latitude,
                                        $9  AS longitude,
                                        $10  AS property_type,
                                        $11 AS room_type,
                                        $12 AS accommodates,
                                        $13 AS bathrooms,
                                        $14 AS bedrooms,
                                        $15 AS amenities,
                                        $16 AS price,
                                        $17 AS minimum_nights,
                                        $18 AS maximum_nights
                                 from @jeu_de_donnees_airbnb/branches/main/listings.csv
                          (FILE_FORMAT => 'format_jeu_de_donnees'));


CREATE TABLE AIRBNB.RAW.REVIEWS
(
    listing_id  STRING,
    date        DATE
);


INSERT INTO AIRBNB.RAW.REVIEWS (SELECT $1 as listing_id,
                                       $2 as date
                                from @jeu_de_donnees_airbnb/branches/main/reviews.csv
                                    (FILE_FORMAT => 'format_jeu_de_donnees'));
