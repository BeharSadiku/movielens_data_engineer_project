select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      

select *
from `workspace`.`movielens_volume`.`movie_performance`
where weighted_avg_rating < 0
   or weighted_avg_rating > 5


      
    ) dbt_internal_test