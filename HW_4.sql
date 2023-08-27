/* Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.*/
SELECT SUM(media_id) AS total_likes
FROM likes
JOIN profiles ON likes.user_id = profiles.user_id
WHERE DATEDIFF(CURRENT_DATE(), profiles.birthday) < 12 * 365; 
