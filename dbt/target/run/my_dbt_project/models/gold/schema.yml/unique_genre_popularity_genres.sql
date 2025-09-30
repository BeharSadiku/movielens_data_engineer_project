select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    genres as unique_field,
    count(*) as n_records

from `workspace`.`movielens_volume`.`genre_popularity`
where genres is not null
group by genres
having count(*) > 1



      
    ) dbt_internal_test