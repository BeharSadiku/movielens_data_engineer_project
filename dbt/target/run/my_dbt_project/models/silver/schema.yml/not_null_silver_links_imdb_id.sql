select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select imdb_id
from `workspace`.`movielens_volume`.`silver_links`
where imdb_id is null



      
    ) dbt_internal_test