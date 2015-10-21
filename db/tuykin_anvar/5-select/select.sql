/** 1 **/
-- README: some magic with ordering on OS X:
-- http://evtuhovich.ru/blog/2012/07/14/collate-osx-postgres/
SELECT surname, name
FROM students
ORDER BY surname, name;

/** 2:v1 **/
SELECT surname, name, (('today' - birthday)/365) as age
FROM students
ORDER BY surname, name;

/** 2:v2 **/
SELECT surname, name, date_part('year', age(birthday)) as age
FROM students
ORDER BY surname, name;

/** 3:v1 **/
SELECT surname, s.name, g.name as group_name
FROM students s, groups g
WHERE g.id = s.group_id;

/** 3:v2 **/
SELECT surname, s.name, g.name as group_name
FROM students s JOIN groups g ON g.id = s.group_id;

/** 4 **/
SELECT g.name as group_name, COUNT(s.id) as students_count
FROM groups g LEFT JOIN students s ON g.id = s.group_id
GROUP BY g.id;

/** 5 **/
SELECT g.name as group_name, COUNT(s.id) as students_count
FROM groups g LEFT JOIN students s ON g.id = s.group_id
GROUP BY g.id
HAVING COUNT(s.id) >= 2
ORDER BY students_count DESC