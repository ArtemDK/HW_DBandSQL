/* Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.*/
SELECT SUM(media_id) AS total_likes
FROM likes
JOIN profiles ON likes.user_id = profiles.user_id
WHERE DATEDIFF(CURRENT_DATE(), profiles.birthday) < 12 * 365; 

/* Определить кто больше поставил лайков (всего): мужчины или женщины. */
SELECT profiles.gender, SUM(likes.media_id) AS total_likes
FROM likes
JOIN profiles ON likes.user_id = profiles.user_id
GROUP BY profiles.gender;

/*Вывести всех пользователей, которые не отправляли сообщения. */
SELECT firstname, lastname
FROM users
WHERE id NOT IN (SELECT DISTINCT from_user_id FROM messages);
