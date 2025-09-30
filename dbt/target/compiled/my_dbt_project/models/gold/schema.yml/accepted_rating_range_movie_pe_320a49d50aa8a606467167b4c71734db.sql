

select *
from `workspace`.`movielens_volume`.`movie_performance`
where weighted_avg_rating < 0
   or weighted_avg_rating > 5

