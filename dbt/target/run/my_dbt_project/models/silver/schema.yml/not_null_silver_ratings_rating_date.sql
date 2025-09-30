select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select rating_date
from `workspace`.`movielens_volume`.`silver_ratings`
where rating_date is null



      
    ) dbt_internal_test