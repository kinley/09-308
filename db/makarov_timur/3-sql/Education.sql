-- CREATE DATABASE Education;

CREATE TABLE Users (
	user_id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(50) NOT NULL,
	surname VARCHAR(50),
	email VARCHAR(50) NOT NULL,
	password VARCHAR(50) NOT NULL,
	program INT REFERENCES Programs(program_id)
);

CREATE TABLE Programs (
	program_id SERIAL PRIMARY KEY,
	course INT REFERENCES Courses(course_id),
	webinar INT REFERENCES Webinars(webinar_id)
);

CREATE TABLE Courses (
	course_id SERIAL PRIMARY KEY NOT NULL,
	lecturer INT REFERENCES Lecturers(lecturer_id) NOT NULL,
	duration INT NOT NULL
);

CREATE TABLE Lecturers (
	lecturer_id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	surname VARCHAR(50) NOT NULL
);

CREATE TABLE Webinars (
	webinar_id SERIAL PRIMARY KEY,
	duration INT NOT NULL,
	lecturer INT REFERENCES Lecturers(lecturer_id)
);

CREATE TABLE WebinarsToLecturers (
	webinar INT REFERENCES Webinars(webinar_id),
	lecturer INT REFERENCES Lecturers(lecturer_id)
);

CREATE TABLE CoursesToLecturers (
	course INT REFERENCES Courses(course_id),
	lecturer INT REFERENCES Lecturers(lecturer_id)
);