WITH caracteristiques_super_hote AS
(
    SELECT
        l.neighbourhood_cleansed as neighbourhood,
        count(CASE WHEN h.is_superhost = TRUE THEN 1 END) as nb_super_host,
        count(h.host_id) as nb_host,
        {{ pct_distribution('nb_super_host', 'nb_host') }} as pct_super_host,
        RANK() OVER (ORDER BY pct_super_host ASC) AS sales_rank
    FROM {{ ref("curation_hosts")}} as h
    INNER JOIN {{ ref("curation_listings")}} as l
    ON h.host_id = l.host_id
    GROUP BY neighbourhood
),
caracteristiques_au_niveau_de_la_ville AS
(
    SELECT 
        count(CASE WHEN is_superhost = TRUE THEN 1 END) as nb_super_host,
        count(host_id) as nb_host,
        {{ pct_distribution('nb_super_host', 'nb_host') }} as pct_super_host 
    FROM {{ ref("curation_hosts")}}
)
(SELECT 
    'Ville entière' as neighbourhood,
    v.nb_super_host,
    v.nb_host,
    v.pct_super_host,
    NULL as sales_rank
FROM caracteristiques_au_niveau_de_la_ville as v
)

UNION ALL

(SELECT 
    q.neighbourhood,
    q.nb_super_host,
    q.nb_host,
    q.pct_super_host,
    q.sales_rank
FROM caracteristiques_super_hote as q

)
