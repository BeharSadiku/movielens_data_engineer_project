



select
    1
from `workspace`.`movielens_volume`.`silver_tags`

where not(tagged_date tagged_date IS NOT NULL)

