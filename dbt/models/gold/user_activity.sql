{{ config(
    materialized='incremental',
    unique_key='user_id'
) }}

-- =======================================================
-- Step 1: Base Ratings
-- Join ratings with movies to attach genres and prepare timestamps
-- =======================================================
with ratings_base as (
    select
        r.user_id,
        r.movie_id,
        round(r.rating, 2) as rating,
        cast(r.rating_date as date) as rating_timestamp,
        replace(m.genres, '|', ' | ') as genres
    from {{ ref('silver_ratings') }} r
    join {{ ref('silver_movies') }} m
        on r.movie_id = m.movie_id
),

-- =======================================================
-- Step 2: User Activity (General)
-- Calculate total ratings, average rating, first and last activity dates per user
-- =======================================================
user_activity as (
    select
        user_id,
        count(*) as user_rating_count,
        round(avg(rating), 2) as avg_user_rating,
        min(rating_timestamp) as first_activity_date,
        max(rating_timestamp) as last_activity_date
    from ratings_base
    group by user_id
),

-- =======================================================
-- Step 3: User Influence Score
-- Compute influence based simply on total ratings (more ratings = higher influence)
-- =======================================================
user_influence as (
    select
        user_id,
        user_rating_count as influence_score
    from user_activity
),

-- =======================================================
-- Step 4: Active Users by Genre
-- Count ratings per genre and rank genres per user
-- =======================================================
user_genre_activity as (
    select
        user_id,
        replace(genres, '|', ' | ') as genres,
        count(*) as genre_rating_count,
        rank() over (partition by user_id order by count(*) desc) as genre_rank
    from ratings_base
    group by user_id, genres
),

-- =======================================================
-- Step 5: New vs Loyal Users
-- Categorize users as new if first activity < 30 days ago, else loyal
-- =======================================================
user_type as (
    select
        user_id,
        case
            when min(rating_timestamp) >= date_sub(current_date(), 30)
                then 'new_user'
            else 'loyal_user'
        end as user_category
    from ratings_base
    group by user_id
),

-- =======================================================
-- Step 6: Top Genre per User
-- Identify the most active genre for each user
-- =======================================================
top_genre as (
    select
        user_id,
        max(genres) as top_genre
    from user_genre_activity
    group by user_id
)

-- =======================================================
-- Final Selection
-- Combine general activity, influence, type, and top genre per user
-- =======================================================
select
    ua.user_id,
    ua.user_rating_count,
    ua.avg_user_rating,
    ua.first_activity_date,
    ua.last_activity_date,
    ui.influence_score,
    ut.user_category,
    tg.top_genre
from user_activity ua
join user_influence ui on ua.user_id = ui.user_id
join user_type ut on ua.user_id = ut.user_id
left join top_genre tg on ua.user_id = tg.user_id
