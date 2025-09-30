



select
    1
from `workspace`.`movielens_volume`.`genre_popularity`

where not(avg_rating (CAST(avg_rating AS DOUBLE) >= 0 AND CAST(avg_rating AS DOUBLE) <= 5))

