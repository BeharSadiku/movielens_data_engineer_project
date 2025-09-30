

select *
from `workspace`.`movielens_volume`.`user_activity`
where avg_user_rating < 0
   or avg_user_rating > 5

