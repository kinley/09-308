-- БД для фитнес-центра

CREATE DATABASE Fitnes;

CREATE TABLE IF NOT EXISTS clients (
	id SERIAL PRIMARY KEY,
	full_name VARCHAR(50) NOT NULL,
	birthday VARCHAR(50) NOT NULL,
	gender VARCHAR(50) NOT NULL,
	add_date timestamp NOT NULL
);

CREATE TABLE IF NOT EXISTS messages (
	id SERIAL PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	message TEXT NOT NULL,
	add_date timestamp NOT NULL
);

CREATE TABLE IF NOT EXISTS abonements (
	id SERIAL PRIMARY KEY,
	clock INTEGER NOT NULL,
	add_date TIME NOT NULL,
	client_id INTEGER REFERENCES clients (id)
);
CREATE TABLE IF NOT EXISTS clientsMessages (
	reading BOOLEAN,
	client_id INTEGER REFERENCES clients (id), 
	message_id INTEGER REFERENCES messages (id),
);

CREATE TABLE IF NOT EXISTS visits (
	id SERIAL PRIMARY KEY,
	visit_start TIME NOT NULL,
	visit_end TIME NOT NULL,
	abonement_id INTEGER REFERENCES abonements (id)
);

CREATE TABLE IF NOT EXISTS trainers (
	id SERIAL PRIMARY KEY,
	full_name VARCHAR(80) NOT NULL,
	price INTEGER NOT NULL,
	
);
CREATE TABLE IF NOT EXISTS trainers_table (
	id SERIAL PRIMARY KEY,
	day INTEGER NOT NULL,
	time_to TIME,
	time_start TIME,
	trainer_id INTEGER REFERENCES abonements (id)

);