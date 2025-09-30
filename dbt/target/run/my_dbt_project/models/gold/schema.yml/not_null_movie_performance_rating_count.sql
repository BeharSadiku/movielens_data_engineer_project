select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select rating_count
from `workspace`.`movielens_volume`.`movie_performance`
where rating_count is null



      
    ) dbt_internal_test