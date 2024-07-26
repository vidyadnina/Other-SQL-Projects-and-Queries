SELECT * 
FROM  spotify.spotify_data;

SELECT popularity,track_id,track_name,track_genre,album_name,artists,duration_ms,explicit,danceability,energy,key,loudness,mode,speechiness,acousticness,instrumentalness,liveness,valence,tempo,time_signature
FROM spotify.spotify_data;

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
FROM spotify.spotify_data;


DROP TABLE IF EXISTS spotify.data_nonulls;
CREATE TABLE spotify.data_nonulls AS
(SELECT popularity,
CASE  WHEN popularity >= 75 THEN "High"
                WHEN popularity >= 50 THEN "Medium-high"
                WHEN popularity >= 25 THEN "Medium-low"
                ELSE "Low"
          END AS tier,
track_name,track_genre,album_name,artists,duration_ms,explicit,danceability,energy,key,loudness,mode,speechiness,acousticness,instrumentalness,liveness,valence,tempo,time_signature
FROM spotify.spotify_data
WHERE track_name IS NOT NULL AND
      album_name IS NOT NULL AND 
      artists IS NOT NULL
ORDER BY popularity desc
);

SELECT * 
FROM spotify.data_nonulls;

SELECT COUNT(track_id), COUNT(track_name)
FROM spotify.data_nonulls;


SELECT DISTINCT track_genre,avg(popularity) as avg_popularity
FROM  spotify.data
GROUP BY track_genre
ORDER BY avg_popularity desc
LIMIT 25;

WITH  distinct_track as (
SELECT DISTINCT track_name, artists,tier
FROM  spotify.data
ORDER BY track_name)
select artists, COUNT(*) as n_popularsongs
FROM  distinct_track
WHERE tier IN ("High","Viral")
GROUP BY artists
ORDER BY n_popularsongs desc
LIMIT 25;

SELECT  track_genre, tier, COUNT(*) as count
FROM    spotify.data
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
FROM spotify.data;

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
FROM spotify.data
GROUP BY tier;
