/*Queries that provide answers to the questions from all projects.*/

-- Query animals Table and Use Transactions
SELECT * FROM animals WHERE NAME LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered = '1' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;
SELECT * FROM animals WHERE neutered = '1';
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.40 AND 17.30;

BEGIN;
UPDATE animals
SET species = 'unspecified';
COMMIT;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
COMMIT;

BEGIN;
UPDATE animals
SET species = 'pokemon'
WHERE species = 'unspecified';
COMMIT;

BEGIN;
DELETE FROM animals
COMMIT;
  
BEGIN;
DELETE FROM animals
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth>'2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg=weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals 
SET weight_kg=weight_kg * -1
WHERE weight_kg<0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts=0;
SELECT AVG(weight_kg) FROM animals;

SELECT neutered, COUNT(*) AS escape_count
FROM animals
GROUP BY neutered
ORDER BY escape_count DESC
LIMIT 1;

SELECT species, 
MIN(weight_kg), 
MAX(weight_kg) 
FROM animals 
GROUP BY species;

SELECT species, 
AVG(escape_attempts) 
FROM animals 
WHERE date_of_birth 
BETWEEN '1990-01-01' AND '2000-12-31' 
GROUP BY species;

-- Query animals & species Table (Primary Key & Foreign Key)
SELECT animals.name
FROM animals 
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(*) AS animal_count
FROM species
JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(*) AS animal_count
FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;

-- Query Multiple Tables;
SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animals_id
JOIN vets vt ON v.vets_id = vt.id
WHERE vt.name = 'William Tatcher'
ORDER BY v.visiting_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT v.animals_id) AS animal_count
FROM visits v
JOIN vets vt ON v.vets_id = vt.id
WHERE vt.name = 'Stephanie Mendez';

SELECT vt.name, s.name
FROM vets vt
LEFT JOIN specializations sp ON vt.id = sp.vets_id
LEFT JOIN species s ON sp.species_id = s.id;

SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animals_id
JOIN vets vt ON v.vets_id = vt.id
WHERE vt.name = 'Stephanie Mendez'
  AND v.visiting_date >= '2020-04-01'
  AND v.visiting_date <= '2020-08-30';

SELECT a.name, COUNT(*) AS visit_count
FROM animals a
JOIN visits v ON a.id = v.animals_id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;

SELECT a.name, MIN(v.visiting_date) AS first_visit
FROM animals a
JOIN visits v ON a.id = v.animals_id
JOIN vets vt ON v.vets_id = vt.id
WHERE vt.name = 'Maisy Smith'
GROUP BY a.name
ORDER BY first_visit ASC
LIMIT 1;


SELECT a.name AS animal_name, v.visiting_date, vt.name AS vet_name, vt.age AS vet_age
FROM animals a
JOIN visits v ON a.id = v.animals_id
JOIN vets vt ON v.vets_id = vt.id
WHERE v.visiting_date = (
    SELECT MAX(visiting_date)
    FROM visits
)
LIMIT 1;


SELECT COUNT(*) AS num_visits
FROM visits
JOIN animals ON visits.animals_id = animals.id
JOIN vets ON visits.vets_id = vets.id
JOIN specializations ON vets.id = specializations.vets_id
JOIN species ON specializations.species_id = species.id
WHERE species.id <> animals.species_id;


SELECT s.name AS specialty
FROM (
  SELECT a.species_id, COUNT(*) AS num_visits
  FROM visits v
  JOIN animals a ON v.animals_id = a.id
  JOIN vets vt ON v.vets_id = vt.id
  WHERE vt.name = 'Maisy Smith'
  GROUP BY a.species_id
) AS visit_counts
JOIN species s ON visit_counts.species_id = s.id
ORDER BY visit_counts.num_visits DESC
LIMIT 1;
