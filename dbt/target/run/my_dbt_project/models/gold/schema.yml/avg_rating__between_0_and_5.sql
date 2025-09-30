
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from `workspace`.`movielens_volume`.`movie_enriched`

where not(avg_rating (avg_rating >= 0 AND avg_rating <= 5))


  
  
      
    ) dbt_internal_test