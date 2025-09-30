select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select first_rating_date
from `workspace`.`movielens_volume`.`genre_popularity`
where first_rating_date is null



      
    ) dbt_internal_test