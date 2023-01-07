--
-- Create database
--CREATE DATABASE test_db;

-- Connect to database
--\connect test_db

-- Create table with dummy data
CREATE SEQUENCE seq;
 
CREATE TABLE bird (
   id bigint PRIMARY KEY DEFAULT nextval('seq'),
   wingspan real NOT NULL,
   beak_size double precision NOT NULL
);

CREATE TABLE bat (
   id bigint PRIMARY KEY DEFAULT nextval('seq'),
   wingspan numeric NOT NULL,
   body_temperature numeric NOT NULL
);

INSERT INTO bird (wingspan, beak_size)
SELECT 20 + random() * 5, 2 + random()
FROM generate_series(1, 1000000);

INSERT INTO bat (wingspan, body_temperature)
SELECT 15 + random() * 5, 40 + random() * 2
FROM generate_series(1, 1000000);
