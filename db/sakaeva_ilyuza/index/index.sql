CREATE UNIQUE INDEX id
  ON cinemas
  USING btree
  (id);
ALTER TABLE cinemas CLUSTER ON id;

CREATE INDEX idfilms
  ON films
  USING btree
  (id);


