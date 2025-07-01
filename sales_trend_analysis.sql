
/*
 * SALES TREND ANALYSIS — Monthly Revenue & Order Volume
 * Compatible with PostgreSQL, MySQL/MariaDB, and SQLite
 * -----------------------------------------------------
 * STEP 1 (optional) : create & load the 'sales' table
 * -------------------------------------------------- */
CREATE TABLE IF NOT EXISTS sales (
    ordernumber     INTEGER,
    orderdate       DATE,          -- use TIMESTAMP if you store time‑of‑day
    quantityordered INTEGER,
    priceeach       DECIMAL(10,2),
    sales           DECIMAL(12,2),
    PRIMARY KEY     (ordernumber, orderdate)    -- one row per line‑item
);

/* --------------------------------------------------
 * STEP 2 : monthly revenue & unique order count
 * -------------------------------------------------- */

/* ---------- PostgreSQL ---------- */
SELECT
    EXTRACT(YEAR  FROM orderdate)              AS year,
    EXTRACT(MONTH FROM orderdate)              AS month,
    SUM(sales)                                 AS total_revenue,
    COUNT(DISTINCT ordernumber)                AS total_orders
FROM sales
GROUP BY year, month
ORDER BY year, month;

/* ---------- MySQL / MariaDB ----- */
SELECT
    YEAR(orderdate)                            AS year,
    MONTH(orderdate)                           AS month,
    SUM(sales)                                 AS total_revenue,
    COUNT(DISTINCT ordernumber)                AS total_orders
FROM sales
GROUP BY year, month
ORDER BY year, month;

/* ---------- SQLite -------------- */
SELECT
    CAST(strftime('%Y', orderdate) AS INTEGER) AS year,
    CAST(strftime('%m', orderdate) AS INTEGER) AS month,
    SUM(sales)                                 AS total_revenue,
    COUNT(DISTINCT ordernumber)                AS total_orders
FROM sales
GROUP BY year, month
ORDER BY year, month;

/* --------------------------------------------------
 * Example: filter for one year
 * WHERE orderdate BETWEEN '2025-01-01' AND '2025-12-31'
 * -------------------------------------------------- */
