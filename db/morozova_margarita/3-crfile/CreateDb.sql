/*CREATE DATABASE cruises
	WITH OWNER = rita
			 ENCODING = 'UTF8'
			 TABLESPACE = pg_default
			 LC_COLLATE = 'ru_RU.UTF-8'
			 LC_CTYPE = 'ru_RU.UTF-8'
			 CONNECTION LIMIT = -1;
*/

CREATE TABLE cities
(
	name character(1) NOT NULL,
	id serial NOT NULL primary key
)
WITH (
	OIDS=FALSE
);

CREATE TABLE owners
(
	id serial NOT NULL primary key,
	name character(1) NOT NULL,
	info character(1),
	phone character(1) NOT NULL
)
WITH (
	OIDS=FALSE
);

CREATE TABLE cruiseships
(
	id serial NOT NULL primary key,
	name character(1) NOT NULL,
	owner_id integer references owners(id)
)
WITH (
	OIDS=FALSE
);

CREATE TABLE cabins
(
	id serial NOT NULL primary key,
	"number" character(1) NOT NULL,
	"class" character(1) NOT NULL,
	cruiseship_id integer references cruiseships(id)
)
WITH (
	OIDS=FALSE
);

CREATE TABLE moves
(
	id serial NOT NULL primary key,
	cruiseship_id integer NOT NULL references cruiseships(id),
	"date" date NOT NULL,
	city_id integer NOT NULL references cities(id)
)
WITH (
	OIDS=FALSE
);

CREATE TABLE routes
(
	id serial NOT NULL primary key,
	cruiseship_id integer NOT NULL references cruiseships(id),
	start_move_id integer NOT NULL references moves(id),
	end_move_id integer NOT NULL references moves(id)
)
WITH (
	OIDS=FALSE
);

CREATE TABLE prices
(
	id serial NOT NULL primary key,
	cabin_id integer NOT NULL references cabins(id),
	route_id integer NOT NULL references routes(id),
	price integer
)
WITH (
	OIDS=FALSE
);

ALTER TABLE cabins
	OWNER TO rita;
ALTER TABLE cities
	OWNER TO rita;
ALTER TABLE cruiseships
	OWNER TO rita;
ALTER TABLE moves
	OWNER TO rita;
ALTER TABLE owners
	OWNER TO rita;
ALTER TABLE prices
	OWNER TO rita;
ALTER TABLE routes
	OWNER TO rita;
