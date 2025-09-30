



select
    1
from `workspace`.`movielens_volume`.`silver_ratings`

where not(rating_date rating_date IS NOT NULL)

