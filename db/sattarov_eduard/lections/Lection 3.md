#Lection 3

----------
##Диаграммы
MySQL Workbench
Рисует ER-диаграммы и пишет сразу код. Адекватный и бесплатный инструмент.

----------
##Связи
- <->
- <->>
- <<->>
####Группа(родительская)
- id_group
- name
####Студенты(дочерняя)
- id_stud
- name
- id_group
####Как организовать связь?
- построить предложение
- определить иерархию
- добавить ключ в дочернюю

----------

###Связь 1-1
####Таблица student_ticket
- id_ticket
- id_stud

----------
- has one
- has many
- -belongs to

----------
- student has one student_ticket
- group has many students
- student belongs to group
####Использование 1-1:
- Таблица инфы о студентах (name surname group)
- Таблица лог пасса студентов
----------
###Cвязь N-N
####Teachers<<->>Subjects
- Проблема N-N - как это будет выглядеть в таблице.
- Декомпозировать(разобрать), чтобы в таблице не было N-N
- Получится 2 связи 1-N + еще 1 таблица
####Таблица Teachers(Дочерняя к Subj2Teachers)
- id_teach
- name
- surname
####Таблица Subjects(Дочерняя к Subj2Teachers)
- id_subj
- name
####Таблица Subj2Teachers(Родительская)
- id
- id_teach(<->> teachers)
- id_subj(<->> subjects)

----------
Резюмируя, база данных - это мн-во организованных структурированных данных. Выражается в таблицах и связях.

----------
##Sql
####DDL Data Definition language
- Create
- Drop
####DML Data Manipulation Language
- Select
- Insert
- Update
- Delete

----------
####Задание: SQL script cоздания своей базы данных.
- CREATE DATABASE *имя базы*
- CREATE TABLE Students
- id INTEGER PRIMARY KEY (в постгресе инт + инкремент = sequence)
- name VARCHAR(50)
- birthday DATE;
####По образу создать свою базу.

----------
Выделенная память для столбца определена и не изменяется. Потому что так удобнее. Для лучшей производительности нужно заранее спроектировать.