
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select avg_user_rating
from `workspace`.`movielens_volume`.`user_activity`
where avg_user_rating is null



  
  
      
    ) dbt_internal_test