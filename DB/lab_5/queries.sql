-- 5. Create a view that returns all information from the subscriptions table, converting the dates from t
-- he sb_start and sb_finish fields to the format “YYYY-MM-DD NN”, where “NN” is the day of the week as its 
-- full name (ie "Monday" , "Tuesday", etc.)
DROP FUNCTION IF EXISTS `DAY_OF_WEEK_RU`;
CREATE FUNCTION `DAY_OF_WEEK_RU`(`date_val` DATE)
RETURNS VARCHAR(15) DETERMINISTIC
	RETURN 
		CASE
			WHEN DAYOFWEEK(`date_val`) = 1 THEN 'Воскресенье'
			WHEN DAYOFWEEK(`date_val`) = 2 THEN 'Понедельник'
			WHEN DAYOFWEEK(`date_val`) = 3 THEN 'Вторник'
			WHEN DAYOFWEEK(`date_val`) = 4 THEN 'Среда'
			WHEN DAYOFWEEK(`date_val`) = 5 THEN 'Четверг'
			WHEN DAYOFWEEK(`date_val`) = 6 THEN 'Пятница'
			WHEN DAYOFWEEK(`date_val`) = 7 THEN 'Суббота'
		ELSE NULL END;


CREATE OR REPLACE VIEW `subscriptions_with_day_of_week` 
AS
	SELECT 
		`sb_id`,
        `sb_subscriber`,
        `sb_book`,
        CONCAT(`sb_start`, ' ', DAY_OF_WEEK_RU(`sb_start`)),
        CONCAT(`sb_start`,' ', DAY_OF_WEEK_RU(`sb_finish`)),
        `sb_is_active`
	FROM `subscriptions`;
    

-- 13. Create a trigger that does not allow adding information about the issue of a book to the database 
-- if at least one of the conditions is met:
-- • date of issue or return falls on Sunday;
-- • the reader has borrowed more than 100 books over the past six months;
-- • the time interval between the dates of issue and return is less than three days.
DROP TRIGGER `trg_new_subscription_ins`;

DELIMITER $$

CREATE TRIGGER `trg_new_subscription_ins`
BEFORE INSERT
ON `subscriptions`
	FOR EACH ROW
	BEGIN
		IF DATEDIFF(NEW.`sb_finish`, NEW.`sb_start`) < 3 THEN
			SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 
			'The time interval between the dates of issue and return is less than three days', 
			MYSQL_ERRNO = 1001;
        END IF;
        
		IF ((DAYOFWEEK(NEW.`sb_start`) = 1) OR (DAYOFWEEK(NEW.`sb_finish`) = 1)) 
        THEN
			SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Date of issue or return falls on Sunday', 
			MYSQL_ERRNO = 1001;
		END IF;
        
        SET @books_count_half_year = (
			SELECT COUNT(*) 
            FROM `subscriptions`
            WHERE `sb_subscriber` = NEW.`sb_subscriber` AND 
				  `sb_start` >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
        );
        
		IF @books_count_half_year > 100 THEN
			SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 
            'The reader has borrowed more than 100 books over the past six months', 
			MYSQL_ERRNO = 1001;
        END IF;
	END;
$$

DELIMITER ;

-- 15. Create a trigger that allows registration in the library only of those authors whose name does not 
-- contain any characters except letters, numbers, signs - (minus), '(apostrophe) and spaces (two or more 
-- consecutive spaces are not allowed)
DROP TRIGGER `trg_authors_name_ins`;
DROP TRIGGER `trg_authors_name_upd`;

DELIMITER $$

CREATE TRIGGER `trg_authors_name_ins`
BEFORE INSERT
ON `authors`
	FOR EACH ROW
	BEGIN
		IF ((NEW.`a_name` REGEXP '[^a-zA-Zа-яА-ЯёЁ0-9\-\' ]') 
			OR (NEW.`a_name` REGEXP '  ')) 
		THEN
			SET @msg = 
            CONCAT(
				'The name ', 
                NEW.`a_name`, 
				' breaks the rules'
			);
			SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = @msg, MYSQL_ERRNO = 1001;
        END IF;
	END;
$$

CREATE TRIGGER `trg_authors_name_upd`
BEFORE UPDATE
ON `authors`
	FOR EACH ROW
	BEGIN
		IF ((NEW.`a_name` REGEXP '[^a-zA-Zа-яА-ЯёЁ0-9\-\' ]') 
			OR (NEW.`a_name` REGEXP '  ')) 
		THEN
			SET @msg = 
            CONCAT(
				'The name', 
                NEW.`a_name`, 
				' breaks the rules'
			);
			SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = @msg, MYSQL_ERRNO = 1001;
        END IF;
	END;
$$

DELIMITER ;
 
-- 16. Create a trigger that corrects the title of the book so that it meets the following conditions:
-- a. no spaces are allowed at the beginning and end of the name;
-- b. no duplicate spaces are allowed;
-- c. the first letter in the name must always be capitalized.
DROP TRIGGER `trg_book_name_ins`;
DROP TRIGGER `trg_book_name_upd`;

DELIMITER $$

CREATE TRIGGER `trg_book_name_ins`
BEFORE INSERT
ON `books`
	FOR EACH ROW
	BEGIN
		SET NEW.`b_name` = 
        REPLACE(
            CONCAT(UCASE(LEFT(TRIM(NEW.`b_name`), 1)), 
            SUBSTRING(TRIM(NEW.`b_name`), 2)), 
            '  ', 
            ' '
        );
	END;
$$

CREATE TRIGGER `trg_book_name_upd`
BEFORE UPDATE
ON `books`
	FOR EACH ROW
	BEGIN
		SET NEW.`b_name` = 
        REPLACE(
            CONCAT(UCASE(LEFT(TRIM(NEW.`b_name`), 1)), 
            SUBSTRING(TRIM(NEW.`b_name`), 2)), 
            '  ', 
            ' '
        );
	END;
$$

DELIMITER ;

-- 17. Create a trigger that changes the issue date of the book to the current one, if the issue date 
-- specified in the IN-SERT or UPDATE query is less than the current one by six months or more
DROP TRIGGER `trg_sub_start_date_on_sub_ins`;
DROP TRIGGER `trg_sub_start_date_on_sub_upd`;

DELIMITER $$

CREATE TRIGGER `trg_sub_start_date_on_sub_ins`
BEFORE INSERT
ON `subscriptions`
	FOR EACH ROW
	BEGIN
		IF NEW.`sb_start` <= SUBDATE(CURDATE(), INTERVAL 6 MONTH) THEN
			SET NEW.`sb_start` = CURDATE();
        END IF;
	END;
$$

CREATE TRIGGER `trg_sub_start_date_on_sub_upd`
BEFORE UPDATE
ON `subscriptions`
	FOR EACH ROW
	BEGIN
		IF NEW.`sb_start` <= SUBDATE(CURDATE(), INTERVAL 6 MONTH) THEN
			SET NEW.`sb_start` = CURDATE();
        END IF;
	END;
$$

DELIMITER ;
