

-- =======================================================
-- Step 1: Aggregate Ratings
-- Calculate total ratings and average rating per movie
-- =======================================================
with ratings as (
    select
        movie_id,
        count(*) as total_ratings,
        round(avg(rating), 2) as avg_rating
    from `workspace`.`movielens_volume`.`silver_ratings`
    group by movie_id
),

-- =======================================================
-- Step 2: Movies Base
-- Load movie titles and genres from silver_movies
-- =======================================================
movies as (
    select
        movie_id,
        title,
        genres
    from `workspace`.`movielens_volume`.`silver_movies`
)

-- =======================================================
-- Step 3: Final Selection
-- Combine all metrics and movie info per movie
-- =======================================================
select
    m.movie_id,
    m.title,
    m.genres,
    coalesce(r.total_ratings, 0) as total_ratings,
    coalesce(r.avg_rating, 0) as avg_rating
from movies m
left join ratings r on m.movie_id = r.movie_id