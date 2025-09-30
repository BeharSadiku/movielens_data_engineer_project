select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select weighted_avg_rating
from `workspace`.`movielens_volume`.`movie_performance`
where weighted_avg_rating is null



      
    ) dbt_internal_test