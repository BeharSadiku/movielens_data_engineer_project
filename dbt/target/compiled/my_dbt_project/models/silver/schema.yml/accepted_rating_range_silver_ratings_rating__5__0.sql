

select *
from `workspace`.`movielens_volume`.`silver_ratings`
where rating < 0
   or rating > 5

