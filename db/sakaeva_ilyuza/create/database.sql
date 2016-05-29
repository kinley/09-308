CREATE DATABASE film_distributionMaster
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'ru_RU.UTF-8'
       LC_CTYPE = 'ru_RU.UTF-8'
       CONNECTION LIMIT = -1;

CREATE DOMAIN unsigned_int AS INT
CHECK (
  VALUE >= 0
);

CREATE TYPE original AS ENUM ('foreign', 'local');
