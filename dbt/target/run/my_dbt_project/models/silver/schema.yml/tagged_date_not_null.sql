
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from `workspace`.`movielens_volume`.`silver_tags`

where not(tagged_date tagged_date IS NOT NULL)


  
  
      
    ) dbt_internal_test