/*
========================================================
Hands-on Lab: Stored Procedures in MySQL
========================================================

Author   : Chavi Jain
Database : PETS
Software : MySQL + phpMyAdmin + VS Code

========================================================
OBJECTIVES
========================================================

After completing this lab, you will be able to:

1. Create Stored Procedures
2. Execute Stored Procedures
3. Update table data using Stored Procedures
4. Drop/Delete Stored Procedures

========================================================
WHAT IS A STORED PROCEDURE?
========================================================

A Stored Procedure is a precompiled collection of
SQL statements stored inside the database.

Stored Procedures help to:
- Reduce repetitive SQL code
- Improve performance
- Increase productivity
- Maintain business rules
- Improve scalability and security

========================================================
DATABASE USED
========================================================

Database Name : PETS

Table Used :
- PETSALE

========================================================
STEP 1: CREATE DATABASE
========================================================
*/

CREATE DATABASE PETS;
USE PETS;

/*
========================================================
STEP 2: DROP EXISTING TABLE
========================================================
*/

DROP TABLE IF EXISTS PETSALE;

/*
========================================================
STEP 3: CREATE PETSALE TABLE
========================================================
*/

CREATE TABLE PETSALE (
    ID INTEGER NOT NULL,
    ANIMAL VARCHAR(20),
    SALEPRICE DECIMAL(6,2),
    SALEDATE DATE,
    QUANTITY INTEGER,
    PRIMARY KEY (ID)
);

/*
========================================================
STEP 4: INSERT SAMPLE DATA
========================================================
*/

INSERT INTO PETSALE VALUES
(1,'Cat',450.09,'2018-05-29',9),
(2,'Dog',666.66,'2018-06-01',3),
(3,'Parrot',50.00,'2018-06-04',2),
(4,'Hamster',60.60,'2018-06-11',6),
(5,'Goldfish',48.48,'2018-06-14',24);

/*
========================================================
DISPLAY TABLE DATA
========================================================
*/

SELECT * FROM PETSALE;

/*
========================================================
OUTPUT TABLE
========================================================

+----+----------+-----------+------------+----------+
| ID | ANIMAL   | SALEPRICE | SALEDATE   | QUANTITY |
+----+----------+-----------+------------+----------+
| 1  | Cat      | 450.09    | 2018-05-29 | 9        |
| 2  | Dog      | 666.66    | 2018-06-01 | 3        |
| 3  | Parrot   | 50.00     | 2018-06-04 | 2        |
| 4  | Hamster  | 60.60     | 2018-06-11 | 6        |
| 5  | Goldfish | 48.48     | 2018-06-14 | 24       |
+----+----------+-----------+------------+----------+

========================================================
STORED PROCEDURE: EXERCISE 1
========================================================

Objective:
Create a Stored Procedure named RETRIEVE_ALL
to display all records from PETSALE table.

========================================================
CREATE STORED PROCEDURE
========================================================
*/

DELIMITER //

CREATE PROCEDURE RETRIEVE_ALL()

BEGIN
    SELECT * FROM PETSALE;
END //

DELIMITER ;

/*
========================================================
NOTES:
========================================================

1. DELIMITER changes the default semicolon (;)
   temporarily.

2. CREATE PROCEDURE creates a stored procedure.

3. RETRIEVE_ALL is the procedure name.

4. BEGIN and END contain SQL statements.

========================================================
CALL/EXECUTE STORED PROCEDURE
========================================================
*/

CALL RETRIEVE_ALL();

/*
========================================================
EXPECTED OUTPUT:
========================================================

All rows from PETSALE table will be displayed.

========================================================
VIEW CREATED PROCEDURE
========================================================

In phpMyAdmin:
Database -> PETS -> Procedures/Routines

========================================================
DROP STORED PROCEDURE
========================================================
*/

DROP PROCEDURE RETRIEVE_ALL;

/*
========================================================
VERIFY PROCEDURE DELETION
========================================================
*/

CALL RETRIEVE_ALL();

/*
========================================================
EXPECTED RESULT:
========================================================

Error occurs because procedure no longer exists.

========================================================
STORED PROCEDURE: EXERCISE 2
========================================================

Objective:
Create a Stored Procedure named UPDATE_SALEPRICE
to update animal sale prices based on health condition.

========================================================
CONDITIONS:
========================================================

1. BAD Health:
   Reduce sale price by 25%

2. WORSE Health:
   Reduce sale price by 50%

3. Other Health Conditions:
   No change in sale price

========================================================
PARAMETERS USED:
========================================================

1. Animal_ID
2. Animal_Health

========================================================
CREATE PROCEDURE UPDATE_SALEPRICE
========================================================
*/

DELIMITER @

CREATE PROCEDURE UPDATE_SALEPRICE (
    IN Animal_ID INTEGER,
    IN Animal_Health VARCHAR(10)
)

BEGIN

    IF Animal_Health = 'BAD' THEN

        UPDATE PETSALE
        SET SALEPRICE = SALEPRICE - (SALEPRICE * 0.25)
        WHERE ID = Animal_ID;

    ELSEIF Animal_Health = 'WORSE' THEN

        UPDATE PETSALE
        SET SALEPRICE = SALEPRICE - (SALEPRICE * 0.50)
        WHERE ID = Animal_ID;

    ELSE

        UPDATE PETSALE
        SET SALEPRICE = SALEPRICE
        WHERE ID = Animal_ID;

    END IF;

END @

DELIMITER ;

/*
========================================================
NOTES:
========================================================

1. IN keyword defines input parameters.

2. IF-ELSEIF-ELSE is used for conditions.

3. UPDATE statement modifies table data.

4. Procedure accepts:
   - Animal ID
   - Animal Health Status

========================================================
RECREATE RETRIEVE_ALL PROCEDURE
========================================================

If RETRIEVE_ALL was dropped earlier,
recreate it before testing UPDATE_SALEPRICE.

========================================================
*/

DELIMITER //

CREATE PROCEDURE RETRIEVE_ALL()

BEGIN
    SELECT * FROM PETSALE;
END //

DELIMITER ;

/*
========================================================
EXECUTE PROCEDURE:
UPDATE SALE PRICE FOR BAD HEALTH
========================================================

Animal ID : 1
Health    : BAD

Expected:
Reduce sale price by 25%

========================================================
DISPLAY DATA BEFORE UPDATE
========================================================
*/

CALL RETRIEVE_ALL();

/*
========================================================
UPDATE SALE PRICE
========================================================
*/

CALL UPDATE_SALEPRICE(1, 'BAD');

/*
========================================================
DISPLAY DATA AFTER UPDATE
========================================================
*/

CALL RETRIEVE_ALL();

/*
========================================================
EXPECTED CALCULATION
========================================================

Original Price = 450.09

Reduction = 25%
          = 450.09 × 0.25
          = 112.52

New Price = 450.09 - 112.52
          = 337.57

========================================================
EXECUTE PROCEDURE:
UPDATE SALE PRICE FOR WORSE HEALTH
========================================================

Animal ID : 3
Health    : WORSE

Expected:
Reduce sale price by 50%

========================================================
DISPLAY DATA BEFORE UPDATE
========================================================
*/

CALL RETRIEVE_ALL();

/*
========================================================
UPDATE SALE PRICE
========================================================
*/

CALL UPDATE_SALEPRICE(3, 'WORSE');

/*
========================================================
DISPLAY DATA AFTER UPDATE
========================================================
*/

CALL RETRIEVE_ALL();

/*
========================================================
EXPECTED CALCULATION
========================================================

Original Price = 50.00

Reduction = 50%
          = 25.00

New Price = 25.00

========================================================
VIEW CREATED PROCEDURE
========================================================

In phpMyAdmin:
Database -> PETS -> Procedures/Routines

You can view:
1. RETRIEVE_ALL
2. UPDATE_SALEPRICE

========================================================
DROP UPDATE_SALEPRICE PROCEDURE
========================================================
*/

DROP PROCEDURE UPDATE_SALEPRICE;

/*
========================================================
VERIFY PROCEDURE DELETION
========================================================
*/

CALL UPDATE_SALEPRICE(1, 'BAD');

/*
========================================================
EXPECTED RESULT:
========================================================

Error occurs because procedure no longer exists.

========================================================
IMPORTANT SQL COMMANDS USED
========================================================

1. CREATE DATABASE
   -> Creates a database

2. CREATE TABLE
   -> Creates a table

3. INSERT INTO
   -> Inserts records into table

4. SELECT
   -> Retrieves data

5. CREATE PROCEDURE
   -> Creates stored procedure

6. CALL
   -> Executes stored procedure

7. DROP PROCEDURE
   -> Deletes stored procedure

8. UPDATE
   -> Modifies existing records

========================================================
ADVANTAGES OF STORED PROCEDURES
========================================================

1. Faster execution
2. Code reusability
3. Reduced network traffic
4. Better security
5. Easier maintenance
6. Enforces business logic

========================================================
CONCLUSION
========================================================

In this lab, we learned:

1. How to create stored procedures
2. How to execute stored procedures
3. How to pass parameters to procedures
4. How to update table data using procedures
5. How to delete stored procedures

Stored Procedures help automate database tasks
and improve efficiency in SQL applications.

========================================================
END OF FILE
========================================================