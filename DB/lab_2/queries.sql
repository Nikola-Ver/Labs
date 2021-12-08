-- 1. Show all information about the authors
SELECT * FROM `authors`;

-- 2. Show all information about genres
SELECT * FROM `genres`;

-- 9. Show the list of authors in reverse alphabetical order
SELECT `a_id` AS `id`, `a_name` AS `name` FROM `authors` ORDER BY `a_name` DESC;

-- 12. Show the identifier of one (any) reader who has borrowed the most books from the library
WITH `top_1_subscriptions`
	AS (
		SELECT `sb_subscriber`, COUNT(`sb_subscriber`) AS `count`
		FROM `subscriptions`
		GROUP BY `sb_subscriber`
        ORDER BY COUNT(`count`) DESC LIMIT 1
	)

SELECT `sb_subscriber`
FROM `top_1_subscriptions`;

-- 15. Show how many copies of books are in the library on average
SELECT AVG(`b_quantity`) AS `avg_copies` 
FROM `books`;