
  
    
        create or replace table `workspace`.`movielens_volume`.`silver_links`
      
      
    using delta
      
      
      
      
      
      
      as
      

with deduplicated as (

    select
        movie_id,
        imdbId as imdb_id,
        tmdbId as tmdb_id,
        row_number() over (partition by movie_id order by imdbId, tmdbId) as rn
    from `workspace`.`movielens_volume`.`bronze_links`
    where imdbId is not null
      and tmdbId is not null

)

select
    movie_id,
    imdb_id,
    tmdb_id
from deduplicated
where rn = 1
  