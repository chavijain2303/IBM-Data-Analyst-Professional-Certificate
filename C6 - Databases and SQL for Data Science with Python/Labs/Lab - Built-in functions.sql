-- =====================================================
-- HANDS-ON LAB: BUILT-IN FUNCTIONS
-- DATABASE: Mysql_Learners
-- =====================================================

-- =====================================================
-- STEP 0: SETUP
-- =====================================================

CREATE DATABASE IF NOT EXISTS Mysql_Learners;
USE Mysql_Learners;

DROP TABLE IF EXISTS PETRESCUE;

CREATE TABLE PETRESCUE (
    ID INTEGER NOT NULL,
    ANIMAL VARCHAR(20),
    QUANTITY INTEGER,
    COST DECIMAL(6,2),
    RESCUEDATE DATE,
    PRIMARY KEY (ID)
);

INSERT INTO PETRESCUE VALUES 
(1,'Cat',9,450.09,'2018-05-29'),
(2,'Dog',3,666.66,'2018-06-01'),
(3,'Dog',1,100.00,'2018-06-04'),
(4,'Parrot',2,50.00,'2018-06-04'),
(5,'Dog',1,75.75,'2018-06-10'),
(6,'Hamster',6,60.60,'2018-06-11'),
(7,'Cat',1,44.44,'2018-06-11'),
(8,'Goldfish',24,48.48,'2018-06-14'),
(9,'Dog',2,222.22,'2018-06-15');


-- =====================================================
-- AGGREGATION FUNCTIONS
-- =====================================================

-- Total cost
SELECT SUM(COST) AS SUM_OF_COST FROM PETRESCUE;

-- Maximum quantity
SELECT MAX(QUANTITY) AS MAX_QTY FROM PETRESCUE;

-- Minimum quantity
SELECT MIN(QUANTITY) AS MIN_QTY FROM PETRESCUE;

-- Average cost
SELECT AVG(COST) AS AVG_COST FROM PETRESCUE;


-- =====================================================
-- SCALAR FUNCTIONS
-- =====================================================

-- Round cost to integer
SELECT ROUND(COST) FROM PETRESCUE;

-- Round cost to 2 decimal places
SELECT ROUND(COST,2) FROM PETRESCUE;


-- =====================================================
-- STRING FUNCTIONS
-- =====================================================

-- Length of animal names
SELECT LENGTH(ANIMAL) FROM PETRESCUE;

-- Uppercase animal names
SELECT UCASE(ANIMAL) FROM PETRESCUE;

-- Lowercase animal names
SELECT LCASE(ANIMAL) FROM PETRESCUE;


-- =====================================================
-- DATE FUNCTIONS
-- =====================================================

-- Extract DAY
SELECT DAY(RESCUEDATE) FROM PETRESCUE;

-- Extract MONTH
SELECT MONTH(RESCUEDATE) FROM PETRESCUE;

-- Extract YEAR
SELECT YEAR(RESCUEDATE) FROM PETRESCUE;

-- Add 3 days (vet visit)
SELECT DATE_ADD(RESCUEDATE, INTERVAL 3 DAY) FROM PETRESCUE;

-- Subtract 3 days
SELECT DATE_SUB(RESCUEDATE, INTERVAL 3 DAY) FROM PETRESCUE;

-- Difference from current date
SELECT DATEDIFF(CURRENT_DATE, RESCUEDATE) FROM PETRESCUE;

-- Format date difference
SELECT FROM_DAYS(DATEDIFF(CURRENT_DATE, RESCUEDATE)) FROM PETRESCUE;


-- =====================================================
-- PRACTICE QUESTIONS (WITH SOLUTIONS)
-- =====================================================

-- Q1: Average cost per dog
SELECT AVG(COST/QUANTITY) AS AVG_COST_PER_DOG
FROM PETRESCUE
WHERE ANIMAL = 'Dog';

-- Q2: Unique animal names in uppercase
SELECT DISTINCT UCASE(ANIMAL) FROM PETRESCUE;

-- Q3: All records where animal is cat (case insensitive)
SELECT *
FROM PETRESCUE
WHERE LCASE(ANIMAL) = 'cat';

-- Q4: Number of rescues in May (month = 5)
SELECT COUNT(*) AS RESCUES_IN_MAY
FROM PETRESCUE
WHERE MONTH(RESCUEDATE) = 5;

-- Q5: ID and target adoption date (1 year later)
SELECT 
    ID,
    DATE_ADD(RESCUEDATE, INTERVAL 1 YEAR) AS TARGET_DATE
FROM PETRESCUE;


-- =====================================================
-- IMPORTANT NOTES (INTERVIEW READY)
-- =====================================================

-- 1. Aggregate functions → SUM, AVG, MAX, MIN, COUNT
-- 2. Scalar functions → operate on single values (ROUND)
-- 3. String functions → LENGTH, UCASE, LCASE
-- 4. Date functions → DAY, MONTH, YEAR, DATE_ADD, DATE_SUB

-- 5. CURRENT_DATE → returns today's date
-- 6. DATEDIFF → difference in days
-- 7. FROM_DAYS → converts days into date format

-- =====================================================
-- END OF FILE
-- =====================================================