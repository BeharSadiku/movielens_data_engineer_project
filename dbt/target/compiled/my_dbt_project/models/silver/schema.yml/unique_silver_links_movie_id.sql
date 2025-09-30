
    
    

select
    movie_id as unique_field,
    count(*) as n_records

from `workspace`.`movielens_volume`.`silver_links`
where movie_id is not null
group by movie_id
having count(*) > 1


