select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select polarization_score
from `workspace`.`movielens_volume`.`movie_performance`
where polarization_score is null



      
    ) dbt_internal_test