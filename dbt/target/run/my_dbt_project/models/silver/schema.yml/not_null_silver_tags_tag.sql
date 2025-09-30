select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select tag
from `workspace`.`movielens_volume`.`silver_tags`
where tag is null



      
    ) dbt_internal_test