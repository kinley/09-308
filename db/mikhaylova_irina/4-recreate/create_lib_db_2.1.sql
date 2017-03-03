
CREATE TABLE readers (
	id_reader_ticket VARCHAR(20) PRIMARY KEY,
	full_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone_num VARCHAR(11),
	adress VARCHAR(60) DEFAULT "Kazan",
	email VARCHAR(30) 
);

CREATE TABLE typelist (
	id_type VARCHAR(30) PRIMARY KEY,
	publ_name VARCHAR(50) UNIQUE,
	quantity INT CONSTRAINT positive_quantity CHECK (quantity > 0)
);

CREATE TABLE publications (
	id_publication VARCHAR(40) PRIMARY KEY,
	id_type VARCHAR(30) REFERENCES typelist(id_type)
);


CREATE TABLE book_tracker (
	id_reader VARCHAR(20) REFERENCES readers(id_reader_ticket) ON DELETE RESTRICT ON UPDATE CASCADE,
	id_publication VARCHAR(40) REFERENCES publications(id_publication) ON DELETE RESTRICT ON UPDATE CASCADE,
	date_of_taking DATE NOT NULL,
	return_date DATE CONSTRAINT wrongdate CHECK (return_date = NOT NULL AND return_date < date_of_taking),
	returned BOOLEAN,
	CONSTRAINT wrong_line CHECK (id_reader = NOT NULL AND id_publication = NOT NULL),
	UNIQUE(id_reader, id_book, date_of_taking)
);