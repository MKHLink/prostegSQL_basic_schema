CREATE TABLE location_table (
	id serial PRIMARY KEY,
	city VARCHAR(255),
	state VARCHAR(255),
	country VARCHAR(255)
);

CREATE TABLE person_table(
	id serial PRIMARY KEY,
	firstName VARCHAR(255),
	lastName VARCHAR(255),
	age INT,
	location_id integer REFERENCES location_table (id)
);

CREATE TABLE interest_table(
	id SERIAL PRIMARY KEY,
	title VARCHAR(225)
);

-- DROP TABLE person_interest;

CREATE TABLE person_interest(
	person_id integer REFERENCES person_table (id) ON DELETE CASCADE,
	interest_id integer REFERENCES interest_table(id) ON DELETE CASCADE
);

INSERT INTO location_table (city,state,country)
VALUES 
('Nashville','Tennessee','United States'),
('Memphis','Tennessee','United States'),
('Phoenix','Arizona','United States'),
('Denver','Colorado','United States');

-- SELECT * FROM location_table;

INSERT INTO person_table (firstName,lastName,age,location_id)
VALUES
('Chickie','Ourtic',21,1),
('Hilton','O"Hanley',37,1),
('Barbe','Purver',50,3),
('Reeta','Sammons',34,2),
('Abbott','Fisbburne',49,1),
('Winnie','Whines',19,4),
('Samantha','Leese',35,2),
('Edouard','Lorimer',29,1),
('Mattheus','Shaplin',27,3),
('Donnell','Corney',25,3),
('Wallis','Kauschke',28,3),
('Melva','Lanham',20,2),
('Amelina','McNirlan',22,4),
('Courtney','Holley',22,1),
('Sigismond','Vala',21,4),
('Jacquelynn','Halfacre',24,2),
('Alanna','Spino',25,3),
('Isa','Slight',32,1),
('Kakalina','Renne',26,3);

-- SELECT*FROM person_table;

INSERT INTO interest_table (title)
VALUES
('Programming'),
('Gaming'),
('Computers'),
('Music'),
('Movies'),
('Cooking'),
('Sport');

-- SELECT * FROM interest_table;

INSERT INTO person_interest (person_id,interest_id)
VALUES
(1,1),(1,2),(1,6),
(2,1),(2,7),(2,4),
(3,1),(3,3),(3,4),
(4,1),(4,2),(4,7),
(5,6),(5,3),(5,4),
(6,2),(6,7),
(7,1),(7,3),
(8,2),(8,4),
(9,5),(9,6),
(10,7),(10,5),
(11,1),(11,2),(11,5),
(12,1),(12,4),(12,5),
(13,2),(13,3),(13,7),
(14,2),(14,4),(14,6),
(15,1),(15,5),(15,7),
(16,2),(16,3),(16,4),
(17,1),(17,3),(17,5),(17,7),
(18,2),(18,4),(18,6),
(19,1),(19,2),(19,3),(19,4),(19,5),(19,6),(19,7);

-- SELECT * FROM person_interest;

UPDATE person_table SET age = age +1
WHERE (firstName = 'Chickie' AND lastName = 'Ourtic');

UPDATE person_table SET age = age +1
WHERE (firstName = 'Winnie' AND lastName = 'Whines');

UPDATE person_table SET age = age +1
WHERE (firstName = 'Edouard' AND lastName = 'Lorimer');

UPDATE person_table SET age = age +1
WHERE (firstName = 'Courtney' AND lastName = 'Holley');

UPDATE person_table SET age = age +1
WHERE (firstName = 'Melva' AND lastName = 'Lanham');

UPDATE person_table SET age = age +1
WHERE (firstName = 'Isa' AND lastName = 'Slight');

UPDATE person_table SET age = age +1
WHERE (firstName = 'Abbott' AND lastName = 'Fisbburne');

UPDATE person_table SET age = age +1
WHERE (firstName = 'Reeta' AND lastName = 'Sammons');

-- SELECT title FROM interest_table WHERE interest_table.id IN
-- (SELECT interest_id FROM person_interest WHERE person_interest.person_id IN(
-- SELECT id FROM person_table WHERE (firstName = 'Hilton' AND lastName = 'O"Hanley')));

DELETE FROM person_table WHERE (firstName = 'Hilton' AND lastName = 'O"Hanley');
DELETE FROM person_table WHERE (firstName = 'Alanna'AND lastName='Spino');

SELECT firstName, lastName from person_table;

SELECT firstName,lastName, location_table.city, location_table.state 
FROM person_table
LEFT JOIN location_table 
ON location_table.id = person_table.location_id 
WHERE (location_table.city = 'Nashville' AND location_table.state = 'Tennessee');

SELECT count(firstName),location_table.city, location_table.state  
FROM person_table 
LEFT JOIN location_table 
ON person_table.location_id = location_table.id 
GROUP BY location_table.city,location_table.state;

SELECT count(firstName),interest_table.title 
FROM person_table
LEFT JOIN person_interest
ON person_table.id = person_interest.person_id
LEFT JOIN interest_table
ON person_interest.interest_id = interest_table.id
GROUP BY interest_table.title;

SELECT firstName, lastName FROM person_table as A
WHERE (A.location_id IN(
SELECT id FROM location_table WHERE 
(location_table.city = 'Nashville' AND location_table.state = 'Tennessee')
)AND A.id IN(
SELECT person_id FROM person_interest WHERE
person_interest.interest_id IN(
SELECT id FROM interest_table WHERE title = 'Programming'
)
));

SELECT count(firstName),age FROM person_table 
GROUP BY age
HAVING (age BETWEEN 20 AND 30)
OR (age BETWEEN 30 AND 40)
OR (age BETWEEN 40 AND 50);