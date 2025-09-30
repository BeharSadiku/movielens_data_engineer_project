select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select last_activity_date
from `workspace`.`movielens_volume`.`user_activity`
where last_activity_date is null



      
    ) dbt_internal_test