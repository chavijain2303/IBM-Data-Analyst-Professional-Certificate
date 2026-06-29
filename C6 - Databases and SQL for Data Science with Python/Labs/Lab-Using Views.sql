/*
========================================================
Hands-on Lab: Using Views in MySQL using phpMyAdmin
========================================================

Author  : Chavi Jain
Database: HR
Software: MySQL + phpMyAdmin + VS Code

========================================================
OBJECTIVES
========================================================

After completing this lab, you will be able to:

1. Create a View
2. Update/Modify a View
3. Drop/Delete a View
4. Combine multiple tables using Views

========================================================
WHAT IS A VIEW?
========================================================

A View in SQL is a virtual table created from one or
more existing tables.

Important Notes:
- A view stores only the SQL query.
- It does NOT store actual data.
- Views help simplify complex queries.
- Views improve security by restricting access
  to selected columns.

========================================================
STEP 1: CREATE DATABASE
========================================================
*/

CREATE DATABASE HR;
USE HR;

/*
========================================================
STEP 2: DROP EXISTING TABLES (IF THEY EXIST)
========================================================
*/

DROP TABLE IF EXISTS EMPLOYEES;
DROP TABLE IF EXISTS JOB_HISTORY;
DROP TABLE IF EXISTS JOBS;
DROP TABLE IF EXISTS DEPARTMENTS;
DROP TABLE IF EXISTS LOCATIONS;

/*
========================================================
STEP 3: CREATE TABLES
========================================================

TABLES:
1. EMPLOYEES
2. JOB_HISTORY
3. JOBS
4. DEPARTMENTS
5. LOCATIONS

========================================================
CREATE EMPLOYEES TABLE
========================================================
*/

CREATE TABLE EMPLOYEES (
    EMP_ID CHAR(9) NOT NULL,
    F_NAME VARCHAR(15) NOT NULL,
    L_NAME VARCHAR(15) NOT NULL,
    SSN CHAR(9),
    B_DATE DATE,
    SEX CHAR,
    ADDRESS VARCHAR(30),
    JOB_ID CHAR(9),
    SALARY DECIMAL(10,2),
    MANAGER_ID CHAR(9),
    DEP_ID CHAR(9) NOT NULL,
    PRIMARY KEY (EMP_ID)
);

/*
========================================================
CREATE JOB_HISTORY TABLE
========================================================
*/

CREATE TABLE JOB_HISTORY (
    EMPL_ID CHAR(9) NOT NULL,
    START_DATE DATE,
    JOBS_ID CHAR(9) NOT NULL,
    DEPT_ID CHAR(9),
    PRIMARY KEY (EMPL_ID, JOBS_ID)
);

/*
========================================================
CREATE JOBS TABLE
========================================================
*/

CREATE TABLE JOBS (
    JOB_IDENT CHAR(9) NOT NULL,
    JOB_TITLE VARCHAR(30),
    MIN_SALARY DECIMAL(10,2),
    MAX_SALARY DECIMAL(10,2),
    PRIMARY KEY (JOB_IDENT)
);

/*
========================================================
CREATE DEPARTMENTS TABLE
========================================================
*/

CREATE TABLE DEPARTMENTS (
    DEPT_ID_DEP CHAR(9) NOT NULL,
    DEP_NAME VARCHAR(15),
    MANAGER_ID CHAR(9),
    LOC_ID CHAR(9),
    PRIMARY KEY (DEPT_ID_DEP)
);

/*
========================================================
CREATE LOCATIONS TABLE
========================================================
*/

CREATE TABLE LOCATIONS (
    LOCT_ID CHAR(9) NOT NULL,
    DEP_ID_LOC CHAR(9) NOT NULL,
    PRIMARY KEY (LOCT_ID, DEP_ID_LOC)
);

/*
========================================================
STEP 4: LOAD CSV FILES
========================================================

Load the following CSV files into their respective tables
using phpMyAdmin Import option.

CSV FILES:
1. Departments.csv  -> DEPARTMENTS
2. Employees.csv    -> EMPLOYEES
3. Jobs.csv         -> JOBS
4. Locations.csv    -> LOCATIONS
5. JobsHistory.csv  -> JOB_HISTORY

========================================================
TASK 1: CREATE A VIEW
========================================================

Objective:
Create a View named EMPSALARY to display:
- Employee ID
- First Name
- Last Name
- Birth Date
- Gender
- Salary

========================================================
QUERY: CREATE VIEW
========================================================
*/

CREATE VIEW EMPSALARY AS
SELECT
    EMP_ID,
    F_NAME,
    L_NAME,
    B_DATE,
    SEX,
    SALARY
FROM EMPLOYEES;

/*
========================================================
QUERY: DISPLAY DATA FROM VIEW
========================================================
*/

SELECT * FROM EMPSALARY;

/*
========================================================
NOTES:
========================================================

1. CREATE VIEW creates a virtual table.

2. The EMPSALARY view stores only the SQL query,
   not actual data.

3. Any updates made in EMPLOYEES table are
   automatically reflected in the view.

========================================================
TASK 2: UPDATE/MODIFY A VIEW
========================================================

Objective:
Modify EMPSALARY view to include:

- JOB_TITLE
- MIN_SALARY
- MAX_SALARY

We combine:
1. EMPLOYEES table
2. JOBS table

using:
EMPLOYEES.JOB_ID = JOBS.JOB_IDENT

========================================================
QUERY: UPDATE VIEW
========================================================
*/

CREATE OR REPLACE VIEW EMPSALARY AS
SELECT
    EMP_ID,
    F_NAME,
    L_NAME,
    B_DATE,
    SEX,
    JOB_TITLE,
    MIN_SALARY,
    MAX_SALARY
FROM EMPLOYEES, JOBS
WHERE EMPLOYEES.JOB_ID = JOBS.JOB_IDENT;

/*
========================================================
QUERY: DISPLAY UPDATED VIEW
========================================================
*/

SELECT * FROM EMPSALARY;

/*
========================================================
NOTES:
========================================================

1. CREATE OR REPLACE VIEW updates an existing view.

2. The query combines EMPLOYEES and JOBS tables.

3. This technique is called an IMPLICIT INNER JOIN.

4. Matching condition:
   EMPLOYEES.JOB_ID = JOBS.JOB_IDENT

========================================================
TASK 3: DROP A VIEW
========================================================

Objective:
Delete the EMPSALARY view.

========================================================
QUERY: DROP VIEW
========================================================
*/

DROP VIEW EMPSALARY;

/*
========================================================
VERIFY WHETHER VIEW EXISTS
========================================================
*/

SELECT * FROM EMPSALARY;

/*
========================================================
EXPECTED RESULT:
========================================================

An error message appears because the view
has been deleted successfully.

========================================================
PRACTICE PROBLEM 1
========================================================

Create a View named EMP_DEPT containing:

- EMP_ID
- F_NAME
- L_NAME
- DEP_ID

from EMPLOYEES table.

========================================================
SOLUTION
========================================================
*/

CREATE VIEW EMP_DEPT AS
SELECT
    EMP_ID,
    F_NAME,
    L_NAME,
    DEP_ID
FROM EMPLOYEES;

/*
========================================================
VERIFY VIEW
========================================================
*/

SELECT * FROM EMP_DEPT;

/*
========================================================
PRACTICE PROBLEM 2
========================================================

Modify EMP_DEPT view to display:

- EMP_ID
- F_NAME
- L_NAME
- DEP_NAME

Combine:
EMPLOYEES and DEPARTMENTS tables

Condition:
EMPLOYEES.DEP_ID = DEPARTMENTS.DEPT_ID_DEP

========================================================
SOLUTION
========================================================
*/

CREATE OR REPLACE VIEW EMP_DEPT AS
SELECT
    EMP_ID,
    F_NAME,
    L_NAME,
    DEP_NAME
FROM EMPLOYEES, DEPARTMENTS
WHERE EMPLOYEES.DEP_ID = DEPARTMENTS.DEPT_ID_DEP;

/*
========================================================
VERIFY UPDATED VIEW
========================================================
*/

SELECT * FROM EMP_DEPT;

/*
========================================================
PRACTICE PROBLEM 3
========================================================

Drop the EMP_DEPT view.

========================================================
SOLUTION
========================================================
*/

DROP VIEW EMP_DEPT;

/*
========================================================
VERIFY DELETION
========================================================
*/

SELECT * FROM EMP_DEPT;

/*
========================================================
IMPORTANT SQL COMMANDS USED
========================================================

1. CREATE DATABASE
   -> Creates a new database

2. CREATE TABLE
   -> Creates a new table

3. CREATE VIEW
   -> Creates a new view

4. CREATE OR REPLACE VIEW
   -> Modifies existing view

5. SELECT
   -> Retrieves data

6. DROP VIEW
   -> Deletes a view

========================================================
ADVANTAGES OF VIEWS
========================================================

1. Simplifies complex queries
2. Improves security
3. Reusable SQL logic
4. Provides abstraction
5. Easy reporting and analysis

========================================================
CONCLUSION
========================================================

In this lab, we learned:

1. How to create Views
2. How to modify Views
3. How to combine multiple tables using Views
4. How to delete Views
5. How to retrieve data from Views

Views help simplify database operations and improve
data management in SQL.

========================================================
END OF FILE
========================================================