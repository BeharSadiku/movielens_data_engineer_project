select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select top_rating_percentage
from `workspace`.`movielens_volume`.`movie_performance`
where top_rating_percentage is null



      
    ) dbt_internal_test