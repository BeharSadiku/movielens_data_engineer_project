



select
    1
from `workspace`.`movielens_volume`.`silver_ratings`

where not(rating (CAST(rating AS DOUBLE) >= 0 AND CAST(rating AS DOUBLE) <= 5))

