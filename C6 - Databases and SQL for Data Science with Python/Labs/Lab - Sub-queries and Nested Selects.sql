-- =====================================================
-- HANDS-ON LAB: SUB-QUERIES AND NESTED SELECTS
-- DATABASE: HR
-- =====================================================

-- =====================================================
-- STEP 0: CREATE DATABASE
-- =====================================================

CREATE DATABASE IF NOT EXISTS HR;
USE HR;

-- =====================================================
-- STEP 1: CREATE TABLES
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

CREATE TABLE JOB_HISTORY (
    EMPL_ID CHAR(9) NOT NULL, 
    START_DATE DATE,
    JOBS_ID CHAR(9) NOT NULL,
    DEPT_ID CHAR(9),
    PRIMARY KEY (EMPL_ID, JOBS_ID)
);

CREATE TABLE JOBS (
    JOB_IDENT CHAR(9) NOT NULL, 
    JOB_TITLE VARCHAR(30),
    MIN_SALARY DECIMAL(10,2),
    MAX_SALARY DECIMAL(10,2),
    PRIMARY KEY (JOB_IDENT)
);

CREATE TABLE DEPARTMENTS (
    DEPT_ID_DEP CHAR(9) NOT NULL, 
    DEP_NAME VARCHAR(15),
    MANAGER_ID CHAR(9),
    LOC_ID CHAR(9),
    PRIMARY KEY (DEPT_ID_DEP)
);

CREATE TABLE LOCATIONS (
    LOCT_ID CHAR(9) NOT NULL,
    DEP_ID_LOC CHAR(9) NOT NULL,
    PRIMARY KEY (LOCT_ID, DEP_ID_LOC)
);

-- =====================================================
-- STEP 2: SUB-QUERIES (CONCEPT + EXAMPLES)
-- =====================================================

-- ---------------------------------------------
-- Example 1: Employees earning less than average salary
-- ---------------------------------------------
SELECT *
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES);

-- ---------------------------------------------
-- Example 2: Add MAX salary as a column
-- ---------------------------------------------
SELECT EMP_ID, SALARY,
       (SELECT MAX(SALARY) FROM EMPLOYEES) AS MAX_SALARY
FROM EMPLOYEES;

-- ---------------------------------------------
-- Example 3: Oldest employee (minimum birth date)
-- ---------------------------------------------
SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE B_DATE = (SELECT MIN(B_DATE) FROM EMPLOYEES);

-- ---------------------------------------------
-- Example 4: Average salary of top 5 earners
-- ---------------------------------------------
SELECT AVG(SALARY) AS AVG_TOP_5_SALARY
FROM (
    SELECT SALARY
    FROM EMPLOYEES
    ORDER BY SALARY DESC
    LIMIT 5
) AS TOP_SALARIES;

-- =====================================================
-- STEP 3: PRACTICE PROBLEMS (WITH SOLUTIONS)
-- =====================================================

-- ---------------------------------------------
-- Q1: Average salary of 5 least-earning employees
-- ---------------------------------------------
SELECT AVG(SALARY) AS AVG_LOWEST_5
FROM (
    SELECT SALARY
    FROM EMPLOYEES
    ORDER BY SALARY ASC
    LIMIT 5
) AS LOWEST_SALARIES;

-- ---------------------------------------------
-- Q2: Employees older than average age
-- ---------------------------------------------
SELECT *
FROM EMPLOYEES
WHERE B_DATE < (
    SELECT AVG(B_DATE) FROM EMPLOYEES
);

-- ---------------------------------------------
-- Q3: Employee ID, years of service, avg years of service
-- ---------------------------------------------
SELECT 
    EMPL_ID,
    TIMESTAMPDIFF(YEAR, START_DATE, CURRENT_DATE) AS YEARS_OF_SERVICE,
    (
        SELECT AVG(TIMESTAMPDIFF(YEAR, START_DATE, CURRENT_DATE))
        FROM JOB_HISTORY
    ) AS AVG_YEARS_OF_SERVICE
FROM JOB_HISTORY;

-- =====================================================
-- STEP 4: EXTRA PRACTICE (OPTIONAL - INTERVIEW LEVEL)
-- =====================================================

-- Employees earning more than department average
SELECT *
FROM EMPLOYEES E
WHERE SALARY > (
    SELECT AVG(SALARY)
    FROM EMPLOYEES
    WHERE DEP_ID = E.DEP_ID
);

-- Highest paid employee in each department
SELECT *
FROM EMPLOYEES E
WHERE SALARY = (
    SELECT MAX(SALARY)
    FROM EMPLOYEES
    WHERE DEP_ID = E.DEP_ID
);

-- =====================================================
-- END OF FILE
-- =====================================================