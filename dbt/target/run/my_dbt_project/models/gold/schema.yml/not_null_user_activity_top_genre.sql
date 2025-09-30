select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select top_genre
from `workspace`.`movielens_volume`.`user_activity`
where top_genre is null



      
    ) dbt_internal_test