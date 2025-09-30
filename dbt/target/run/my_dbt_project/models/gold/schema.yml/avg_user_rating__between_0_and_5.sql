
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from `workspace`.`movielens_volume`.`user_activity`

where not(avg_user_rating (avg_user_rating >= 0 AND avg_user_rating <= 5))


  
  
      
    ) dbt_internal_test