

-- =======================================================
-- Step 1: Base Ratings Join
-- Attach movie metadata (title, genres) to ratings
-- =======================================================
with ratings_base as (
    select
        r.movie_id,
        m.title,
        regexp_replace(m.genres, '\\|', ' | ') as genres,
        round(r.rating, 2) as rating,
        cast(r.rating_date as date) as rating_date
    from `workspace`.`movielens_volume`.`silver_ratings` r
    join `workspace`.`movielens_volume`.`silver_movies` m
        on r.movie_id = m.movie_id
),

-- =======================================================
-- Step 2: Weighted Rating
-- Compute avg rating, rating count, weighted avg
-- =======================================================
weighted_rating as (
    select
        movie_id,
        title,
        genres,
        round(avg(rating), 2) as avg_rating,
        count(*) as rating_count,
        round(sum(rating) / count(*), 2) as weighted_avg_rating
    from ratings_base
    group by movie_id, title, genres
),

-- =======================================================
-- Step 3: Polarization Score
-- Standard deviation of ratings per movie
-- =======================================================
polarization as (
    select
        movie_id,
        round(coalesce(stddev(rating), 0.0), 2) as polarization_score
    from ratings_base
    group by movie_id
),

-- =======================================================
-- Step 4: Top Rating Percentage
-- Percent of ratings >= 4.5
-- =======================================================
top_rating_pct as (
    select
        movie_id,
        round(100.0 * sum(case when rating >= 4.5 then 1 else 0 end) / count(*), 2) as top_rating_percentage
    from ratings_base
    group by movie_id
),

-- =======================================================
-- Step 5: Genre Ranking
-- Rank movies within each genre by weighted_avg_rating
-- =======================================================
genre_rank as (
    select
        movie_id,
        genres,
        weighted_avg_rating,
        rank() over (partition by genres order by weighted_avg_rating desc) as genre_rank
    from weighted_rating
),

-- =======================================================
-- Step 6: Tag Count
-- Count distinct tags per movie
-- =======================================================
tag_count as (
    select
        movie_id,
        count(distinct tag) as tag_count
    from `workspace`.`movielens_volume`.`silver_tags`
    group by movie_id
)

-- =======================================================
-- Step 7: Final Selection
-- Combine all metrics into the gold table
-- =======================================================
select
    w.movie_id,
    w.title,
    w.genres,
    w.weighted_avg_rating,
    w.rating_count,
    g.genre_rank,
    p.polarization_score,
    tr.top_rating_percentage,
    coalesce(tc.tag_count, 0) as tag_count
from weighted_rating w
join genre_rank g
    on w.movie_id = g.movie_id
join polarization p
    on w.movie_id = p.movie_id
join top_rating_pct tr
    on w.movie_id = tr.movie_id
left join tag_count tc
    on w.movie_id = tc.movie_id


-- Use NOT EXISTS for safer incremental inserts
where not exists (
    select 1 
    from `workspace`.`movielens_volume`.`movie_performance` t
    where t.movie_id = w.movie_id
)
