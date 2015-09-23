-- База данных для диспетчера аэропорта (составление рейсов)

CREATE DATABASE Airport;

CREATE TABLE IF NOT EXISTS cities (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS airports (
	id SERIAL PRIMARY KEY,
	name VARCHAR(10) NOT NULL, -- 'SVO' - Шереметьево и т.д.
	city_id INTEGER REFERENCES cities (id)
);

CREATE TABLE IF NOT EXISTS planes (
	id SERIAL PRIMARY KEY,
	model VARCHAR(25) NOT NULL,
	manufacturer VARCHAR(25) NOT NULL,
	seat_count INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS employees (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	surname VARCHAR(50) NOT NULL,
	birthday DATE NOT NULL -- '1999-01-08' - 8 января
);

CREATE TABLE IF NOT EXISTS flight_crews (
	id SERIAL PRIMARY KEY,
	pilot_id INTEGER REFERENCES employees (id),
	second_pilot_id INTEGER REFERENCES employees (id),
	chief_steward_id INTEGER REFERENCES employees (id)
);

CREATE TABLE IF NOT EXISTS passengers (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	surname VARCHAR(50) NOT NULL,
	birthday DATE NOT NULL,
	passport VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS flights (
	id SERIAL PRIMARY KEY,
	plane_id INTEGER REFERENCES planes (id),
	flight_crew_id INTEGER REFERENCES flight_crews (id),
	departure_airport_id INTEGER REFERENCES airports (id),
	arrival_airport_id INTEGER REFERENCES airports (id),
	departure_time TIMESTAMPTZ NOT NULL, -- TIMESTAMPTZ == TIMESTAMP WITH TIME ZONE '2004-10-19 10:23:54+00' -- дата + время по UTC +00 часов
	arrival_time TIMESTAMPTZ NOT NULL
);

CREATE TABLE IF NOT EXISTS flight_passengers (
	id SERIAL PRIMARY KEY,
	passenger_id INTEGER REFERENCES passengers (id),
	flight_id INTEGER REFERENCES flights (id)
);
