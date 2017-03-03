
CREATE TABLE readers (
	id_reader_ticket VARCHAR(20) PRIMARY KEY,
	full_name VARCHAR(50),
	birth_date DATE,
	phone_num VARCHAR(11),
	adress VARCHAR(60),
	email VARCHAR(30)
);

CREATE TABLE typelist (
	id_type VARCHAR(30) PRIMARY KEY,
	publ_name VARCHAR(50),
	quantity INT
);

CREATE TABLE publications (
	id_publication VARCHAR(40) PRIMARY KEY,
	id_type VARCHAR(30) REFERENCES typelist(id_type)
);


CREATE TABLE book_tracker (
	id_reader VARCHAR(20) REFERENCES readers(id_reader_ticket),
	id_publication VARCHAR(40) REFERENCES publications(id_publication),
	date_of_taking DATE,
	return_date DATE,
	returned BOOLEAN
);