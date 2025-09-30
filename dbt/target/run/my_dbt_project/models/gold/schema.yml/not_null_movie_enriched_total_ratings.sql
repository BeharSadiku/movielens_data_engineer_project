select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select total_ratings
from `workspace`.`movielens_volume`.`movie_enriched`
where total_ratings is null



      
    ) dbt_internal_test