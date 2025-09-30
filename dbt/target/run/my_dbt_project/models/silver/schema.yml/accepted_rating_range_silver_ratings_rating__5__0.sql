select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      

select *
from `workspace`.`movielens_volume`.`silver_ratings`
where rating < 0
   or rating > 5


      
    ) dbt_internal_test