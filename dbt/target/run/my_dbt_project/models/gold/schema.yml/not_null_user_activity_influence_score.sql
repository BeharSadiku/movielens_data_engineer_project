select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select influence_score
from `workspace`.`movielens_volume`.`user_activity`
where influence_score is null



      
    ) dbt_internal_test