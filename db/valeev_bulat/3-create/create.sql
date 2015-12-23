DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS abonements;
DROP TABLE IF EXISTS clientMessage;
DROP TABLE IF EXISTS visits;
DROP TABLE IF EXISTS trainers;
DROP TABLE IF EXISTS trainers_table;

DROP TYPE IF EXISTS TGENDER;
DROP TYPE IF EXISTS TWEEKDAY;

CREATE TYPE TGENDER AS ENUM ('м', 'ж');
CREATE TYPE TWEEKDAY AS ENUM ('ПН','ВТ','СР','ЧТ','ПТ','СБ','ВС');


-- БД для фитнес-центра

CREATE TABLE clients (
	id SERIAL PRIMARY KEY,
	full_name VARCHAR(80) NOT NULL,
	birthday DATE NOT NULL,
	gender TGENDER NOT NULL,
	add_date timestamp NOT NULL
);

CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	message TEXT NOT NULL,
	add_date timestamp NOT NULL
);

CREATE TABLE abonements (
	id SERIAL PRIMARY KEY,
	balance INTEGER NOT NULL,
	add_date TIME NOT NULL,
	client_id INTEGER REFERENCES clients (id) ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE clientMessage (
	reading BOOLEAN,
	client_id INTEGER REFERENCES clients (id), 
	message_id INTEGER REFERENCES messages (id),
	UNIQUE (client_id, message_id)
);

CREATE TABLE visits (
	id SERIAL PRIMARY KEY,
	visit_from timestamp NOT NULL,
	visit_to timestamp NOT NULL,
	abonement_id INTEGER REFERENCES abonements (id),
	CHECK (visit_from < visit_to)
);

CREATE TABLE trainers (
	id SERIAL PRIMARY KEY,
	full_name VARCHAR(80) NOT NULL,
	price INTEGER NOT NULL	
);
CREATE TABLE trainers_table (
	day TWEEKDAY NOT NULL,
	time_from TIME,
	time_to TIME,
	trainer_id INTEGER REFERENCES trainers (id),
  CHECK (time_from < time_to),
  UNIQUE (day, trainer_id)
);