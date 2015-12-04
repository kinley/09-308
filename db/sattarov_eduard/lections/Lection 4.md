#Lection 4

----------
... как это все перевести в код?

####Создать базу
- CREATE DATABASE *db_name*
- CREATE TABLE *table_name*
- {*col_name* *data_type* *column_contains (ограничения) | table contains*} [..., ...];
####Пример
- CREATE TABLE Students ( "имя" - с регистром, "students" резервирует также STUDENTS
- id INTEGER,
- name VARCHAR,
- birthday DATE);

----------
Задание: create.sql

----------
####Числовые типы
- INTEGER
- BIGINT
- DOUBLE PRECISION
- NUMERIC
- REAL
- SMALLINT (пример: типы пар)

----------

- SERIAL
- BIG SERIAL

----------

- BIT [(n)]
- BOOLEAN [(n)]
- VARCHAR [(n)]
- TEXT

----------

- DATE
- TIME
- TIMESTAM

----------

- SELECT [ALL/DISTINCT]
- * / expression [AS output_name [, ...]]
- FROM tblName[,...]
- WHERE condition
- GROUP BY expression
- HAVING condition
- ORDER BY expression ASC/DESC
- LIMIT [count/all]
- OFFSET start ROWS

----------

- SELECT COUNT(*) as studCount
- FROM students
- GROUP BY group_id;