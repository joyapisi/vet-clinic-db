/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id int PRIMARY KEY NOT NULL,
    name varchar(255) NOT NULL,
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);

ALTER TABLE animals ADD COLUMN species varchar(30);

CREATE TABLE owners (
    id serial PRIMARY KEY NOT NULL,
    full_name varchar(255) NOT NULL,
    age int
);

CREATE TABLE species (
	id serial PRIMARY KEY NOT NULL, 
	name varchar(255) NOT NULL
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id int
REFERENCES species(id); 

ALTER TABLE animals ADD COLUMN owner_id int
REFERENCES owners(id); 

-- Joining tables
CREATE TABLE vets (
    id SERIAL PRIMARY KEY NOT NULL, 
    name varchar(255) NOT NULL, 
    age int, 
    date_of_graduation date
    );

CREATE TABLE specializations (
    id SERIAL PRIMARY KEY NOT NULL, 
    vets_id int REFERENCES vets(id),
    species_id int REFERENCES species(id)
);

CREATE TABLE visits (
    id SERIAL PRIMARY KEY NOT NULL, 
    vets_id int REFERENCES vets(id),
    animals_id int REFERENCES animals(id),
    PRIMARY KEY (animals_id, vets_id)
);