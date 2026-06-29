-- =====================================================
-- HANDS-ON LAB: CREATE & LOAD TABLES USING SQL SCRIPTS
-- CVD (CARDIO-VASCULAR DISEASE) DATABASE
-- VS CODE READY VERSION (CONVERTED FROM NOTEBOOK)
-- =====================================================

-- =====================================================
-- INTRODUCTION
-- =====================================================
-- In this lab, you will learn how to:
-- 1. Create a database in MySQL
-- 2. Create tables using SQL scripts
-- 3. Load data into tables using CSV files
--
-- Tool used: MySQL (phpMyAdmin via IBM Skills Network Labs)
-- =====================================================

-- =====================================================
-- DATABASE OVERVIEW
-- =====================================================
-- Database: CVD (Cardio-Vascular Diseases)
--
-- Tables in database:
-- - PATIENTS
-- - MEDICAL_HISTORY
-- - MEDICAL_PROCEDURES
-- - MEDICAL_DEPARTMENTS
-- - MEDICAL_LOCATIONS
-- =====================================================

-- =====================================================
-- TASK 1: CREATE DATABASE (GUI STEP - INFO ONLY)
-- =====================================================
-- In phpMyAdmin:
-- Create database name: CVD
-- Encoding: utf8 (default)

-- NOTE:
-- Database creation is done via GUI in SN Labs.
-- =====================================================

-- =====================================================
-- TASK 2: CREATE TABLES USING SQL SCRIPT
-- =====================================================

-- NOTE:
-- In real lab, tables are created using an external .sql file import.
-- Below is the conceptual structure.

-- -----------------------------------------------------
-- TABLE 1: PATIENTS
-- -----------------------------------------------------
CREATE TABLE PATIENTS (
    patient_id INT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(10),
    birth_date DATE
);

-- -----------------------------------------------------
-- TABLE 2: MEDICAL_HISTORY
-- -----------------------------------------------------
CREATE TABLE MEDICAL_HISTORY (
    record_id INT NOT NULL,
    patient_id INT,
    condition VARCHAR(100),
    diagnosis_date DATE
);

-- -----------------------------------------------------
-- TABLE 3: MEDICAL_PROCEDURES
-- -----------------------------------------------------
CREATE TABLE MEDICAL_PROCEDURES (
    procedure_id INT NOT NULL,
    patient_id INT,
    procedure_name VARCHAR(100),
    procedure_date DATE
);

-- -----------------------------------------------------
-- TABLE 4: MEDICAL_DEPARTMENTS
-- -----------------------------------------------------
CREATE TABLE MEDICAL_DEPARTMENTS (
    department_id INT NOT NULL,
    department_name VARCHAR(100)
);

-- -----------------------------------------------------
-- TABLE 5: MEDICAL_LOCATIONS
-- -----------------------------------------------------
CREATE TABLE MEDICAL_LOCATIONS (
    location_id INT NOT NULL,
    hospital_name VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(50)
);

-- =====================================================
-- VERIFY TABLES
-- =====================================================

SELECT * FROM PATIENTS;
SELECT * FROM MEDICAL_HISTORY;
SELECT * FROM MEDICAL_PROCEDURES;
SELECT * FROM MEDICAL_DEPARTMENTS;
SELECT * FROM MEDICAL_LOCATIONS;

-- =====================================================
-- TASK 3: LOAD DATA USING CSV FILES (CONCEPT)
-- =====================================================
-- In phpMyAdmin:
-- For each table:
-- 1. Select table
-- 2. Go to IMPORT tab
-- 3. Upload CSV file
-- 4. Click GO

-- CSV FILES USED:
-- Patients.csv
-- MedicalHistory.csv
-- MedicalProcedures.csv
-- MedicalDepartments.csv
-- MedicalLocations.csv

-- NOTE:
-- MySQL automatically maps CSV rows into table columns.
-- =====================================================

-- =====================================================
-- OPTIONAL SQL ALTERNATIVE (LOAD DATA INFILE)
-- =====================================================

-- Example (if file access allowed):
-- LOAD DATA INFILE 'Patients.csv'
-- INTO TABLE PATIENTS
-- FIELDS TERMINATED BY ','
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- =====================================================
-- PRACTICE SUMMARY
-- =====================================================
-- You learned how to:
-- - Create database (CVD)
-- - Create tables using SQL scripts
-- - Load data from CSV files into tables
-- =====================================================

-- END OF FILE
