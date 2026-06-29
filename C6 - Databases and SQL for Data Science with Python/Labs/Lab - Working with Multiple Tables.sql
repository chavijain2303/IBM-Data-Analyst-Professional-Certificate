-- =====================================================
-- HANDS-ON LAB: WORKING WITH MULTIPLE TABLES
-- DATABASE: HR
-- =====================================================

-- =====================================================
-- STEP 0: CREATE DATABASE
-- =====================================================

CREATE DATABASE IF NOT EXISTS HR;
USE HR;

-- =====================================================
-- STEP 1: CREATE TABLES (RUN IF NOT ALREADY CREATED)
-- =====================================================

CREATE TABLE IF NOT EXISTS EMPLOYEES (
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

CREATE TABLE IF NOT EXISTS JOBS (
    JOB_IDENT CHAR(9) NOT NULL, 
    JOB_TITLE VARCHAR(30),
    MIN_SALARY DECIMAL(10,2),
    MAX_SALARY DECIMAL(10,2),
    PRIMARY KEY (JOB_IDENT)
);

-- =====================================================
-- STEP 2: ACCESS MULTIPLE TABLES USING SUB-QUERIES
-- =====================================================

-- ---------------------------------------------
-- Example 1: Employees whose JOB_ID exists in JOBS table
-- ---------------------------------------------
SELECT *
FROM EMPLOYEES
WHERE JOB_ID IN (SELECT JOB_IDENT FROM JOBS);

-- ---------------------------------------------
-- Example 2: JOB details for employees earning > 70000
-- ---------------------------------------------
SELECT JOB_TITLE, MIN_SALARY, MAX_SALARY, JOB_IDENT
FROM JOBS
WHERE JOB_IDENT IN (
    SELECT JOB_ID
    FROM EMPLOYEES
    WHERE SALARY > 70000
);

-- =====================================================
-- STEP 3: ACCESS MULTIPLE TABLES USING IMPLICIT JOINS
-- =====================================================

-- ---------------------------------------------
-- Example 3: Join EMPLOYEES and JOBS
-- ---------------------------------------------
SELECT *
FROM EMPLOYEES, JOBS
WHERE EMPLOYEES.JOB_ID = JOBS.JOB_IDENT;

-- ---------------------------------------------
-- Example 4: Same query using aliases
-- ---------------------------------------------
SELECT *
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT;

-- ---------------------------------------------
-- Example 5: Select specific columns
-- ---------------------------------------------
SELECT EMP_ID, F_NAME, L_NAME, JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT;

-- ---------------------------------------------
-- Example 6: Fully qualified column names
-- ---------------------------------------------
SELECT E.EMP_ID, E.F_NAME, E.L_NAME, J.JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT;

-- =====================================================
-- STEP 4: PRACTICE PROBLEMS (WITH SOLUTIONS)
-- =====================================================

-- ---------------------------------------------
-- Q1: Employees whose JOB_TITLE is 'Jr. Designer'
-- ---------------------------------------------

-- (a) Using Sub-query
SELECT *
FROM EMPLOYEES
WHERE JOB_ID IN (
    SELECT JOB_IDENT
    FROM JOBS
    WHERE JOB_TITLE = 'Jr. Designer'
);

-- (b) Using Implicit Join
SELECT E.*
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT
AND J.JOB_TITLE = 'Jr. Designer';

-- ---------------------------------------------
-- Q2: JOB info + Employees born after 1976
-- ---------------------------------------------

-- (a) Using Sub-query
SELECT *
FROM JOBS
WHERE JOB_IDENT IN (
    SELECT JOB_ID
    FROM EMPLOYEES
    WHERE YEAR(B_DATE) > 1976
);

-- (b) Using Implicit Join
SELECT E.EMP_ID, E.F_NAME, E.L_NAME, E.B_DATE,
       J.JOB_TITLE, J.MIN_SALARY, J.MAX_SALARY
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT
AND YEAR(E.B_DATE) > 1976;

-- =====================================================
-- STEP 5: EXTRA PRACTICE (INTERVIEW LEVEL)
-- =====================================================

-- Employees with salary greater than their job's minimum salary
SELECT E.EMP_ID, E.F_NAME, E.SALARY, J.MIN_SALARY
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT
AND E.SALARY > J.MIN_SALARY;

-- Employees with highest salary per job
SELECT *
FROM EMPLOYEES E
WHERE SALARY = (
    SELECT MAX(SALARY)
    FROM EMPLOYEES
    WHERE JOB_ID = E.JOB_ID
);

-- =====================================================
-- END OF FILE
-- =====================================================