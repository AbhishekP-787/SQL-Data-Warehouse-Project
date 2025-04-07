/*
===========================================================================================================================================
DDL Script : Create Bronze Tables
===========================================================================================================================================
Script Purpose:
    This scirpt creates tables in the 'Bronze' schema, dropping existing tables if they already exist.
    Run this script to re-define the DDL structure of 'Bronze' Tables
===========================================================================================================================================
*/
--1st Table
IF OBJECT_ID ('Bronze.crm_cust_info' , 'U') IS NOT NULL
    DROP TABLE 
	Bronze.crm_cust_info;

GO

CREATE TABLE Bronze.crm_cust_info (
cst_id INT,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_material_status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_date DATE
);

GO

--2nd Table
IF OBJECT_ID ('Bronze.crm_prd_info' , 'U') IS NOT NULL
    DROP TABLE Bronze.crm_prd_info;

GO

CREATE TABLE Bronze.crm_prd_info(
prd_id INT,
pr_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME
);

GO

--3rd Table
IF OBJECT_ID ('Bronze.crm_sales_details' , 'U') IS NOT NULL
    DROP TABLE Bronze.crm_sales_details;

GO

CREATE TABLE Bronze.crm_sales_details(
sls_ord_num	NVARCHAR(50),
sls_prd_key NVARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT
);

GO

--4th Table
IF OBJECT_ID ('Bronze.erp_loc_a101' , 'U') IS NOT NULL
    DROP TABLE Bronze.erp_loc_a101;

GO

CREATE TABLE Bronze.erp_loc_a101(
cid NVARCHAR(50),
cntry NVARCHAR(50)
);

GO

--5th Table
IF OBJECT_ID ('Bronze.erp_cust_az12' , 'U') IS NOT NULL
    DROP TABLE Bronze.erp_cust_az12;

GO

CREATE TABLE Bronze.erp_cust_az12(
cid NVARCHAR(50),
bdate DATE,
gen NVARCHAR(50)
);

GO

--6th Table
IF OBJECT_ID ('Bronze.erp_px_cat_g1v2' , 'U') IS NOT NULL
    DROP TABLE Bronze.erp_px_cat_g1v2;

GO

CREATE TABLE Bronze.erp_px_cat_g1v2(
id NVARCHAR(50),
cat NVARCHAR(50),
subcat NVARCHAR(50),
maintenance NVARCHAR(50)
);

GO
