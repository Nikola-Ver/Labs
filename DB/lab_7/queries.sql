-- 1. Create a stored procedure that:
--      a. adds two random genres to each book;
--      b. cancels the performed actions if in the process of work at least one insert operation 
--         failed due to duplicate value of the primary key of the table "m2m_books_genres" (ie, such 
--         a book already had such a genre)
DROP PROCEDURE IF EXISTS `ADD_2_RAND_GENRES_TO_BOOKS`;

DELIMITER $$

CREATE PROCEDURE `ADD_2_RAND_GENRES_TO_BOOKS`()
BEGIN
	INSERT INTO `m2m_books_genres`
	(`b_id`, `g_id`)
    (
        SELECT `b_id`, `g_id` 
        FROM `books`
        JOIN (
            SELECT `g_id` 
            FROM `genres` 
            ORDER BY RAND() LIMIT 2
        ) AS `genres`    
    );
END;

$$

DELIMITER ;

-- 2. Create a stored procedure that:
--      a. increases the value of the "b_quantity" field for all books twice;
--      b. cancels the completed action if, as a result of the operation, the average number of book 
--         instances exceeds the value of 50
DROP PROCEDURE IF EXISTS `DOUBLE_NUM_OF_BOOKS`;

DELIMITER $$

CREATE PROCEDURE `DOUBLE_NUM_OF_BOOKS`()
BEGIN
	START TRANSACTION;
		UPDATE `books` SET `b_quantity` = `b_quantity` * 2;
        IF (
			SELECT AVG(`b_quantity`) 
            FROM `books`
		) > 50
        THEN 
			ROLLBACK;
        END IF;
    COMMIT;
END;

$$

DELIMITER ;

-- 3. Write queries that, if executed in parallel, would provide the following effect:
--      a. the first request should count the number of books issued and returned to the library and 
--         should not depend on requests to update the "subscriptions" table (not wait for their completion);
--      b. the second request must invert the values of the "sb_is_active" field of the subscriptions table 
--         from "Y" to "N" and vice versa and not depend on the first request (do not wait for its completion)
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;
    SELECT `sb_subscriber` AS `subscriber`,
        (
            SELECT COUNT(`sb_book`)
            FROM `subscriptions`
            WHERE `subscriber` = `sb_subscriber`
        ) AS `issued`,
        (
            SELECT COUNT(`sb_book`)
            FROM `subscriptions`
            WHERE `subscriber` = `sb_subscriber` AND
                `sb_is_active` = 'N'
        ) AS `returned`
    FROM `subscriptions`
    GROUP BY `sb_subscriber`;
COMMIT;

START TRANSACTION;
    UPDATE `subscriptions`
    SET `sb_is_active` =
        CASE
            WHEN `sb_is_active` = 'Y' THEN 'N'
            WHEN `sb_is_active` = 'N' THEN 'Y'
        END;
COMMIT;

-- 4. Write queries that, if executed in parallel, would provide the following effect:
--      a. the first request should count the number of books issued and returned to the library;
--      b. the second query should invert the values of the "sb_is_active" field of the "subscriptions" table 
--         from "Y" to "N" and vice versa for readers with odd IDs, then pause for ten seconds and undo the change 
--         (cancel the transaction)
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
    SELECT `sb_subscriber` AS `subscriber`,
        (
            SELECT COUNT(`sb_book`)
            FROM `subscriptions`
            WHERE `subscriber` = `sb_subscriber`
        ) AS `issued`,
        (
            SELECT COUNT(`sb_book`)
            FROM `subscriptions`
            WHERE `subscriber` = `sb_subscriber` AND
                `sb_is_active` = 'N'
        ) AS `returned`
    FROM `subscriptions`
    GROUP BY `sb_subscriber`;
COMMIT;

START TRANSACTION;
    UPDATE `subscriptions`
    SET `sb_is_active` =
        CASE
            WHEN `sb_is_active` = 'Y' THEN 'N'
            WHEN `sb_is_active` = 'N' THEN 'Y'
        END
    WHERE MOD(`sb_subscriber`, 2) = 1;
    SELECT SLEEP(10);
COMMIT;

-- 8. Create a stored procedure that counts the number of records in the specified table in such a way that it returns 
-- the most correct data, even if you have to sacrifice performance to achieve this result
DROP PROCEDURE IF EXISTS `COUNT_ROWS`;

DELIMITER $$

CREATE PROCEDURE `COUNT_ROWS`(IN `table_name` VARCHAR(150),
							  OUT `rows_in_table` INT)
BEGIN
	SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    START TRANSACTION;
		SET @count_query =
			CONCAT('SELECT COUNT(1) INTO @rows_found
			FROM ', table_name);
			
		PREPARE `count_stmt` FROM @count_query;
		EXECUTE `count_stmt`;
		DEALLOCATE PREPARE `count_stmt`;
		
		SET `rows_in_table` := @rows_found;
    COMMIT;
END;

$$

DELIMITER ;

-- check the result

CALL COUNT_ROWS('subscriptions', @rows_in_table);
SELECT @rows_in_table;