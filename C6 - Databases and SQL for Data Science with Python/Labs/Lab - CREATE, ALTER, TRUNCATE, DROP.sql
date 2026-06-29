-- =====================================================
-- HANDS-ON LAB: CREATE, ALTER, TRUNCATE, DROP (MYSQL)
-- VS CODE READY VERSION (CONVERTED FROM NOTEBOOK)
-- =====================================================

-- =====================================================
-- INTRODUCTION
-- =====================================================
-- This lab covers SQL DDL (Data Definition Language):
--
-- CREATE   : Create database/tables
-- ALTER    : Modify table structure
-- TRUNCATE : Remove all rows from table
-- DROP     : Delete entire table
--
-- Tool used: MySQL (phpMyAdmin GUI in IBM Skills Network Labs)
-- =====================================================

-- =====================================================
-- TASK 1: CREATE DATABASE (GUI STEP - INFO ONLY)
-- =====================================================
-- In phpMyAdmin:
-- Create database: Mysql_Learners
-- Encoding: utf8 (default)

-- NOTE:
-- Database creation is usually done via GUI here.
-- =====================================================

-- =====================================================
-- TASK 2A: CREATE TABLES
-- =====================================================

CREATE TABLE PETSALE (
    ID INTEGER NOT NULL,
    PET CHAR(20),
    SALEPRICE DECIMAL(6,2),
    PROFIT DECIMAL(6,2),
    SALEDATE DATE
);

CREATE TABLE PET (
    ID INTEGER NOT NULL,
    ANIMAL VARCHAR(20),
    QUANTITY INTEGER
);

-- VERIFY TABLES
SELECT * FROM PETSALE;
SELECT * FROM PET;

-- =====================================================
-- TASK 2B: INSERT DATA
-- =====================================================

INSERT INTO PETSALE VALUES
(1,'Cat',450.09,100.47,'2018-05-29'),
(2,'Dog',666.66,150.76,'2018-06-01'),
(3,'Parrot',50.00,8.9,'2018-06-04'),
(4,'Hamster',60.60,12,'2018-06-11'),
(5,'Goldfish',48.48,3.5,'2018-06-14');

INSERT INTO PET VALUES
(1,'Cat',3),
(2,'Dog',4),
(3,'Hamster',2);

-- VERIFY DATA
SELECT * FROM PETSALE;
SELECT * FROM PET;

-- =====================================================
-- TASK 3: ALTER STATEMENT
-- =====================================================

-- -----------------------------------------------------
-- 3.1 ADD COLUMN
-- -----------------------------------------------------
ALTER TABLE PETSALE
ADD COLUMN QUANTITY INTEGER;

-- VERIFY
SELECT * FROM PETSALE;

-- UPDATE NEW COLUMN
UPDATE PETSALE SET QUANTITY = 9 WHERE ID = 1;
UPDATE PETSALE SET QUANTITY = 3 WHERE ID = 2;
UPDATE PETSALE SET QUANTITY = 2 WHERE ID = 3;
UPDATE PETSALE SET QUANTITY = 6 WHERE ID = 4;
UPDATE PETSALE SET QUANTITY = 24 WHERE ID = 5;

SELECT * FROM PETSALE;

-- -----------------------------------------------------
-- 3.2 DROP COLUMN
-- -----------------------------------------------------
ALTER TABLE PETSALE
DROP COLUMN PROFIT;

SELECT * FROM PETSALE;

-- -----------------------------------------------------
-- 3.3 MODIFY COLUMN TYPE
-- -----------------------------------------------------
ALTER TABLE PETSALE
MODIFY PET VARCHAR(20);

SELECT * FROM PETSALE;

-- -----------------------------------------------------
-- 3.4 RENAME COLUMN
-- -----------------------------------------------------
ALTER TABLE PETSALE
CHANGE PET ANIMAL VARCHAR(20);

SELECT * FROM PETSALE;

-- =====================================================
-- TASK 4: TRUNCATE TABLE
-- =====================================================

-- Remove all rows but keep table structure
TRUNCATE TABLE PET;

SELECT * FROM PET;

-- =====================================================
-- TASK 5: DROP TABLE
-- =====================================================

-- Delete entire table
DROP TABLE PET;

-- This will cause error if executed:
-- SELECT * FROM PET;

-- =====================================================
-- PRACTICE PROBLEMS (WITH SOLUTIONS)
-- =====================================================

-- -----------------------------------------------------
-- 1. CREATE TABLE TOYS
-- -----------------------------------------------------
CREATE TABLE Toys (
    ID INTEGER NOT NULL,
    Variety VARCHAR(30),
    Quantity INTEGER
);

-- -----------------------------------------------------
-- 2. INSERT DATA INTO TOYS
-- -----------------------------------------------------
INSERT INTO Toys VALUES
(1,'Chew toy',20),
(2,'Balls',50),
(3,'Bowls',30),
(4,'Foldable bed',40);

SELECT * FROM Toys;

-- -----------------------------------------------------
-- 3. ALTER COLUMN LENGTH
-- -----------------------------------------------------
ALTER TABLE Toys
MODIFY Variety VARCHAR(30);

SELECT * FROM Toys;

-- -----------------------------------------------------
-- 4. TRUNCATE TOYS TABLE
-- -----------------------------------------------------
TRUNCATE TABLE Toys;

SELECT * FROM Toys;

-- -----------------------------------------------------
-- 5. DROP TOYS TABLE
-- -----------------------------------------------------
DROP TABLE Toys;

-- =====================================================
-- SUMMARY NOTES
-- =====================================================
-- CREATE   -> creates database/table
-- INSERT   -> adds data
-- ALTER    -> modifies structure
-- TRUNCATE -> deletes all rows
-- DROP     -> removes table completely
-- =====================================================

-- END OF FILE
