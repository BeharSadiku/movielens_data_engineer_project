select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    movie_id as unique_field,
    count(*) as n_records

from `workspace`.`movielens_volume`.`movie_enriched`
where movie_id is not null
group by movie_id
having count(*) > 1



      
    ) dbt_internal_test