/*
============================================================================================
Quality Checks
============================================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency and accuracy
    of the Gold Layer. These checks ensure:
    - Uniqueness of surrogate keys in dimension tables.
    - Referential integrity between fact and dimension tables.
    - Validation of relationships in the data model for analytical purposes.
Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepencies found during the checks.
============================================================================================
*/
-- =========================================================================================
-- Checking 'gold.dim_customers'
-- =========================================================================================
--Check for uniqueness of Customer Key in gold.dim_customers
--Expectation: NO Results

SELECT
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- =========================================================================================
-- Checking 'Gold.product_key' 
-- =========================================================================================
-- Check for uniqueness of Product Key in Gold.dim_products
-- Expectation: No results

SELECT
      product_key,
      COUNT(*) AS duplicate_count
FROM Gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- =========================================================================================
-- Checking 'Gold.fact_sales'
-- =========================================================================================
-- Check the data model connectivity between fact and dimensions

SELECT *
FROM Gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN Gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL
