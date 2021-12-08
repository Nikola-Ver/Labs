-- 1. Show a list of books with more than one author
WITH `more_than_one_author`
	AS (
		SELECT `b_id`, COUNT(*) AS `count`
		FROM `m2m_books_authors`
		GROUP BY `b_id`
		HAVING `count` > 1
	)
    
SELECT `b_id` AS `id`, `b_name` AS `name`
FROM `books` 
JOIN `more_than_one_author` USING(`b_id`);

-- 2. Show a list of books belonging to exactly one genre
WITH `belong_to_one_genre`
	AS (
		SELECT `b_id`, COUNT(*) AS `count`
		FROM `m2m_books_genres`
		GROUP BY `b_id`
		HAVING `count` = 1
	)
    
SELECT `b_id` AS `id`, `b_name` AS `name`
FROM `books`
JOIN `belong_to_one_genre` USING(`b_id`);

-- 3. Show all books with their genres (duplicate book titles are not allowed)
SELECT `b_id`, `b_name`,
	   GROUP_CONCAT(`g_name` SEPARATOR ', ') AS `g_name`
FROM `books`
JOIN `m2m_books_genres` USING(`b_id`)
JOIN `genres` USING(`g_id`)
GROUP BY `b_id`;

-- 16. Show all readers who have not returned books, and the number of unreturned books for each such reader
WITH `unreturned_books`
	AS (
		SELECT * 
		FROM `subscriptions`
		WHERE `sb_is_active` = 'Y'
	)
    
SELECT `s_id` AS `id`, `s_name` AS `name`, COUNT(*) AS `count`
FROM `subscribers`
JOIN `unreturned_books` ON `sb_subscriber` = `s_id`
GROUP BY `s_id`;

-- 17. Show the readability of genres, i.e. all genres and the number of times that the books of these genres have been taken by the readers
SELECT `g_id` AS `id`, `g_name` AS `name`, COUNT(*) AS `count`
FROM `genres`
JOIN `m2m_books_genres` USING(`g_id`)
GROUP BY `g_id`;