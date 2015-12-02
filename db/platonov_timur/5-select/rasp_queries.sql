-- пример Common Table Expression
WITH groups_with_studenst AS (
  SELECT
    groups.id,
    count(*) AS student_count
  FROM groups
    JOIN students ON groups.id = students.group_id
  GROUP BY 1
)
SELECT
  id
FROM groups_with_studenst
WHERE student_count > 1;

-- 9. Выбрать преподавателей, у который ведет не более 4 предметов
SELECT
  p.id,
  p.name,
  p.surname
FROM professors p
  JOIN lessons l ON p.id = l.professor_id
GROUP BY p.id
HAVING count(p.id) <= 4;

-- 10. Выбрать всех преподавателей для конкретной группы
SELECT
  p.name,
  p.surname
FROM professors p
  JOIN lessons l ON p.id = l.professor_id WHERE group_id = 1
GROUP BY p.id;

-- 11. Выбрать группы, у которых не ведет конкретный преподаватель
SELECT
  g.name
FROM groups g
EXCEPT
SELECT
  g.name
FROM groups g
  JOIN lessons l ON g.id = l.group_id WHERE professor_id = 203;

-- 12. Вывести количество дисциплин у каждой группы
SELECT
  g.name,
  count(DISTINCT l.subject_id)
FROM groups g
  LEFT JOIN lessons l ON g.id = l.group_id
GROUP BY g.id;

-- 13. Все преподаватели конкретного института, ведущие один и тот же предмет.
SELECT
  l2.subject_id,
  l2.professor_id
FROM
  lessons l1 JOIN lessons l2 ON l1.subject_id = l2.subject_id
GROUP BY 1, 2;

-- 14. Выбрать преподавателей, которые ведут у всех групп.
WITH prof_groups AS (
    SELECT
      professor_id,
      group_id
    FROM
      lessons l
    GROUP BY 1, group_id
),
    groups_count AS (
      SELECT
        count(*)
      FROM
        groups
)
SELECT
  professor_id
FROM
  prof_groups
GROUP BY 1
HAVING count(*) = (SELECT * FROM groups_count)
