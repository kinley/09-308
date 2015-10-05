-- База данных для диспетчера аэропорта (составление рейсов)
-- CREATE DATABASE airport;

CREATE TABLE cities (
  id   SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE airports (
  id      SERIAL PRIMARY KEY,
  name    VARCHAR(10) NOT NULL UNIQUE, -- 'SVO' - Шереметьево и т.д.
  city_id INT         NOT NULL REFERENCES cities (id)
);

CREATE TABLE plane_manufacturers (
  id   SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE planes (
  id              SERIAL PRIMARY KEY,
  manufacturer_id INT         NOT NULL REFERENCES plane_manufacturers (id),
  model           VARCHAR(25) NOT NULL,
  seat_count      INT         NOT NULL,
  board_number    VARCHAR(25) NOT NULL,

  UNIQUE (board_number),
  CHECK (seat_count > 0)
);

CREATE TABLE persons (
  id       SERIAL PRIMARY KEY,
  name     VARCHAR(50) NOT NULL,
  surname  VARCHAR(50) DEFAULT '',
  birthday DATE, -- '1999-01-08' - 8 января

  CHECK (birthday >= '1900-01-01')
);

CREATE TABLE employees (
  id        SERIAL PRIMARY KEY,
  person_id INT NOT NULL UNIQUE REFERENCES persons (id)
);

CREATE TABLE flight_crews (
  id               SERIAL PRIMARY KEY,
  pilot_id         INT NOT NULL REFERENCES employees (id),
  second_pilot_id  INT REFERENCES employees (id),
  chief_steward_id INT REFERENCES employees (id)
);

CREATE TABLE passengers (
  id        SERIAL PRIMARY KEY,
  person_id INT         NOT NULL UNIQUE REFERENCES persons (id),
  passport  VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE flights (
  id                   SERIAL PRIMARY KEY,
  plane_id             INT         NOT NULL REFERENCES planes (id),
  flight_crew_id       INT         NOT NULL REFERENCES flight_crews (id),
  departure_airport_id INT         NOT NULL REFERENCES airports (id),
  arrival_airport_id   INT         NOT NULL REFERENCES airports (id),
  departure_time       TIMESTAMPTZ NOT NULL, -- TIMESTAMPTZ == TIMESTAMP WITH TIME ZONE
  arrival_time         TIMESTAMPTZ NOT NULL, -- '2004-10-19 10:23:54+00' - дата + время по UTC +00 часов

  CHECK (departure_airport_id <> arrival_airport_id),
  CHECK (departure_time < arrival_time)
);

CREATE TABLE flight_passengers (
  id           SERIAL PRIMARY KEY,
  passenger_id INT NOT NULL REFERENCES passengers (id),
  flight_id    INT NOT NULL REFERENCES flights (id),

  UNIQUE (passenger_id, flight_id)
);
