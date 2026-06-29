-- =====================================================
-- HANDS-ON LAB: STRING PATTERNS, SORTING, GROUPING
-- DATABASE: HR
-- =====================================================
-- =====================================================
-- STEP 0: SETUP (RUN ONLY IF NOT CREATED)
-- =====================================================
-- =====================================================
-- HR DATABASE - COMPLETE TABLE CREATION SCRIPT
-- =====================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS HR;
USE HR;

-- =====================================================
-- TABLE 1: EMPLOYEES
-- =====================================================

CREATE TABLE EMPLOYEES (
    EMP_ID CHAR(9) NOT NULL,
    F_NAME VARCHAR(15) NOT NULL,
    L_NAME VARCHAR(15) NOT NULL,
    SSN CHAR(9),
    B_DATE DATE,
    SEX CHAR(1),
    ADDRESS VARCHAR(30),
    JOB_ID CHAR(9),
    SALARY DECIMAL(10,2),
    MANAGER_ID CHAR(9),
    DEP_ID CHAR(9) NOT NULL,
    PRIMARY KEY (EMP_ID)
);

-- =====================================================
-- TABLE 2: JOB_HISTORY
-- =====================================================

CREATE TABLE JOB_HISTORY (
    EMPL_ID CHAR(9) NOT NULL,
    START_DATE DATE,
    JOBS_ID CHAR(9) NOT NULL,
    DEPT_ID CHAR(9),
    PRIMARY KEY (EMPL_ID, JOBS_ID)
);

-- =====================================================
-- TABLE 3: JOBS
-- =====================================================

CREATE TABLE JOBS (
    JOB_IDENT CHAR(9) NOT NULL,
    JOB_TITLE VARCHAR(30),
    MIN_SALARY DECIMAL(10,2),
    MAX_SALARY DECIMAL(10,2),
    PRIMARY KEY (JOB_IDENT)
);

-- =====================================================
-- TABLE 4: DEPARTMENTS
-- =====================================================

CREATE TABLE DEPARTMENTS (
    DEPT_ID_DEP CHAR(9) NOT NULL,
    DEP_NAME VARCHAR(15),
    MANAGER_ID CHAR(9),
    LOC_ID CHAR(9),
    PRIMARY KEY (DEPT_ID_DEP)
);

-- =====================================================
-- TABLE 5: LOCATIONS (FIXED & COMPLETED)
-- =====================================================

CREATE TABLE LOCATIONS (
    LOCT_ID CHAR(9) NOT NULL,
    DEP_ID_LOC CHAR(9) NOT NULL,
    PRIMARY KEY (LOCT_ID)
);

-- =====================================================
-- OPTIONAL: ADD FOREIGN KEYS (GOOD PRACTICE)
-- =====================================================

-- Employees → Departments
ALTER TABLE EMPLOYEES
ADD CONSTRAINT FK_EMP_DEP
FOREIGN KEY (DEP_ID)
REFERENCES DEPARTMENTS(DEPT_ID_DEP);

-- Employees → Jobs
ALTER TABLE EMPLOYEES
ADD CONSTRAINT FK_EMP_JOB
FOREIGN KEY (JOB_ID)
REFERENCES JOBS(JOB_IDENT);

-- Job History → Employees
ALTER TABLE JOB_HISTORY
ADD CONSTRAINT FK_JH_EMP
FOREIGN KEY (EMPL_ID)
REFERENCES EMPLOYEES(EMP_ID);

-- Job History → Jobs
ALTER TABLE JOB_HISTORY
ADD CONSTRAINT FK_JH_JOB
FOREIGN KEY (JOBS_ID)
REFERENCES JOBS(JOB_IDENT);

-- Job History → Departments
ALTER TABLE JOB_HISTORY
ADD CONSTRAINT FK_JH_DEP
FOREIGN KEY (DEPT_ID)
REFERENCES DEPARTMENTS(DEPT_ID_DEP);

-- Departments → Locations
ALTER TABLE DEPARTMENTS
ADD CONSTRAINT FK_DEP_LOC
FOREIGN KEY (LOC_ID)
REFERENCES LOCATIONS(LOCT_ID);

-- =====================================================
-- NOTES (IMPORTANT)
-- =====================================================

-- 1. CHAR is fixed length (faster for IDs)
-- 2. VARCHAR is variable length (efficient for names/text)
-- 3. DECIMAL(10,2) → exact numeric values (salary)
-- 4. PRIMARY KEY → unique + not null
-- 5. FOREIGN KEY → maintains relationships (data integrity)


-- (Tables + data should already be loaded via CSV as per lab)

-- =====================================================
-- STRING PATTERNS (LIKE, BETWEEN)
-- =====================================================

-- 1. Employees living in Elgin, IL
SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE ADDRESS LIKE '%Elgin,IL%';

-- 2. Employees born in the 1970s
SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE B_DATE LIKE '197%';

-- 3. Employees in department 5 with salary between 60000 and 70000
SELECT *
FROM EMPLOYEES
WHERE (SALARY BETWEEN 60000 AND 70000)
AND DEP_ID = 5;


-- =====================================================
-- SORTING (ORDER BY)
-- =====================================================

-- 4. Sort employees by department ID (ascending - default)
SELECT F_NAME, L_NAME, DEP_ID
FROM EMPLOYEES
ORDER BY DEP_ID;

-- 5. Sort by department ID DESC and last name DESC
SELECT F_NAME, L_NAME, DEP_ID
FROM EMPLOYEES
ORDER BY DEP_ID DESC, L_NAME DESC;


-- =====================================================
-- GROUPING (GROUP BY + AGGREGATE FUNCTIONS)
-- =====================================================

-- 6. Count employees in each department
SELECT DEP_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEP_ID;

-- 7. Count + Average salary per department
SELECT DEP_ID, COUNT(*), AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEP_ID;

-- 8. Using column aliases (recommended)
SELECT 
    DEP_ID, 
    COUNT(*) AS NUM_EMPLOYEES, 
    AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID;

-- 9. Group + Sort by average salary
SELECT 
    DEP_ID, 
    COUNT(*) AS NUM_EMPLOYEES, 
    AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID
ORDER BY AVG_SALARY;

-- 10. Group + Filter using HAVING
SELECT 
    DEP_ID, 
    COUNT(*) AS NUM_EMPLOYEES, 
    AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING COUNT(*) < 4
ORDER BY AVG_SALARY;


-- =====================================================
-- PRACTICE QUESTIONS (WITH SOLUTIONS)
-- =====================================================

-- Q1: Employees whose first name starts with 'S'
SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE F_NAME LIKE 'S%';


-- Q2: Sort employees by date of birth (ascending)
SELECT *
FROM EMPLOYEES
ORDER BY B_DATE;


-- Q3: Departments with avg salary >= 60000
SELECT 
    DEP_ID, 
    AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING AVG(SALARY) >= 60000;


-- Q4: Same as above but sorted DESC by avg salary
SELECT 
    DEP_ID, 
    AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING AVG(SALARY) >= 60000
ORDER BY AVG_SALARY DESC;


-- =====================================================
-- NOTES (VERY IMPORTANT FOR INTERVIEWS)
-- =====================================================

-- LIKE:
-- % → any number of characters
-- _ → single character

-- BETWEEN:
-- Inclusive range (includes both values)

-- ORDER BY:
-- ASC (default), DESC

-- GROUP BY:
-- Used with aggregate functions (COUNT, AVG, SUM, etc.)

-- HAVING:
-- Filters grouped data (WHERE cannot be used here)

-- Execution Order:
-- FROM → WHERE → GROUP BY → HAVING → ORDER BY

-- =====================================================
-- END OF FILE
-- =====================================================