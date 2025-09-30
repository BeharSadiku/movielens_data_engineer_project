
  
    
        create or replace table `workspace`.`movielens_volume`.`silver_ratings`
      
      
    using delta
      
      
      
      
      
      
      as
      

select
    user_id,
    movie_id,
    round(rating, 2) as rating,           
    to_date(cast(rated_at as timestamp)) as rating_date  
from `workspace`.`movielens_volume`.`bronze_ratings`
where user_id is not null
  and user_id > 0
  and movie_id is not null
  and movie_id > 0
  and rating is not null
  and rating >= 0
  and rating <= 5
  