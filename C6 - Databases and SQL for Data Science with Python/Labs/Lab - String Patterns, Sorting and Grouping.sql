-- =====================================================
-- HR DATABASE (SQLITE VERSION)
-- =====================================================

PRAGMA foreign_keys = ON;

-- =====================================================
-- TABLE 1: EMPLOYEES
-- =====================================================

CREATE TABLE IF NOT EXISTS EMPLOYEES (
    EMP_ID TEXT PRIMARY KEY,
    F_NAME TEXT NOT NULL,
    L_NAME TEXT NOT NULL,
    SSN TEXT,
    B_DATE TEXT,
    SEX TEXT,
    ADDRESS TEXT,
    JOB_ID TEXT,
    SALARY REAL,
    MANAGER_ID TEXT,
    DEP_ID TEXT NOT NULL
);

-- =====================================================
-- TABLE 2: JOB_HISTORY
-- =====================================================

CREATE TABLE IF NOT EXISTS JOB_HISTORY (
    EMPL_ID TEXT NOT NULL,
    START_DATE TEXT,
    JOBS_ID TEXT NOT NULL,
    DEPT_ID TEXT,
    PRIMARY KEY (EMPL_ID, JOBS_ID),
    FOREIGN KEY (EMPL_ID) REFERENCES EMPLOYEES(EMP_ID),
    FOREIGN KEY (JOBS_ID) REFERENCES JOBS(JOB_IDENT),
    FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENTS(DEPT_ID_DEP)
);

-- =====================================================
-- TABLE 3: JOBS
-- =====================================================

CREATE TABLE IF NOT EXISTS JOBS (
    JOB_IDENT TEXT PRIMARY KEY,
    JOB_TITLE TEXT,
    MIN_SALARY REAL,
    MAX_SALARY REAL
);

-- =====================================================
-- TABLE 4: DEPARTMENTS
-- =====================================================

CREATE TABLE IF NOT EXISTS DEPARTMENTS (
    DEPT_ID_DEP TEXT PRIMARY KEY,
    DEP_NAME TEXT,
    MANAGER_ID TEXT,
    LOC_ID TEXT,
    FOREIGN KEY (LOC_ID) REFERENCES LOCATIONS(LOCT_ID)
);

-- =====================================================
-- TABLE 5: LOCATIONS
-- =====================================================

CREATE TABLE IF NOT EXISTS LOCATIONS (
    LOCT_ID TEXT PRIMARY KEY,
    DEP_ID_LOC TEXT
);

-- =====================================================
-- FOREIGN KEYS FOR EMPLOYEES
-- =====================================================

-- SQLite requires FK inside table or recreate table,
-- but SQLTools allows execution without strict FK enforcement
-- so we keep logical consistency.

-- =====================================================
-- STRING PATTERNS
-- =====================================================

-- 1. Employees living in Elgin, IL
SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE ADDRESS LIKE '%Elgin,IL%';

-- 2. Employees born in 1970s
SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE B_DATE LIKE '197%';

-- 3. Employees in department 5 with salary between 60000 and 70000
SELECT *
FROM EMPLOYEES
WHERE SALARY BETWEEN 60000 AND 70000
AND DEP_ID = '5';

-- =====================================================
-- SORTING
-- =====================================================

SELECT F_NAME, L_NAME, DEP_ID
FROM EMPLOYEES
ORDER BY DEP_ID;

SELECT F_NAME, L_NAME, DEP_ID
FROM EMPLOYEES
ORDER BY DEP_ID DESC, L_NAME DESC;

-- =====================================================
-- GROUPING
-- =====================================================

SELECT DEP_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEP_ID;

SELECT DEP_ID, COUNT(*), AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEP_ID;

SELECT 
    DEP_ID, 
    COUNT(*) AS NUM_EMPLOYEES, 
    AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID;

SELECT 
    DEP_ID, 
    COUNT(*) AS NUM_EMPLOYEES, 
    AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID
ORDER BY AVG_SALARY;

SELECT 
    DEP_ID, 
    COUNT(*) AS NUM_EMPLOYEES, 
    AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING COUNT(*) < 4
ORDER BY AVG_SALARY;

-- =====================================================
-- PRACTICE
-- =====================================================

SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE F_NAME LIKE 'S%';

SELECT *
FROM EMPLOYEES
ORDER BY B_DATE;

SELECT 
    DEP_ID, 
    AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING AVG(SALARY) >= 60000;

SELECT 
    DEP_ID, 
    AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING AVG(SALARY) >= 60000
ORDER BY AVG_SALARY DESC;