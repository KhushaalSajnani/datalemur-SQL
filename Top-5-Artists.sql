SELECT * FROM (SELECT 
artist_name,
DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) as artist_rank
FROM artists a
JOIN songs s ON a.artist_id = s.artist_id
JOIN global_song_rank gr ON gr.song_id = s.song_id  and rank <= 10
GROUP BY 1
ORDER BY COUNT(*) DESC
) as t
WHERE artist_rank <= 5