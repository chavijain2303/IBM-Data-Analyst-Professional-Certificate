# Hands-on Lab: Executing SQL Queries

**Course:** IBM Data Analyst Professional Certificate  
**Module:** SQL Hands-on Lab  
**Lab Title:** Executing SQL Queries using MySQL and phpMyAdmin  
**Estimated Time:** 30 Minutes

---

# Aim

To understand how to create a MySQL database, import CSV datasets into tables, and execute SQL queries to retrieve meaningful information from relational data.

---

# Objectives

After completing this lab, you will be able to:

- Create a MySQL database.
- Import CSV files into database tables.
- Execute SQL queries using phpMyAdmin.
- Retrieve, filter, aggregate, and analyze data using SQL.
- Apply JOIN, GROUP BY, ORDER BY, WHERE, aggregate functions, and window functions.

---

# Software Used

- MySQL
- phpMyAdmin
- IBM Skills Network Labs (SN Labs)

---

# Database Information

**Database Name**

```
Mysql_Learners
```

**Character Set**

```
utf8_general_ci
```

---

# Dataset

The following CSV files were imported into the database.

| Table | File |
|---------|----------------|
| dimdate | dimdate.csv |
| dimtruck | dimtruck.csv |
| dimstation | dimstation.csv |
| facttrips | facttrips.csv |

---

# Procedure

## Task A — Create Database

### Step 1

Start the MySQL service.

### Step 2

Open phpMyAdmin.

### Step 3

Click **New**.

### Step 4

Create a database named

```sql
Mysql_Learners
```

### Step 5

Select

```
utf8_general_ci
```

Click **Create**.

---

## Task B — Import CSV Files

For every CSV file:

1. Select the database.
2. Open the **Import** tab.
3. Browse and select the CSV file.
4. Enable CSV import options.
5. Click **Go**.
6. Verify successful import.

Repeat the process for all four CSV files.

---

# SQL Exercises

---

# Exercise 1

## Objective

List all stations in alphabetical order.

### SQL Query

```sql
SELECT StationId,
       StationName
FROM dimstation
ORDER BY StationName ASC;
```

### Output

| StationId | StationName |
|------------|-------------|
| ... | ... |

---

# Exercise 2

## Objective

List all trips that collected more than 40 units of waste.

### SQL Query

```sql
SELECT TripId,
       Waste
FROM facttrips
WHERE Waste > 40;
```

### Output

| TripId | Waste |
|---------|--------|
| ... | ... |

---

# Exercise 3

## Objective

Find the average waste collected for each date.

### SQL Query

```sql
SELECT DateId,
       AVG(Waste) AS avg_Waste
FROM facttrips
GROUP BY DateId;
```

### Output

| DateId | Avg_Waste |
|---------|------------|
| ... | ... |

---

# Exercise 4

## Objective

Display truck names with their count.

### SQL Query

```sql
SELECT TruckName,
       COUNT(TruckId) AS count_Trucks
FROM dimtruck
GROUP BY TruckName;
```

### Output

| TruckName | Count_Trucks |
|------------|--------------|
| ... | ... |

---

# Exercise 5

## Objective

Display total waste collected by each city.

### SQL Query

```sql
SELECT st.StationName AS CityName,
       SUM(tr.Waste) AS total_Waste
FROM dimstation st
LEFT OUTER JOIN facttrips tr
ON st.StationId = tr.StationId
GROUP BY st.StationName;
```

### Output

| CityName | Total_Waste |
|-----------|-------------|
| ... | ... |

---

# Exercise 6

## Objective

Find the minimum waste collected during each quarter of 2019.

### SQL Query

```sql
SELECT MIN(tr.Waste) AS min_Waste,
       dt.QuarterName
FROM facttrips tr
LEFT OUTER JOIN dimdate dt
ON tr.DateId = dt.DateId
AND dt.Year = 2019
GROUP BY dt.QuarterName;
```

### Output

| QuarterName | Min_Waste |
|--------------|-----------|
| ... | ... |

---

# Exercise 7

## Objective

Find the maximum waste collected in Quarter 1 in Sao Paulo.

### SQL Query

```sql
SELECT dt.QuarterName,
       st.StationName,
       MAX(tr.Waste) AS max_Waste
FROM facttrips tr
LEFT OUTER JOIN dimstation st
ON tr.StationId = st.StationId
LEFT OUTER JOIN dimdate dt
ON tr.DateId = dt.DateId
WHERE dt.QuarterName = 'Q1'
AND st.StationName LIKE '%Sao Paulo%'
GROUP BY dt.QuarterName,
         st.StationName;
```

### Output

| QuarterName | StationName | Max_Waste |
|--------------|-------------|-----------|
| ... | ... | ... |

---

# Exercise 8

## Objective

Find the average waste collected by Volvo trucks for each weekday.

### SQL Query

```sql
SELECT dt.WeekDayName,
       tru.TruckName,
       AVG(tr.Waste) AS avg_Waste
FROM facttrips tr
LEFT OUTER JOIN dimtruck tru
ON tr.TruckId = tru.TruckId
LEFT OUTER JOIN dimdate dt
ON tr.DateId = dt.DateId
WHERE tru.TruckName LIKE '%Volvo%'
GROUP BY dt.WeekDayName,
         tru.TruckName
ORDER BY AVG(tr.Waste) DESC
LIMIT 7;
```

### Output

| WeekDayName | TruckName | Avg_Waste |
|--------------|-----------|-----------|
| ... | ... | ... |

---

# Exercise 9

## Objective

Find the dates on which each city collected its maximum waste.

### SQL Query

```sql
SELECT st.StationName AS City,
       dt.Date,
       a.Waste
FROM
(
    SELECT StationId,
           DateId,
           Waste,
           RANK() OVER
           (
               PARTITION BY StationId
               ORDER BY Waste DESC
           ) AS rnk
    FROM facttrips
) a

LEFT OUTER JOIN dimdate dt
ON a.DateId = dt.DateId

LEFT OUTER JOIN dimstation st
ON a.StationId = st.StationId

WHERE a.rnk = 1;
```

### Output

| City | Date | Waste |
|------|------|--------|
| ... | ... | ... |

---

# SQL Concepts Used

During this lab, the following SQL concepts were practiced:

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- Aggregate Functions
  - COUNT()
  - AVG()
  - SUM()
  - MIN()
  - MAX()
- LEFT OUTER JOIN
- LIKE
- Aliases (AS)
- Window Functions
  - RANK()
- PARTITION BY
- LIMIT

---

# Learning Outcomes

After completing this lab, I learned how to:

- Create databases using phpMyAdmin.
- Import CSV files into MySQL tables.
- Execute SQL queries.
- Filter records using WHERE.
- Sort results using ORDER BY.
- Perform aggregations using GROUP BY.
- Join multiple tables.
- Use aggregate functions for analysis.
- Apply window functions such as RANK().
- Analyze relational datasets using SQL.

---

# Conclusion

This lab provided hands-on experience in working with MySQL databases and executing SQL queries. It strengthened understanding of relational database operations, including filtering, sorting, aggregation, joins, and analytical functions. These SQL techniques are fundamental skills required for data analysts to retrieve and analyze data efficiently.