-- в чем ошибка в данном запросе?
SELECT student.name
FROM students s;

-- в чем ошибка?
SELECT surname, name as group_name
FROM students, groups;

-- каков будет результат? что не так? как исправить?
SELECT surname, s.name, g.name as group_name
FROM students s, groups g;

-- данный запрос выведет не все группы. Почему? Какие не выведет? Как исправить?
SELECT g.name as group_name, COUNT(*) as students_count
FROM students s JOIN groups g ON g.id = s.group_id
GROUP BY g.id;

-- в этом запросе так же будет ошибка. Какая? Почему? Как исправить?
SELECT g.name as group_name, COUNT(*) as students_count
FROM groups g LEFT JOIN students s ON g.id = s.group_id
GROUP BY g.id;

-- в чем ошибка? почему?
SELECT g.name as group_name, COUNT(s.id) as students_count
FROM groups g LEFT JOIN students s ON g.id = s.group_id
GROUP BY g.id
HAVING students_count > 2
ORDER BY students_count DESC