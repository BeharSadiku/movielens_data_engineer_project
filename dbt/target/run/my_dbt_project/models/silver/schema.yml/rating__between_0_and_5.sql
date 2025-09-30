
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from `workspace`.`movielens_volume`.`silver_ratings`

where not(rating (CAST(rating AS DOUBLE) >= 0 AND CAST(rating AS DOUBLE) <= 5))


  
  
      
    ) dbt_internal_test