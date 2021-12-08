-- 1. Create a stored function that receives a reader's ID as an input and returns a list of book 
-- IDs that he has already read and returned to the library
DROP FUNCTION IF EXISTS `GET_READ_BOOKS`;

DELIMITER $$

CREATE FUNCTION `GET_READ_BOOKS`(`id_subscriber` INTEGER UNSIGNED)
RETURNS VARCHAR(16383) DETERMINISTIC
RETURN (
	SELECT GROUP_CONCAT(`sb_book` SEPARATOR ',') 
	FROM `subscriptions`
	WHERE `id_subscriber` = `sb_subscriber` AND
		  `sb_is_active` = 'N'
)

$$

DELIMITER ;

-- 2. Create a stored function that returns a list of the first range of free values of 
-- auto-incrementing primary keys in the specified table (for example, if the table has 
-- primary keys 1, 4, 8, then the first free range is values 2 and 3)
DROP FUNCTION IF EXISTS GET_FREE_KEYS_IN_SUBSCRIPTIONS;

DELIMITER $$

CREATE FUNCTION GET_FREE_KEYS_IN_SUBSCRIPTIONS() 
RETURNS VARCHAR(16383) DETERMINISTIC
BEGIN
	DECLARE `start_value` INT DEFAULT 0;
	DECLARE `stop_value` INT DEFAULT 0;

	SELECT (`t1`.`sb_id` + 1) AS `gap_starts_at`, 
	   (
			SELECT MIN(`t3`.`sb_id`) - 1 
			FROM `subscriptions` AS `t3` 
			WHERE `t3`.`sb_id` > `t1`.`sb_id`
			LIMIT 1
		) AS `gap_ends_at`
	FROM `subscriptions` AS `t1`
	WHERE NOT EXISTS 
		(
			SELECT `t2`.`sb_id` 
			FROM `subscriptions` AS `t2` 
			WHERE `t2`.`sb_id` = `t1`.`sb_id` + 1
		)
	HAVING `gap_ends_at` IS NOT NULL
	LIMIT 1
	INTO `start_value`, `stop_value`;
    
	IF `stop_value` = `start_value` THEN
		IF `stop_value` = 0 THEN
			RETURN NULL;
		END IF;
		RETURN `stop_value`;
	END IF;

    RETURN CONCAT(`start_value`, '-', `stop_value`);
END;

$$

DELIMITER ;

-- 3. Create a stored function that receives the reader's ID as input and returns 1 if the 
-- reader currently has less than ten books, and 0 otherwise
DROP FUNCTION IF EXISTS `LESS_10_BOOKS`;

DELIMITER $$

CREATE FUNCTION `LESS_10_BOOKS`(`id_subscriber` INTEGER UNSIGNED)
RETURNS INTEGER DETERMINISTIC
BEGIN
	IF (
		SELECT COUNT(*)
		FROM `subscriptions`
		WHERE `id_subscriber` = `sb_subscriber` AND
			  `sb_is_active` = 'Y'
    ) < 10  
    THEN
		RETURN 1;
    END IF;
    RETURN 0;
END;

$$

DELIMITER ;
 
-- 4. Create a stored function that receives the year of publication of the book as input and 
-- returns 1 if the book was published less than a hundred years ago, and 0 otherwise
DROP FUNCTION IF EXISTS `LESS_100_YEARS`;

DELIMITER $$

CREATE FUNCTION `LESS_100_YEARS`(`date` DATE)
RETURNS INTEGER DETERMINISTIC
BEGIN
	IF DATE_SUB(CURDATE(), INTERVAL 100 YEAR) < `date`
    THEN
		RETURN 1;
    END IF;
    RETURN 0;
END;

$$

DELIMITER ;

-- 9. Create a stored procedure that automatically creates and fills in the "arrests" table with 
-- data, which should contain the IDs and names of readers who still have at least one book in 
-- their hands, for which the return date is set in the past relative to the current date
DROP PROCEDURE IF EXISTS `CREATE_ARREARS`;

DELIMITER $$

CREATE PROCEDURE `CREATE_ARREARS`()
BEGIN
	DROP TABLE IF EXISTS `arrears`;

	CREATE TABLE `arrears` (
	  `id` INTEGER UNSIGNED NOT NULL,
	  `name` varchar(150) NOT NULL,
	  PRIMARY KEY (`id`)
	);
    
    INSERT INTO `arrears`
    (`id`, `name`)
	(
		SELECT DISTINCT `s_id`, `s_name` 
		FROM `subscriptions` 
		JOIN `subscribers` ON `s_id` = `sb_subscriber`
        WHERE `sb_is_active` = 'Y' AND
			  `sb_finish` < CURDATE()
	);
END;

$$

DELIMITER ;