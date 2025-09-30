
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select tmdb_id
from `workspace`.`movielens_volume`.`movie_enriched`
where tmdb_id is null



  
  
      
    ) dbt_internal_test