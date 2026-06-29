-- =====================================================
-- SQL HANDS-ON LAB: INSERT, UPDATE, DELETE (DML)
-- VS CODE READY VERSION (CONVERTED FROM JUPYTER NOTEBOOK)
-- =====================================================

-- =====================================================
-- INTRODUCTION
-- =====================================================
-- This lab covers SQL DML (Data Manipulation Language):
--
-- INSERT : Add new rows into a table
-- UPDATE : Modify existing records
-- DELETE : Remove existing records
--
-- Dataset used: Instructor table
-- =====================================================

-- =====================================================
-- DATABASE EXPLORATION
-- =====================================================

-- View all records in Instructor table
SELECT * FROM Instructor;

-- NOTE:
-- Used to understand table structure and current data.

-- =====================================================
-- TABLE SCHEMA (REFERENCE)
-- =====================================================
-- ins_id   : Instructor ID
-- lastname  : Last name
-- firstname : First name
-- city      : City
-- country   : Country code

-- =====================================================
-- INSERT STATEMENT
-- =====================================================

-- Syntax:
-- INSERT INTO table_name (columns)
-- VALUES (values);

-- -----------------------------------------------------
-- Example 1: Insert single row
-- -----------------------------------------------------
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES (4, 'Saha', 'Sandip', 'Edmonton', 'CA');

-- VERIFY
SELECT * FROM Instructor;

-- -----------------------------------------------------
-- Example 2: Insert multiple rows
-- -----------------------------------------------------
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES
(5, 'Doe', 'John', 'Sydney', 'AU'),
(6, 'Doe', 'Jane', 'Dhaka', 'BD');

-- VERIFY
SELECT * FROM Instructor;

-- =====================================================
-- PRACTICE INSERT
-- =====================================================

-- Exercise 1
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES (7, 'Cangiano', 'Antonio', 'Vancouver', 'CA');

-- Exercise 2
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES
(8, 'Ryan', 'Steve', 'Barlby', 'GB'),
(9, 'Sannareddy', 'Ramesh', 'Hyderabad', 'IN');

-- VERIFY
SELECT * FROM Instructor;

-- =====================================================
-- UPDATE STATEMENT
-- =====================================================

-- Syntax:
-- UPDATE table_name
-- SET column = value
-- WHERE condition;

-- -----------------------------------------------------
-- Example 1: Update one column
-- -----------------------------------------------------
UPDATE Instructor
SET city = 'Toronto'
WHERE firstname = 'Sandip';

-- VERIFY
SELECT * FROM Instructor;

-- -----------------------------------------------------
-- Example 2: Update multiple columns
-- -----------------------------------------------------
UPDATE Instructor
SET city = 'Dubai', country = 'AE'
WHERE ins_id = 5;

-- VERIFY
SELECT * FROM Instructor;

-- =====================================================
-- PRACTICE UPDATE
-- =====================================================

-- Exercise 1
UPDATE Instructor
SET city = 'Markham'
WHERE ins_id = 1;

-- Exercise 2
UPDATE Instructor
SET city = 'Dhaka', country = 'BD'
WHERE ins_id = 4;

-- VERIFY
SELECT * FROM Instructor;

-- =====================================================
-- DELETE STATEMENT
-- =====================================================

-- Syntax:
-- DELETE FROM table_name
-- WHERE condition;

-- -----------------------------------------------------
-- Example: Delete a record
-- -----------------------------------------------------
DELETE FROM Instructor
WHERE ins_id = 6;

-- VERIFY
SELECT * FROM Instructor;

-- =====================================================
-- PRACTICE DELETE
-- =====================================================

-- Problem: Remove instructor named Hima
DELETE FROM Instructor
WHERE firstname = 'Hima';

-- VERIFY
SELECT * FROM Instructor;

-- =====================================================
-- SUMMARY
-- =====================================================
-- INSERT -> adds new rows
-- UPDATE -> modifies existing rows
-- DELETE -> removes rows
-- =====================================================

-- END OF FILE
