##Lection 10

----------

####Транзакция

Набор команд между BEGIN и COMMIT

- BEGIN;
- UPDATE ...;
- INSERT ...;
- COMMIT;


----------


- Атомарность
- Согласованность
- Изолированность
- 4

----------

- T1: (lost update)
- UPDATE tbl1 SET f2 = f2 + 20 WHERE f1 > 1;
- T2:
- UPDATE tbl1 SET f2 = f2 + 25 WHERE f1 = 1;

----------

- T1: (dirty read)
- UPDATE tbl1 SET f2 = f2 + 1 WHERE f1 = 1;
- ROLLBACK WORK;
- T2:
- SELECT f2 FROM tbl1 WHERE f1 = 1;
- SELECT...;

----------

- T1: nonrepeatable reading
- UPDATE...;
- COMMIT;
- T2:
- SELECT;
- SELECT;

----------

- phantom reading = nonrepeatable
- nonrepeatable (наложить ограничение на 1 строку)
- phantom reading 

----------

