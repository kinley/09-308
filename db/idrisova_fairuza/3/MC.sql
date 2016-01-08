CREATE TABLE creater (
  id                         SERIAL       PRIMARY KEY,
  name                       VARCHAR(70)  NOT NULL,
  login                      VARCHAR(70)  NOT NULL UNIQUE,
  score                      NUMERIC,
  telephone                  VARCHAR(13)  NOT NULL,
  email                      VARCHAR(30)  NOT NULL
);

CREATE TABLE lector (
  id                         SERIAL       PRIMARY KEY,
  name                       VARCHAR(70)  NOT NULL,
  login                      VARCHAR(70)  NOT NULL UNIQUE,
  password                   VARCHAR(30)  NOT NULL,
  score                      NUMERIC,
  telephone                  VARCHAR(13)  NOT NULL,
  email                      VARCHAR(30)  NOT NULL,
  rating                     INT          NOT NULL DEFAULT 0
);

CREATE TABLE master_class (
  id                         SERIAL       PRIMARY KEY,
  subject                    VARCHAR(70)  NOT NULL,
  creater_id                 INT          REFERENCES creater (id) ON DELETE SET NULL ON UPDATE CASCADE,
  lector_id                  INT          REFERENCES lector (id) ON DELETE SET NULL ON UPDATE CASCADE,
  started                    DATE         NOT NULL,
  finished                   DATE         NOT NULL,
  spend                      BOOL         NOT NULL DEFAULT FALSE,
  place                      VARCHAR(70)  NOT NULL,
  likes                      INT          NOT NULL DEFAULT 0,    
  price                      INT          NOT NULL DEFAULT 0, 
  CHECK (finished >= started),
  CHECK ( price >= 0)
);

CREATE TABLE person (
  id                         SERIAL       PRIMARY KEY,
  name                       VARCHAR(70)  NOT NULL,
  login                      VARCHAR(70)  NOT NULL UNIQUE,
  password                   VARCHAR(30)  NOT NULL,
  telephone                  VARCHAR(13)  NOT NULL,
  email                      VARCHAR(30)  NOT NULL
);

CREATE TABLE visit (
  master_class_id            INT          REFERENCES master_class (id) ON DELETE SET NULL ON UPDATE CASCADE,
  person_id                  INT          REFERENCES person (id) ON DELETE SET NULL ON UPDATE CASCADE,
  PRIMARY KEY (master_class_id, person_id)
);

CREATE TABLE comments_master_class (
  master_class_id            INT          REFERENCES master_class (id) ON DELETE SET NULL ON UPDATE CASCADE,
  person_id                  INT          REFERENCES person (id) ON DELETE SET NULL ON UPDATE CASCADE,
  PRIMARY KEY (master_class_id, person_id)
);













