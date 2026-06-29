-- =====================================================
-- SQL HANDS-ON LAB: COUNT, DISTINCT, LIMIT
-- VS CODE READY VERSION (CONVERTED FROM JUPYTER NOTEBOOK)
-- =====================================================

-- =====================================================
-- INTRODUCTION
-- =====================================================
-- In this lab, you will learn important SQL SELECT extensions:
--
-- COUNT   : Counts number of rows matching a condition
-- DISTINCT: Returns only unique (non-duplicate) values
-- LIMIT   : Restricts number of rows returned
--
-- Dataset: Film Locations in San Francisco
-- License: Public Domain Dedication (PDDL)
-- =====================================================

-- =====================================================
-- DATABASE EXPLORATION
-- =====================================================

-- View entire dataset
SELECT * FROM FilmLocations;

-- NOTE:
-- This helps understand table structure and data.

-- =====================================================
-- TABLE SCHEMA (REFERENCE ONLY)
-- =====================================================
-- Columns:
-- Title, ReleaseYear, Locations, FunFacts,
-- ProductionCompany, Distributor, Director,
-- Writer, Actor1, Actor2, Actor3

-- =====================================================
-- COUNT STATEMENT
-- =====================================================

-- Example 1: Count total rows in table
SELECT COUNT(*) FROM FilmLocations;

-- Example 2: Count locations for films written by James Cameron
SELECT COUNT(Locations)
FROM FilmLocations
WHERE Writer = 'James Cameron';

-- =====================================================
-- PRACTICE - COUNT
-- =====================================================

-- Exercise 1: Locations of films directed by Woody Allen
SELECT COUNT(Locations)
FROM FilmLocations
WHERE Director = 'Woody Allen';

-- Exercise 2: Films shot at Russian Hill
SELECT COUNT(*)
FROM FilmLocations
WHERE Locations = 'Russian Hill';

-- Exercise 3: Films released before 1950
SELECT COUNT(*)
FROM FilmLocations
WHERE ReleaseYear < 1950;

-- =====================================================
-- DISTINCT STATEMENT
-- =====================================================

-- Example 1: Unique film titles
SELECT DISTINCT Title
FROM FilmLocations;

-- Example 2: Unique release years for Warner Bros. Pictures
SELECT COUNT(DISTINCT ReleaseYear)
FROM FilmLocations
WHERE ProductionCompany = 'Warner Bros. Pictures';

-- =====================================================
-- PRACTICE - DISTINCT
-- =====================================================

-- Exercise 1: Unique films from 21st century onward
SELECT DISTINCT Title, ReleaseYear
FROM FilmLocations
WHERE ReleaseYear >= 2001;

-- Exercise 2: Directors and distinct films at City Hall
SELECT DISTINCT Director, Title
FROM FilmLocations
WHERE Locations = 'City Hall';

-- Exercise 3: Unique distributors for Clint Eastwood films
SELECT COUNT(DISTINCT Distributor)
FROM FilmLocations
WHERE Actor1 = 'Clint Eastwood';

-- =====================================================
-- LIMIT STATEMENT
-- =====================================================

-- Example 1: First 25 rows
SELECT * FROM FilmLocations
LIMIT 25;

-- Example 2: 15 rows starting from row 11
SELECT * FROM FilmLocations
LIMIT 15 OFFSET 10;

-- =====================================================
-- PRACTICE - LIMIT
-- =====================================================

-- Exercise 1: First 50 film titles
SELECT Title
FROM FilmLocations
LIMIT 50;

-- Exercise 2: First 10 films released in 2015
SELECT Title
FROM FilmLocations
WHERE ReleaseYear = 2015
LIMIT 10;

-- Exercise 3: Next 3 films after first 5 (2015)
SELECT Title
FROM FilmLocations
WHERE ReleaseYear = 2015
LIMIT 3 OFFSET 5;

-- =====================================================
-- SUMMARY NOTES
-- =====================================================
-- COUNT      -> counts rows
-- DISTINCT   -> removes duplicates
-- LIMIT      -> restricts output rows
-- WHERE      -> filters data
-- =====================================================

-- END OF FILE
