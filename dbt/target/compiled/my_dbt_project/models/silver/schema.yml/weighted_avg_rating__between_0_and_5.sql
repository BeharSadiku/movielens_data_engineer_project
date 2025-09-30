



select
    1
from `workspace`.`movielens_volume`.`movie_performance`

where not(weighted_avg_rating (CAST(weighted_avg_rating AS DOUBLE) >= 0 AND CAST(weighted_avg_rating AS DOUBLE) <= 5))

