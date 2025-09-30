select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select user_rating_count
from `workspace`.`movielens_volume`.`user_activity`
where user_rating_count is null



      
    ) dbt_internal_test