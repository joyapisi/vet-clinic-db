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
    FOREIGN KEY (animals_id, vets_id)
);

-- Performance Audit

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, visiting_date) 
SELECT * FROM 
(SELECT id FROM animals) animal_ids, 
(SELECT id FROM vets) vets_ids, 
generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

ALTER TABLE animals ADD total_vet_visits INT;

-- Copy visit records of vet with id of 2 into new table called vets_id2_visit_records
SELECT * INTO vet_id2_visit_records
FROM visits
WHERE vet_id = 2;

-- create an index to sort owners’ email alphabetically
CREATE INDEX owners_email_asc ON owners(email ASC);
