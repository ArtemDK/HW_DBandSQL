/* Создайте представление, в которое попадет информация о пользователях(имя,фамилия, город и пол), которые не старше 20 лет.*/

CREATE VIEW young_users AS
SELECT u.firstname, u.lastname, p.hometown, p.gender
FROM users u
JOIN profiles p ON u.id = p.user_id
WHERE p.birthday >= DATE_SUB(CURDATE(), INTERVAL 20 YEAR);

SELECT * FROM young_users;

/* Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователей, указав имя и фамилию пользователя,количество отправленных сообщений
и место в рейтинге(первое место у пользователя с максимальным количеством сообщений). (используйте DENSE_RANK) */

CREATE VIEW message_counts AS
SELECT u.firstname, u.lastname, m.from_user_id, COUNT(*) AS message_count,
       DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS ranking
FROM users u
JOIN messages m ON u.id = m.from_user_id
GROUP BY u.id, u.firstname, u.lastname;

SELECT firstname, lastname, message_count, ranking
FROM message_counts;

/* Выберите все сообщения,отсортируйте сообщения повозрастанию даты отправления (created_at) инайдите разницу дат отправления между соседними сообщениями,получившегося списка.(используйте LEAD или LAG)*/
SELECT
  body,
  created_at,
  LEAD(created_at) OVER (ORDER BY created_at) - created_at AS time_difference
FROM
  messages
ORDER BY
  created_at;
