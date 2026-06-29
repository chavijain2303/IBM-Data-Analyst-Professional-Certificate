-- =====================================================
-- SQL SELECT LAB - FILM LOCATIONS DATASET (VS CODE VERSION)
-- Converted from Jupyter Notebook (.ipynb)
-- =====================================================

-- =====================================================
-- INTRODUCTION
-- =====================================================
-- In this lab, you will learn one of the most commonly used
-- SQL (Structured Query Language) statements: SELECT.
-- The SELECT statement is used to retrieve data from a database.

-- OBJECTIVES:
-- After completing this lab, you will be able to:
-- 1. Query a database to obtain a result set
-- 2. Retrieve all or selected columns of a dataset
-- 3. Apply criteria commands to filter results

-- SOFTWARE USED:
-- Datasette (open-source tool for exploring data)

-- DATASET:
-- Film Locations in San Francisco (Public Domain License)

-- =====================================================
-- DATABASE EXPLORATION
-- =====================================================

-- Step 1: View all data from FilmLocations table
SELECT * FROM FilmLocations;

-- NOTE:
-- This helps understand table structure and contents.

-- =====================================================
-- TABLE SCHEMA INFORMATION
-- =====================================================

-- Columns in FilmLocations table:
-- Title               : Film title
-- ReleaseYear         : Year film was released
-- Locations           : Filming locations in San Francisco
-- FunFacts            : Interesting facts about filming
-- ProductionCompany   : Company that produced the film
-- Distributor         : Film distributor
-- Director            : Film director
-- Writer              : Film writer
-- Actor1              : Main actor
-- Actor2              : Secondary actor
-- Actor3              : Third actor

-- =====================================================
-- SELECT STATEMENT BASICS
-- =====================================================

-- Retrieve all columns
SELECT * FROM FilmLocations;

-- NOTE:
-- * means all columns are selected

-- =====================================================
-- SELECT SPECIFIC COLUMNS
-- =====================================================

-- Retrieve Title, Director, Writer
SELECT Title, Director, Writer
FROM FilmLocations;

-- NOTE:
-- Selecting specific columns improves performance

-- =====================================================
-- FILTERING DATA USING WHERE CLAUSE
-- =====================================================

-- Films released in or after 2001
SELECT Title, ReleaseYear, Locations
FROM FilmLocations
WHERE ReleaseYear >= 2001;

-- Films released in or before 2000
SELECT Title, ReleaseYear, Locations
FROM FilmLocations
WHERE ReleaseYear <= 2000;

-- Films NOT written by James Cameron
SELECT Title, ProductionCompany, Locations, ReleaseYear
FROM FilmLocations
WHERE Writer <> 'James Cameron';

-- NOTE:
-- WHERE clause filters rows based on conditions

-- =====================================================
-- PRACTICE EXERCISES
-- =====================================================

-- Exercise 1: Retrieve FunFacts and Locations
SELECT FunFacts, Locations
FROM FilmLocations;

-- Exercise 2: Films released before or in 2000
SELECT Title, ReleaseYear, Locations
FROM FilmLocations
WHERE ReleaseYear <= 2000;

-- Exercise 3: Films not written by James Cameron
SELECT Title, ProductionCompany, Locations, ReleaseYear
FROM FilmLocations
WHERE Writer <> 'James Cameron';

-- =====================================================
-- CONCLUSION
-- =====================================================
-- You have learned:
-- - How to use SELECT statement
-- - How to retrieve all or specific columns
-- - How to filter data using WHERE clause

-- END OF FILE
