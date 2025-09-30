

select
    movie_id,
    trim(title) as title,
    replace(trim(genres), '|', ' | ') as genres
from `workspace`.`movielens_volume`.`bronze_movies`
where movie_id is not null
  and movie_id > 0
  and title is not null and trim(title) <> ''
  and genres is not null and trim(genres) <> ''