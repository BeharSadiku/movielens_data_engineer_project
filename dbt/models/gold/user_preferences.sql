{{ 
  config(
    materialized='incremental',
    unique_key='user_id',
    tags=['gold']     
  ) 
}}

-- =======================================================
-- Step 1: Base Ratings
-- Load ratings and prepare timestamps for downstream aggregation
-- =======================================================
with ratings as (
    select
        user_id,
        movie_id,
        round(rating, 2) as rating,
        cast(rating_date as date) as rating_timestamp
    from {{ ref('silver_ratings') }}
),

-- =======================================================
-- Step 2: Movies Base
-- Load movie genres for user-genre analysis
-- =======================================================
movies as (
    select
        movie_id,
        genres
    from {{ ref('silver_movies') }}
),

-- =======================================================
-- Step 3: Per-user aggregated rating behavior
-- Calculate total ratings, average rating, first and last activity dates
-- =======================================================
user_overall as (
    select
        r.user_id,
        count(*) as user_rating_count,
        round(avg(r.rating), 2) as user_avg_rating,
        min(r.rating_timestamp) as first_activity_date,
        max(r.rating_timestamp) as last_activity_date
    from ratings r
    group by r.user_id
),

-- =======================================================
-- Step 4: User’s genre distribution
-- Calculate average rating and rating count per genre for each user
-- =======================================================
user_genres as (
    select
        r.user_id,
        m.genres,
        round(avg(r.rating), 2) as avg_rating,
        count(*) as genre_count
    from ratings r
    join movies m on r.movie_id = m.movie_id
    group by r.user_id, m.genres
),

-- =======================================================
-- Step 5: Pick the user’s top genre
-- Select the genre with highest rating count (tie-breaker = highest avg rating)
-- =======================================================
top_genre as (
    select user_id, genres as top_genre
    from (
        select
            ug.*,
            row_number() over (partition by ug.user_id order by ug.genre_count desc, ug.avg_rating desc) as rn
        from user_genres ug
    ) ranked
    where rn = 1
)

-- =======================================================
-- Step 6: Final Preferences Table
-- Combine overall user activity, influence, and top genre
-- =======================================================
select
    u.user_id,
    u.user_rating_count,
    u.user_avg_rating,
    u.first_activity_date,
    u.last_activity_date,
    u.user_rating_count as influence_score, 
    tg.top_genre
from user_overall u
left join top_genre tg on u.user_id = tg.user_id

{% if is_incremental() %}
  -- Incremental filter: only include users with new activity since last run
  where u.last_activity_date > (
    select coalesce(max(last_activity_date), date('1970-01-01')) from {{ this }}
  )
{% endif %}
