select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select genre_rank
from `workspace`.`movielens_volume`.`movie_performance`
where genre_rank is null



      
    ) dbt_internal_test