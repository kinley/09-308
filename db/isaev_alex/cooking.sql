CREATE TABLE "Untitled" (

) WITH (
  OIDS=FALSE
);



CREATE TABLE "recipes" (
	"id" integer(100) NOT NULL DEFAULT 'NUll',
	"title" TEXT(1000) NOT NULL,
	"description" TEXT(10000) NOT NULL,
	CONSTRAINT recipes_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Ingredients" (
	"id" integer(100) NOT NULL,
	"name" TEXT(100) NOT NULL,
	"recipe_id" integer(100) NOT NULL,
	CONSTRAINT Ingredients_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "directions" (
	"id" integer(100) NOT NULL,
	"step" TEXT(1000) NOT NULL,
	"recipe_id" integer(100) NOT NULL,
	CONSTRAINT directions_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);





ALTER TABLE "Ingredients" ADD CONSTRAINT "Ingredients_fk0" FOREIGN KEY (recipe_id) REFERENCES recipes(id);

ALTER TABLE "directions" ADD CONSTRAINT "directions_fk0" FOREIGN KEY (recipe_id) REFERENCES recipes(id);
