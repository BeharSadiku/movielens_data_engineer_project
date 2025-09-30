select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select quality_rank
from `workspace`.`movielens_volume`.`genre_popularity`
where quality_rank is null



      
    ) dbt_internal_test