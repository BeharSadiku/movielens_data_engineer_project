

select *
from `workspace`.`movielens_volume`.`movie_enriched`
where avg_rating < 0
   or avg_rating > 5

