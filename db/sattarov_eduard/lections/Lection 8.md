##Lection 8

----------

- Students
- Groups
- Professors
- Departments
- Subjects
- Lessons
- LessonsTime

----------

- WeekDays: Type (enum)
- WeekNo: 1, 2, 3 (чет/нечет/...)

----------

####Составить таблицу Распис
- Запись = день, Столбец = Группа

----------

Выбрать гр, где есть студенты, которым от 18 до 27 м.
####1)
- SELECT DISTINCT(g.name)
- FROM groups g INNER JOIN students s ON g.id = s.group_id
- WHERE s.gender = 'M' 
- 	AND date_part ('year', age(s.birthday))
- 	BETWEEN 18 AND 26;
####2)
- SELECT g.name
- FROM groups g INNER JOIN students s ON g.id = s.group_id
- WHERE s.gender = 'M' 
- 	AND date_part ('year', age(s.birthday))
- 	BETWEEN 18 AND 26
- 	GROUP BY groupid;
####3)
- SELECT name
- FROM groups g
- WHERE g.id IN (
-	SELECT s.id
-	FROM students
-	WHERE ...);
####На реляционной алгебре:
- П (name) б (18 <= age < 27 ^ sex = 'M') Groups c Students

----------

- SELECT DISTINCT(g.name)
- FROM groups g INNER JOIN students s ON g.id = s.group_id
- WHERE s.gender = 'M' 
- 	AND date_part ('year', age(s.birthday))
- 	BETWEEN 18 AND 26;

----------


Отобрать студентов, у которых МТС

####1)
- SELECT s.name
- FROM students s
- WHERE SUBSTRING(s.phonenumber, 0, 4) = '7917'
-	OR SUBSTRING(s.phonenumber, 0, 4) = '7919';
####2)
- SELECT s.name
- FROM students s
- WHERE phone LIKE '7917%';
####3)
- phone SIMILAR TO '917%|916%|987%'
####Реляционная алгебра:
- П (name) б ()...