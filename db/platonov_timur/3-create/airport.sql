-- База данных для диспетчера аэропорта (составление рейсов)
-- CREATE DATABASE airport;

CREATE TABLE cities (
  id   SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE
);

CREATE TABLE airports (
  id        SERIAL PRIMARY KEY,
  iata_code CHAR(3) NOT NULL UNIQUE, -- 'SVO' - Шереметьево и т.д.
  city_id   INT     NOT NULL REFERENCES cities (id) ON UPDATE CASCADE
);

CREATE TABLE plane_manufacturers (
  id   SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE
);

CREATE TABLE planes (
  id              SERIAL PRIMARY KEY,
  manufacturer_id INT     NOT NULL REFERENCES plane_manufacturers (id) ON UPDATE CASCADE,
  model           VARCHAR NOT NULL,
  seat_count      INT     NOT NULL,
  board_number    VARCHAR NOT NULL,

  UNIQUE (board_number),
  CHECK (seat_count > 0)
);

CREATE TABLE persons (
  id       SERIAL PRIMARY KEY,
  name     VARCHAR NOT NULL,
  surname  VARCHAR DEFAULT '',
  birthday DATE, -- '1999-01-08' - 8 января

  CHECK (birthday >= '1900-01-01')
);

CREATE TABLE employees (
  id        SERIAL PRIMARY KEY,
  person_id INT NOT NULL UNIQUE REFERENCES persons (id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE flight_crews (
  id               SERIAL PRIMARY KEY,
  pilot_id         INT NOT NULL REFERENCES employees (id) ON UPDATE CASCADE,
  second_pilot_id  INT REFERENCES employees (id) ON UPDATE CASCADE,
  chief_steward_id INT REFERENCES employees (id) ON UPDATE CASCADE
);

CREATE TABLE passengers (
  id        SERIAL PRIMARY KEY,
  person_id INT     NOT NULL UNIQUE REFERENCES persons (id) ON UPDATE CASCADE ON DELETE RESTRICT,
  passport  VARCHAR NOT NULL UNIQUE
);

CREATE TABLE flights (
  id                   SERIAL PRIMARY KEY,
  plane_id             INT         NOT NULL REFERENCES planes (id) ON UPDATE CASCADE,
  flight_crew_id       INT         NOT NULL REFERENCES flight_crews (id) ON UPDATE CASCADE,
  departure_airport_id INT         NOT NULL REFERENCES airports (id) ON UPDATE CASCADE,
  arrival_airport_id   INT         NOT NULL REFERENCES airports (id) ON UPDATE CASCADE,
  departure_time       TIMESTAMPTZ NOT NULL, -- TIMESTAMPTZ == TIMESTAMP WITH TIME ZONE
  arrival_time         TIMESTAMPTZ NOT NULL, -- '2004-10-19 10:23:54+00' - дата + время по UTC +00 часов

  CHECK (departure_airport_id <> arrival_airport_id),
  CHECK (departure_time < arrival_time)
);

CREATE TABLE flight_passengers (
  id           SERIAL PRIMARY KEY,
  passenger_id INT NOT NULL REFERENCES passengers (id) ON UPDATE CASCADE,
  flight_id    INT NOT NULL REFERENCES flights (id) ON UPDATE CASCADE,

  UNIQUE (passenger_id, flight_id)
);
