/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES (1, 'Agumon', '2020-02-03', 0, '1', '10.23'), 
(2, 'Gabumon', '2018-11-15', 2, '1', ' 8'), 
(3, 'Pikachu', '2021-01-07', 1, '0', '15.04'), 
(4, 'Devimon', '2017-05-12', 5, '1','11' );

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES 
(5, 'Charmander', '2020-02-08', 0, '0', '-11.00'), 
(6, 'Plantmon', '2021-11-15', 2, '1', '-5.7'), 
(7, 'Squirtle', '1993-04-02', 3, '0', '-12.13'), 
(8, 'Angemon', '2005-06-12', 1, '1','-45.00'),
(9, 'Boarmon', '2017-06-7', 7, '1','20.40'),
(10, 'Blossom', '1998-10-13', 3, '1','17.00'),
(11, 'Ditto', ' 2022-05-14', 4, '1','22.00');


INSERT INTO owners (full_name, age) 
VALUES 
('Sam Smith', 34), 
('Jennifer Orwell', 19), 
('Bob', 45), 
('Melody Pond', 77), 
('Dean Winchester', 14), 
('Jodie Whittaker', 38)
;

INSERT INTO species (name) 
VALUES 
('Pokemon'), 
('Digimon');

UPDATE animals 
SET species_id = CASE WHEN NAME LIKE '%mon' 
THEN (SELECT ID FROM species WHERE NAME = 'Digimon') 
ELSE (SELECT ID FROM species WHERE NAME = 'Pokemon') 
END;

UPDATE animals
SET owner_id = (
  CASE
    WHEN name = 'Agumon' 
       THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
    WHEN name IN ('Gabumon', 'Pikachu') 
      THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
    WHEN name IN ('Devimon', 'Plantmon') 
      THEN (SELECT id FROM owners WHERE full_name = 'Bob')
    WHEN name IN ('Charmander', 'Squirtle', 'Blossom') 
      THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
    WHEN name IN ('Angemon', 'Boarmon') 
      THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
  END
);