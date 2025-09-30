



select
    1
from `workspace`.`movielens_volume`.`user_activity`

where not(avg_user_rating (CAST(avg_user_rating AS DOUBLE) >= 0 AND CAST(avg_user_rating AS DOUBLE) <= 5))

