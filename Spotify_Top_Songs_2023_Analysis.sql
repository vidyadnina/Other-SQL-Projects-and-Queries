SELECT * 
FROM  spotify.data;

SELECT popularity,track_id,track_name,track_genre,album_name,artists,duration_ms,explicit,danceability,energy,key,loudness,mode,speechiness,acousticness,instrumentalness,liveness,valence,tempo,time_signature
FROM spotify.data;

SELECT  COUNT(*) - COUNT(popularity) popularity,
        COUNT(*) - COUNT(track_id) track_id,
        COUNT(*) - COUNT(track_name) track_name,
        COUNT(*) - COUNT(track_genre) track_genre,
        COUNT(*) - COUNT(album_name) album_name,
        COUNT(*) - COUNT(artists) artists,
        COUNT(*) - COUNT(duration_ms) duration_ms,
        COUNT(*) - COUNT(explicit) explicit,
        COUNT(*) - COUNT(danceability) danceability,
        COUNT(*) - COUNT(energy) energy,
        COUNT(*) - COUNT(key) key,
        COUNT(*) - COUNT(loudness) loudness,
        COUNT(*) - COUNT(mode) mode,
        COUNT(*) - COUNT(speechiness) speechiness,
        COUNT(*) - COUNT(acousticness) acousticness,
        COUNT(*) - COUNT(instrumentalness) instrumentalness,
        COUNT(*) - COUNT(liveness) liveness,
        COUNT(*) - COUNT(valence) valence,
        COUNT(*) - COUNT(tempo) tempo,
        COUNT(*) - COUNT(time_signature) time_signature
FROM spotify.data;


DROP TABLE IF EXISTS spotify.data_nonulls;
CREATE TABLE spotify.data_cleaned AS
(SELECT popularity,
CASE  WHEN popularity >= 75 THEN "High"
                WHEN popularity >= 50 THEN "Medium-high"
                WHEN popularity >= 25 THEN "Medium-low"
                ELSE "Low"
          END AS tier,
track_name,track_genre,album_name,artists,duration_ms,explicit,danceability,energy,key,loudness,mode,speechiness,acousticness,instrumentalness,liveness,valence,tempo,time_signature
FROM spotify.data
WHERE track_name IS NOT NULL AND
      album_name IS NOT NULL AND 
      artists IS NOT NULL
ORDER BY popularity desc
);

SELECT * 
FROM spotify.data_cleaned;


SELECT DISTINCT track_genre,ROUND(AVG(popularity),2) as avg_popularity
FROM  spotify.data_cleaned
GROUP BY track_genre
ORDER BY avg_popularity desc
LIMIT 25;

SELECT  track_genre, tier, COUNT(*) as count
FROM    spotify.data_cleaned
WHERE   tier IN ("High")
GROUP BY track_genre,tier
ORDER BY tier desc,count desc,track_genre
;

SELECT DISTINCT artists,ROUND(AVG(popularity),2) as avg_popularity
FROM  spotify.data_cleaned
GROUP BY artists
ORDER BY avg_popularity desc
LIMIT 25;

WITH    distinct_track as (
SELECT  DISTINCT track_name, artists,tier
FROM    spotify.data_cleaned
ORDER BY track_name)
SELECT  artists, COUNT(*) as n_popularsongs
FROM    distinct_track
WHERE   tier IN ("High")
GROUP BY artists
ORDER BY n_popularsongs desc
LIMIT 25;

SELECT 
  ROUND(CORR(duration_ms, popularity),2) as duration_corr,
  ROUND(CORR(danceability, popularity),2) as danceability_corr,
  ROUND(CORR(energy, popularity),2) as energy_corr, 
  ROUND(CORR(speechiness, popularity),2) as speechiness_corr, 
  ROUND(CORR(acousticness, popularity),2) as acousticness_corr,
  ROUND(CORR(instrumentalness, popularity),2) as instrumentalness_corr,
  ROUND(CORR(liveness, popularity),2) as liveness_corr,
  ROUND(CORR(valence, popularity),2) as valence_corr,
  ROUND(CORR(tempo, popularity),2) as tempo_corr 
FROM spotify.data_cleaned;


SELECT 
  CASE  WHEN duration_ms < 180000 THEN 'Short' 
        WHEN duration_ms BETWEEN 180000 AND 300000 THEN 'Medium' 
        ELSE 'Long' 
  END as duration_category, 
  AVG(popularity) as avg_popularity 
FROM spotify.data_cleaned 
GROUP BY duration_category;


SELECT 
    track_genre, 
    explicit, 
    ROUND(AVG(popularity), 2) AS avg_popularity
FROM 
    spotify.data_cleaned
GROUP BY 
    track_genre, explicit
ORDER BY 
    avg_popularity DESC;

