/*Задание 1. */

use lesson_5;
CREATE TABLE users_old (
    id BIGINT UNSIGNED,
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

DELIMITER //
CREATE PROCEDURE move_user(IN user_id BIGINT UNSIGNED)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;
    
   /* Перемещение пользователя из таблицы users в таблицу users_old */

    INSERT INTO users_old (id, firstname, lastname, email)
    SELECT id, firstname, lastname, email
    FROM users
    WHERE id = user_id;
    COMMIT;
END //
DELIMITER ;


/* Переместить пользователя с id=2 */

CALL move_user(2); 
    DELETE FROM users WHERE id = user_id;

/*Задание 2. * - необходимо создать хранимую функцию Hello(), 
которая будет возвращать приветствие в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу «Доброе утро», 
с 12:00 до 18:00 функция должна возвращать фразу «Добрый день», 
с 18:00 до 10:00 функция должна возвращать фразу «Добрый вечер», 
с 00:00 до 06:00 функция должна возвращать фразу «Доброй ночи». */

use lesson_5;
DELIMITER //

CREATE FUNCTION Hello()
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE current_hour INT;
    DECLARE greeting VARCHAR(20);
    
    SET current_hour = HOUR(CURRENT_TIME);
    
    IF current_hour >= 6 AND current_hour < 12 THEN
        SET greeting = 'Доброе утро';
    ELSEIF current_hour >= 12 AND current_hour < 18 THEN
        SET greeting = 'Добрый день';
    ELSEIF current_hour >= 18 AND current_hour < 22 THEN
        SET greeting = 'Добрый вечер';
    ELSE
        SET greeting = 'Доброй ночи';
    END IF;
    
    RETURN greeting;
END //

DELIMITER ;

-- Вызов функции Hello()
SELECT Hello(); 
