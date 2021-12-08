-- 1. Add information about three new readers to the database: "Orlov O.O.", "Sokolov S.S.", "Berkutov B.B."
INSERT INTO `subscribers` (`s_name`)  VALUE('Орлов О.О.');
INSERT INTO `subscribers` (`s_name`)  VALUE('Соколов С.С.');
INSERT INTO `subscribers` (`s_name`)  VALUE('Беркутов Б.Б.');

-- 4. Mark all results with IDs ≤50 as returned
UPDATE `subscriptions`
SET `sb_is_active` = 'N'
WHERE `sb_id` <= 50;

-- 5. For all issues made before January 1, 2012, reduce the value of the issue day by 3
UPDATE `subscriptions`
SET `sb_finish` = DATE_SUB(`sb_finish`, INTERVAL 3 DAY)
WHERE `sb_start` < '2012-01-01';

-- 6. Mark as not returned all results received by the reader with ID 2
UPDATE `subscriptions`
SET `sb_is_active` = 'N'
WHERE `sb_subscriber` = 2;

-- 7. Delete information about all issuances to readers of the book with ID 1
DELETE FROM `subscriptions`
WHERE `sb_book` = 1;