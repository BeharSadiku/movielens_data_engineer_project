

select
    user_id,
    movie_id,
    trim(tag) as tag,
    to_date(cast(tagged_at as timestamp)) as tagged_date  
from `workspace`.`movielens_volume`.`bronze_tags`
where user_id is not null
  and user_id > 0
  and movie_id is not null
  and movie_id > 0
  and tag is not null
  and trim(tag) <> ''
  and tagged_at is not null