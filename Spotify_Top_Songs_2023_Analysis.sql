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

SELECT  track_genre, tier, COUNT(*) as count
FROM    spotify.data_cleaned
WHERE   tier IN ("High","Viral")
GROUP BY track_genre,tier
ORDER BY tier desc,count desc,track_genre
;

SELECT  ROUND(AVG(duration_ms),2) duration_ms,
        ROUND(AVG(danceability),2) danceability,
        ROUND(AVG(energy),2) energy,
        ROUND(AVG(speechiness),2) speechiness,
        ROUND(AVG(acousticness),2) acousticness,
        ROUND(AVG(instrumentalness),2) instrumentalness,
        ROUND(AVG(liveness),2) liveness,
        ROUND(AVG(valence),2) valence,
        ROUND(AVG(tempo),2) tempo
FROM spotify.data_cleaned;

# seeing if there's correlation between various aspects of a song and their popularity
SELECT  tier,
        ROUND(AVG(duration_ms),2) duration_ms,
        ROUND(AVG(danceability),2) danceability,
        ROUND(AVG(energy),2) energy,
        ROUND(AVG(speechiness),2) speechiness,
        ROUND(AVG(acousticness),2) acousticness,
        ROUND(AVG(instrumentalness),2) instrumentalness,
        ROUND(AVG(liveness),2) liveness,
        ROUND(AVG(valence),2) valence,
        ROUND(AVG(tempo),2) tempo
FROM spotify.data_cleaned
GROUP BY tier;
#from the results, it seems like as songs become more popular, they tend to have more danceability and less acousticness and instrumentallness, while other factors doesn't show a specific trend. a scatterplot to further visualize this analysis would be beneficial


SELECT 
  CASE  WHEN duration_ms < 180000 THEN 'Short' 
        WHEN duration_ms BETWEEN 180000 AND 300000 THEN 'Medium' 
        ELSE 'Long' 
  END as duration_category, 
  AVG(popularity) as avg_popularity 
FROM spotify.data 
GROUP BY duration_category;


SELECT        
        explicit, 
        AVG(popularity) as avg_popularity 
FROM spotify.data_cleaned 
GROUP BY explicit;


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
