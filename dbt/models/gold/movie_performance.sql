{{ config(
    materialized='incremental',
    unique_key='genres'
) }}

-- =======================================================
-- Step 1: Base Ratings with Genres
-- Join ratings with movies to attach genres
-- =======================================================
with ratings_base as (
    select
        r.user_id,
        r.movie_id,
        r.rating,
        r.rating_date as rating_timestamp,  
        replace(m.genres, '|', ' | ') as genres
    from {{ ref('silver_ratings') }} r
    join {{ ref('silver_movies') }} m
        on r.movie_id = m.movie_id
),

-- =======================================================
-- Step 2: Aggregate Genre Metrics
-- For each genre, calculate total ratings, avg rating,
-- and distribution insights
-- =======================================================
genre_stats as (
    select
        replace(genres, '|', ' | ') as genres,
        count(*) as rating_count,
        round(avg(rating), 2) as avg_rating,  
        to_date(min(rating_timestamp)) as first_rating_date,  
        to_date(max(rating_timestamp)) as last_rating_date   
    from ratings_base
    group by genres
),

-- =======================================================
-- Step 3: Ranking Genres
-- Rank genres by popularity (# of ratings)
-- and quality (avg rating)
-- =======================================================
ranked_genres as (
    select
        genres,
        rating_count,
        avg_rating,
        first_rating_date,
        last_rating_date,
        rank() over (order by rating_count desc) as popularity_rank,
        rank() over (order by avg_rating desc) as quality_rank
    from genre_stats
)

-- =======================================================
-- Final Selection
-- One row per genre with full insights
-- =======================================================
select
    genres,
    rating_count,
    avg_rating,
    popularity_rank,
    quality_rank,
    first_rating_date,
    last_rating_date
from ranked_genres
