CREATE DATABASE university;

DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS groups;

CREATE TABLE groups (
	id serial PRIMARY KEY,
	name VARCHAR NOT NULL,
	entry_year SMALLINT NOT NULL
);

CREATE TABLE students (
	id serial PRIMARY KEY,
	name VARCHAR NOT NULL,
	surname VARCHAR NOT NULL,
	birthday DATE,
	group_id INTEGER REFERENCES groups(id)
);