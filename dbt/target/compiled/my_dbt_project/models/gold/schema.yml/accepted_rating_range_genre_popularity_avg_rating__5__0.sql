

select *
from `workspace`.`movielens_volume`.`genre_popularity`
where avg_rating < 0
   or avg_rating > 5

