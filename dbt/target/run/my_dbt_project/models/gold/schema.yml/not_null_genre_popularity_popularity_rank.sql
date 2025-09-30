select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select popularity_rank
from `workspace`.`movielens_volume`.`genre_popularity`
where popularity_rank is null



      
    ) dbt_internal_test