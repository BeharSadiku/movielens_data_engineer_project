



select
    1
from `workspace`.`movielens_volume`.`movie_performance`

where not(weighted_avg_rating (weighted_avg_rating >= 0 AND weighted_avg_rating <= 5))

