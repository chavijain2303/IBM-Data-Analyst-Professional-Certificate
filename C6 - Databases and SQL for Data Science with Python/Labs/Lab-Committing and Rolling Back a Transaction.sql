/*
========================================================
Hands-on Lab: Committing and Rolling Back a Transaction
========================================================

Author   : Chavi Jain
Database : MYSQL_LEARNERS
Software : MySQL + phpMyAdmin + VS Code

========================================================
OBJECTIVES
========================================================

After completing this lab, you will be able to:

1. Perform database transactions
2. Use COMMIT command
3. Use ROLLBACK command
4. Create transaction-based stored procedures
5. Understand ACID properties

========================================================
WHAT IS A TRANSACTION?
========================================================

A Transaction is a sequence of SQL operations
performed as a single logical unit of work.

A transaction follows ACID properties:

1. Atomicity
   -> Either all operations succeed or none.

2. Consistency
   -> Database remains valid before and after transaction.

3. Isolation
   -> Transactions do not interfere with each other.

4. Durability
   -> Committed changes are permanently saved.

========================================================
IMPORTANT TCL COMMANDS
========================================================

1. START TRANSACTION
   -> Begins a transaction

2. COMMIT
   -> Permanently saves changes

3. ROLLBACK
   -> Undoes unsaved changes

========================================================
DATABASE USED
========================================================

Database Name : MYSQL_LEARNERS

Tables Used:
1. BankAccounts
2. ShoeShop

========================================================
STEP 1: CREATE TABLE BankAccounts
========================================================
*/

DROP TABLE IF EXISTS BankAccounts;

CREATE TABLE BankAccounts (
    AccountNumber VARCHAR(5) NOT NULL,
    AccountName VARCHAR(25) NOT NULL,
    Balance DECIMAL(8,2) CHECK(Balance >= 0) NOT NULL,
    PRIMARY KEY (AccountNumber)
);

/*
========================================================
INSERT DATA INTO BankAccounts
========================================================
*/

INSERT INTO BankAccounts VALUES
('B001','Rose',300),
('B002','James',1345),
('B003','Shoe Shop',124200),
('B004','Corner Shop',76000);

/*
========================================================
DISPLAY BankAccounts TABLE
========================================================
*/

SELECT * FROM BankAccounts;

/*
========================================================
EXPECTED OUTPUT
========================================================

+---------------+--------------+-----------+
| AccountNumber | AccountName  | Balance   |
+---------------+--------------+-----------+
| B001          | Rose         | 300.00    |
| B002          | James        | 1345.00   |
| B003          | Shoe Shop    | 124200.00 |
| B004          | Corner Shop  | 76000.00  |
+---------------+--------------+-----------+

========================================================
STEP 2: CREATE TABLE ShoeShop
========================================================
*/

DROP TABLE IF EXISTS ShoeShop;

CREATE TABLE ShoeShop (
    Product VARCHAR(25) NOT NULL,
    Stock INTEGER NOT NULL,
    Price DECIMAL(8,2) CHECK(Price > 0) NOT NULL,
    PRIMARY KEY (Product)
);

/*
========================================================
INSERT DATA INTO ShoeShop
========================================================
*/

INSERT INTO ShoeShop VALUES
('Boots',11,200),
('High heels',8,600),
('Brogues',10,150),
('Trainers',14,300);

/*
========================================================
DISPLAY ShoeShop TABLE
========================================================
*/

SELECT * FROM ShoeShop;

/*
========================================================
EXPECTED OUTPUT
========================================================

+-------------+-------+-------+
| Product     | Stock | Price |
+-------------+-------+-------+
| Boots       | 11    | 200   |
| High heels  | 8     | 600   |
| Brogues     | 10    | 150   |
| Trainers    | 14    | 300   |
+-------------+-------+-------+

========================================================
SAMPLE EXERCISE
========================================================

SCENARIO:
Rose buys:
1. One pair of Boots
2. Attempt to buy one pair of Trainers

Operations Required:
1. Deduct money from Rose account
2. Add money to Shoe Shop account
3. Reduce stock from ShoeShop table

If any operation fails:
-> Entire transaction must rollback

========================================================
CREATE STORED PROCEDURE TRANSACTION_ROSE
========================================================
*/

DELIMITER //

CREATE PROCEDURE TRANSACTION_ROSE()

BEGIN

    /*
    ====================================================
    ERROR HANDLER
    ====================================================

    If any SQL error occurs:
    1. Rollback all changes
    2. Show the error again
    */

    DECLARE EXIT HANDLER FOR SQLEXCEPTION

    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    /*
    ====================================================
    START TRANSACTION
    ====================================================
    */

    START TRANSACTION;

    /*
    ====================================================
    STEP 1:
    Deduct 200 from Rose account for Boots
    ====================================================
    */

    UPDATE BankAccounts
    SET Balance = Balance - 200
    WHERE AccountName = 'Rose';

    /*
    ====================================================
    STEP 2:
    Add 200 to Shoe Shop account
    ====================================================
    */

    UPDATE BankAccounts
    SET Balance = Balance + 200
    WHERE AccountName = 'Shoe Shop';

    /*
    ====================================================
    STEP 3:
    Reduce Boots stock by 1
    ====================================================
    */

    UPDATE ShoeShop
    SET Stock = Stock - 1
    WHERE Product = 'Boots';

    /*
    ====================================================
    STEP 4:
    Attempt to buy Trainers for Rose

    This may fail due to insufficient balance.
    ====================================================
    */

    UPDATE BankAccounts
    SET Balance = Balance - 300
    WHERE AccountName = 'Rose';

    /*
    ====================================================
    SAVE CHANGES
    ====================================================
    */

    COMMIT;

END //

DELIMITER ;

/*
========================================================
EXECUTE STORED PROCEDURE
========================================================
*/

CALL TRANSACTION_ROSE();

/*
========================================================
CHECK UPDATED TABLES
========================================================
*/

SELECT * FROM BankAccounts;

SELECT * FROM ShoeShop;

/*
========================================================
EXPLANATION
========================================================

1. Rose initially has:
   300

2. After buying Boots:
   300 - 200 = 100

3. Boots stock:
   11 - 1 = 10

4. Shoe Shop balance:
   124200 + 200 = 124400

5. Then Rose attempts to buy Trainers:
   100 - 300 = NEGATIVE BALANCE

6. Since balance becomes invalid,
   transaction fails.

7. ROLLBACK occurs automatically.

8. All previous successful changes are undone.

========================================================
RESULT AFTER ROLLBACK
========================================================

BankAccounts table remains unchanged.
ShoeShop table remains unchanged.

========================================================
PRACTICE EXERCISE
========================================================

SCENARIO:
James wants to buy:

1. Four pairs of Trainers
2. One pair of Brogues

Operations Required:
1. Deduct amount from James account
2. Add amount to Shoe Shop account
3. Reduce Trainers stock
4. Reduce Brogues stock

If any query fails:
-> Entire transaction rolls back

========================================================
SOLUTION:
CREATE PROCEDURE TRANSACTION_JAMES
========================================================
*/

DELIMITER //

CREATE PROCEDURE TRANSACTION_JAMES()

BEGIN

    /*
    ====================================================
    ERROR HANDLER
    ====================================================
    */

    DECLARE EXIT HANDLER FOR SQLEXCEPTION

    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    /*
    ====================================================
    START TRANSACTION
    ====================================================
    */

    START TRANSACTION;

    /*
    ====================================================
    STEP 1:
    James buys 4 Trainers

    Price of one Trainer = 300
    Total Cost = 4 × 300 = 1200
    ====================================================
    */

    UPDATE BankAccounts
    SET Balance = Balance - 1200
    WHERE AccountName = 'James';

    /*
    ====================================================
    STEP 2:
    Add money to Shoe Shop
    ====================================================
    */

    UPDATE BankAccounts
    SET Balance = Balance + 1200
    WHERE AccountName = 'Shoe Shop';

    /*
    ====================================================
    STEP 3:
    Reduce Trainers stock by 4
    ====================================================
    */

    UPDATE ShoeShop
    SET Stock = Stock - 4
    WHERE Product = 'Trainers';

    /*
    ====================================================
    STEP 4:
    James buys one pair of Brogues

    Price = 150
    ====================================================
    */

    UPDATE BankAccounts
    SET Balance = Balance - 150
    WHERE AccountName = 'James';

    /*
    ====================================================
    STEP 5:
    Add money to Shoe Shop
    ====================================================
    */

    UPDATE BankAccounts
    SET Balance = Balance + 150
    WHERE AccountName = 'Shoe Shop';

    /*
    ====================================================
    STEP 6:
    Reduce Brogues stock by 1
    ====================================================
    */

    UPDATE ShoeShop
    SET Stock = Stock - 1
    WHERE Product = 'Brogues';

    /*
    ====================================================
    COMMIT TRANSACTION
    ====================================================
    */

    COMMIT;

END //

DELIMITER ;

/*
========================================================
EXECUTE TRANSACTION_JAMES
========================================================
*/

CALL TRANSACTION_JAMES();

/*
========================================================
CHECK UPDATED TABLES
========================================================
*/

SELECT * FROM BankAccounts;

SELECT * FROM ShoeShop;

/*
========================================================
EXPECTED CALCULATIONS
========================================================

James Initial Balance:
1345

Cost of 4 Trainers:
4 × 300 = 1200

Remaining Balance:
1345 - 1200 = 145

Cost of Brogues:
150

James balance becomes:
145 - 150 = NEGATIVE

Transaction fails.

ROLLBACK occurs.

========================================================
FINAL RESULT
========================================================

1. No changes saved permanently
2. Trainers stock unchanged
3. Brogues stock unchanged
4. James balance unchanged
5. Shoe Shop balance unchanged

========================================================
IMPORTANT SQL COMMANDS USED
========================================================

1. START TRANSACTION
   -> Begins transaction

2. COMMIT
   -> Saves changes permanently

3. ROLLBACK
   -> Undo changes

4. UPDATE
   -> Modify records

5. CREATE PROCEDURE
   -> Create stored procedure

6. CALL
   -> Execute procedure

========================================================
ADVANTAGES OF TRANSACTIONS
========================================================

1. Ensures data consistency
2. Prevents partial updates
3. Maintains database integrity
4. Handles system failures safely
5. Supports reliable business operations

========================================================
CONCLUSION
========================================================

In this lab, we learned:

1. How to perform transactions
2. How to use COMMIT
3. How to use ROLLBACK
4. How to create transaction-based procedures
5. How transactions maintain database integrity

Transactions are essential in banking systems,
shopping systems, and real-world applications
where data consistency is critical.

========================================================
END OF FILE
========================================================