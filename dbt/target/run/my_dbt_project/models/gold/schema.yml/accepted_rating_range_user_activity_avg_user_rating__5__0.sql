select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      

select *
from `workspace`.`movielens_volume`.`user_activity`
where avg_user_rating < 0
   or avg_user_rating > 5


      
    ) dbt_internal_test