select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select movie_id
from `workspace`.`movielens_volume`.`silver_links`
where movie_id is null



      
    ) dbt_internal_test