CREATE TABLE films (
  id                  SERIAL PRIMARY KEY,
  name                VARCHAR      NOT NULL UNIQUE,
  origin              original     NOT NULL,
  costs_per_day       unsigned_int NOT NULL,
  cinema_count        unsigned_int NOT NULL DEFAULT 0,
  has_festival_prizes BOOL         NOT NULL,
  duration            unsigned_int NOT NULL
);

CREATE TABLE cinemas (
  id                   SERIAL PRIMARY KEY,
  name                 VARCHAR      NOT NULL UNIQUE,
  seat_count           unsigned_int NOT NULL,
  director_name        VARCHAR      NOT NULL,
  opened               DATE         NOT NULL,
  seat_first_category  unsigned_int NOT NULL,
  seat_second_category unsigned_int NOT NULL,
  seat_third_category  unsigned_int NOT NULL,

  CHECK (seat_count = seat_first_category + seat_second_category + seat_third_category)
);

CREATE TABLE distributions (
  id                         SERIAL PRIMARY KEY,
  cinema_id                  INT REFERENCES cinemas (id) ON DELETE SET NULL ON UPDATE CASCADE,
  film_id                    INT REFERENCES films (id) ON DELETE SET NULL ON UPDATE CASCADE,
  started                    DATE         NOT NULL,
  finished                   DATE         NOT NULL,
  seat_first_category_price  unsigned_int NOT NULL,
  seat_second_category_price unsigned_int NOT NULL,
  seat_third_category_price  unsigned_int NOT NULL,
  fee                        unsigned_int NOT NULL,

  UNIQUE (cinema_id, film_id),
  CHECK (finished >= started)
);

-- DROP VIEW distributions_view
CREATE VIEW distributions_view AS
  SELECT
    d.id,
    c.name               AS cinema_name,
    f.name               AS film_name,
    started,
    finished,
    seat_first_category_price,
    seat_second_category_price,
    seat_third_category_price,
    fee,
    (finished - started) AS duration
  FROM
    distributions d
    JOIN cinemas c ON d.cinema_id = c.id
    JOIN films f ON d.film_id = f.id;
