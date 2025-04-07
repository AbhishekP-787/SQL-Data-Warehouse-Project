/*
===============================================================================================================
Quality Checks
===============================================================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, and stanadardization across the
    'Silver' schemas. It includes checks for :
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================================================
*/

-- ============================================================================================
-- Checking 'Silver.crm_cust_info'
-- ============================================================================================
-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Results
SELECT
    cst_id,
    COUNT(*)
FROM Silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation : No Results
SELECT
    cst_key
FROM Silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Data Standardization & Consistency
SELECT DISTINCT
    cst_marital_status
FROM Silver.crm_cust_info:

-- ============================================================================================
-- Checking 'Silver.crm_prd_info'
-- ============================================================================================
-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Results
SELECT
    prd_id,
    COUNT(*)
FROM Silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT
    prd_nm
FROM Silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for Nulls or Negative Values in Cost
-- Expectation: No Results
SELECT 
    prd_cost
FROM Silver.crm_prd_info
WHERE prd_cost < 1 OR prd_cost IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT
    prd_line
FROM Silver.crm_prd_info;

--Check for Invalid Date Orders (Start Date > End Date)
--Expectation: No Results
SELECT
    *
FROM Silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- ============================================================================================
-- Checking 'Silver.crm_sales_details'
-- ============================================================================================
-- Check for Invalid Dates
-- Expectation: No Invalid Dates

SELECT
    NULLIF(sls_due_dt, 0) AS sls_due_dt
FROM Bronze.crm_sales_details
WHERE sls_due_dt <= 0
    OR LEN(sls_due_dt) != 0
    OR sls_due_dt > 20500101
    OR sls_due_dt < 19000101;

--Check for Invalid Date Orders (Order Date > Shipping/Due Date)
-- Expectation: No Results

SELECT
    *
FROM Silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
  OR sls_order_dt > sls_due_dt;

-- Check Data Consistency : Sales = Quantity * Price
-- Expectation: No Results
SELECT DISTINCT
    sls_sales,
    sls_quantity,
    sls_price
FROM Silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
    OR sls_sales IS NULL
    OR sls_quantity IS NULL
    OR sls_price IS NULL
    OR sls_sales <= 0
    OR sls_quantity <= 0 
    OR sls_price <= 0
ORDER BY sls_sales, sls_quantity , sls_price;

-- ============================================================================================
-- Checking 'Silver.erp_cust_az12'
-- ============================================================================================
-- Identity Out-of-Range Dates
-- Expectation: Birthdates between 1924-01-01 and Today

SELECT DISTINCT
    bdate
FROM Silver.erp_cust_az12
WHERE bdate < '1924-01-01'
    OR bdate > GETDATE();

-- Data Standardization & Consistency
SELECT DISTINCT
    gen
FROM Silver.erp_cust_az12;

-- ============================================================================================
-- Checking 'Silver.erp_loc_a101'
-- ============================================================================================
-- Data Standardization & Consistency
SELECT DISTINCT
    cntry
FROM Silver.erp_loc_a101
ORDER BY cntry;

-- ============================================================================================
-- Checking 'Silver.erp_px_cat_g1v2'
-- ============================================================================================
-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT
    *
FROM Silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
    OR subcat != TRIM(subcat)
    OR maintenance != TRIM(maintenance);

-- Data Standardization & Consistency
SELECT DISTINCT
    maintenance
FROM Silver.erp_px_cat_g1v2;

