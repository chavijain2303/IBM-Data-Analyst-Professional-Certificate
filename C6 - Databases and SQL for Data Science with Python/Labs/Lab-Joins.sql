/*
========================================================
Hands-on Lab: Working with Joins in MySQL
========================================================

Author   : Chavi Jain
Database : HR
Software : MySQL + phpMyAdmin + VS Code

========================================================
OBJECTIVES
========================================================

After completing this lab, you will be able to:

1. Write SQL queries using INNER JOIN
2. Write SQL queries using LEFT OUTER JOIN
3. Write SQL queries using RIGHT OUTER JOIN
4. Write SQL queries using FULL OUTER JOIN
5. Retrieve data from multiple tables

========================================================
WHAT ARE JOINS?
========================================================

A JOIN in SQL is used to combine rows from two or
more tables based on a related column.

JOINs help retrieve related data stored in multiple
tables using a single query.

========================================================
TYPES OF JOINS
========================================================

1. INNER JOIN
   -> Returns matching rows from both tables.

2. LEFT OUTER JOIN
   -> Returns all rows from left table and matching
      rows from right table.

3. RIGHT OUTER JOIN
   -> Returns all rows from right table and matching
      rows from left table.

4. FULL OUTER JOIN
   -> Returns all rows from both tables.

========================================================
DATABASE USED
========================================================

Database Name : HR

Tables Used:
1. EMPLOYEES
2. JOB_HISTORY
3. JOBS
4. DEPARTMENTS
5. LOCATIONS

========================================================
STEP 1: CREATE EMPLOYEES TABLE
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
STEP 2: CREATE JOB_HISTORY TABLE
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
STEP 3: CREATE JOBS TABLE
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
STEP 4: CREATE DEPARTMENTS TABLE
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
STEP 5: CREATE LOCATIONS TABLE
========================================================
*/

CREATE TABLE LOCATIONS (
    LOCT_ID CHAR(9) NOT NULL,
    DEP_ID_LOC CHAR(9) NOT NULL,
    PRIMARY KEY (LOCT_ID, DEP_ID_LOC)
);

/*
========================================================
LOAD DATABASE
========================================================

Load the following CSV files into phpMyAdmin:

1. Departments.csv
2. Jobs.csv
3. JobsHistory.csv
4. Locations.csv
5. Employees.csv

========================================================
INNER JOIN
========================================================

INNER JOIN returns only matching rows from both tables.

========================================================
EXAMPLE 1
========================================================

Retrieve:
- Employee First Name
- Employee Last Name
- Job Start Date

for employees working in department 5.

Tables Used:
1. EMPLOYEES
2. JOB_HISTORY

========================================================
QUERY
========================================================
*/

SELECT
    E.F_NAME,
    E.L_NAME,
    JH.START_DATE
FROM EMPLOYEES AS E
INNER JOIN JOB_HISTORY AS JH
ON E.EMP_ID = JH.EMPL_ID
WHERE E.DEP_ID = '5';

/*
========================================================
EXPLANATION
========================================================

1. INNER JOIN combines matching rows.

2. Matching Condition:
   EMPLOYEES.EMP_ID = JOB_HISTORY.EMPL_ID

3. WHERE clause filters employees from department 5.

========================================================
LEFT OUTER JOIN
========================================================

LEFT JOIN returns:
- All rows from left table
- Matching rows from right table

If no match exists, NULL values are shown.

========================================================
EXAMPLE 2
========================================================

Retrieve:
- Employee ID
- Last Name
- Department ID
- Department Name

for all employees.

Tables Used:
1. EMPLOYEES
2. DEPARTMENTS

========================================================
QUERY
========================================================
*/

SELECT
    E.EMP_ID,
    E.L_NAME,
    E.DEP_ID,
    D.DEP_NAME
FROM EMPLOYEES AS E
LEFT OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID = D.DEPT_ID_DEP;

/*
========================================================
EXPLANATION
========================================================

1. LEFT JOIN returns all employees.

2. Department details appear only if matching
   department exists.

3. Non-matching department data becomes NULL.

========================================================
RIGHT OUTER JOIN
========================================================

RIGHT JOIN returns:
- All rows from right table
- Matching rows from left table

========================================================
EXAMPLE 3
========================================================

Retrieve:
- Department Name
- Employee First Name
- Employee Last Name

for all departments.

========================================================
QUERY
========================================================
*/

SELECT
    D.DEP_NAME,
    E.F_NAME,
    E.L_NAME
FROM EMPLOYEES AS E
RIGHT OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID = D.DEPT_ID_DEP;

/*
========================================================
FULL OUTER JOIN
========================================================

MySQL does NOT directly support FULL OUTER JOIN.

We simulate FULL OUTER JOIN using:
LEFT JOIN + RIGHT JOIN + UNION

========================================================
EXAMPLE 4
========================================================

Retrieve:
- Employee First Name
- Employee Last Name
- Department Name

for all employees and departments.

========================================================
QUERY
========================================================
*/

SELECT
    E.F_NAME,
    E.L_NAME,
    D.DEP_NAME
FROM EMPLOYEES AS E
LEFT OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID = D.DEPT_ID_DEP

UNION

SELECT
    E.F_NAME,
    E.L_NAME,
    D.DEP_NAME
FROM EMPLOYEES AS E
RIGHT OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID = D.DEPT_ID_DEP;

/*
========================================================
EXPLANATION
========================================================

1. LEFT JOIN retrieves all employees.

2. RIGHT JOIN retrieves all departments.

3. UNION combines both result sets.

4. Missing matches display NULL values.

========================================================
PRACTICE PROBLEM 1
========================================================

Retrieve:
- Employee Names
- Job Start Dates
- Job Titles

for employees working in department 5.

Perform INNER JOIN using:
1. EMPLOYEES
2. JOB_HISTORY
3. JOBS

========================================================
SOLUTION
========================================================
*/

SELECT
    E.F_NAME,
    E.L_NAME,
    JH.START_DATE,
    J.JOB_TITLE
FROM EMPLOYEES AS E

INNER JOIN JOB_HISTORY AS JH
ON E.EMP_ID = JH.EMPL_ID

INNER JOIN JOBS AS J
ON E.JOB_ID = J.JOB_IDENT

WHERE E.DEP_ID = '5';

/*
========================================================
EXPLANATION
========================================================

1. EMPLOYEES joined with JOB_HISTORY
2. EMPLOYEES joined with JOBS
3. Department filtered using WHERE clause

========================================================
PRACTICE PROBLEM 2
========================================================

Retrieve:
- Employee ID
- Last Name
- Department ID

for all employees

but Department Names only for employees
born before 1980.

========================================================
SOLUTION
========================================================
*/

SELECT
    E.EMP_ID,
    E.L_NAME,
    E.DEP_ID,
    D.DEP_NAME
FROM EMPLOYEES AS E

LEFT OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID = D.DEPT_ID_DEP
AND YEAR(E.B_DATE) < 1980;

/*
========================================================
EXPLANATION
========================================================

1. LEFT JOIN returns all employees.

2. Department name appears only for employees
   born before 1980.

3. YEAR(E.B_DATE) extracts birth year.

========================================================
PRACTICE PROBLEM 3
========================================================

Retrieve:
- First Name
- Last Name

for all employees

but Department ID and Department Name
only for male employees.

========================================================
SOLUTION
========================================================
*/

SELECT
    E.F_NAME,
    E.L_NAME,
    D.DEPT_ID_DEP,
    D.DEP_NAME
FROM EMPLOYEES AS E

LEFT OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID = D.DEPT_ID_DEP
AND E.SEX = 'M';

/*
========================================================
EXPLANATION
========================================================

1. All employees are displayed.

2. Department details appear only for male employees.

3. Female employees will show NULL department values.

========================================================
IMPORTANT SQL KEYWORDS USED
========================================================

1. INNER JOIN
   -> Returns matching rows only

2. LEFT OUTER JOIN
   -> Returns all rows from left table

3. RIGHT OUTER JOIN
   -> Returns all rows from right table

4. FULL OUTER JOIN
   -> Returns all rows from both tables

5. UNION
   -> Combines result sets

6. ON
   -> Defines join condition

========================================================
ADVANTAGES OF JOINS
========================================================

1. Retrieve related data efficiently
2. Reduce data redundancy
3. Simplify complex queries
4. Improve database normalization
5. Enable multi-table analysis

========================================================
CONCLUSION
========================================================

In this lab, we learned:

1. How to use INNER JOIN
2. How to use LEFT OUTER JOIN
3. How to use RIGHT OUTER JOIN
4. How to simulate FULL OUTER JOIN in MySQL
5. How to query multiple tables together

JOIN operations are essential for relational
database management and data analysis.

========================================================
END OF FILE
========================================================