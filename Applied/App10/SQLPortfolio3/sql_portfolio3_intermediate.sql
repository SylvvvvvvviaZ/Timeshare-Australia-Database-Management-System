--Comment out SET ECHO and SPOOL commands before submitting your portfolio
SET ECHO ON
SPOOL sql_portfolio3_intermediate_output.txt

--****PLEASE ENTER YOUR DETAILS BELOW****
--sql_portfolio3_intermediate.sql

--Student ID: 33049246
--Student Name: Xiaowen Zhou
--Unit Code: FIT2094
--Applied Class No: Applied 01, Melbourne Wed 18:00


/*1*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    tenant_no,
    COUNT(dam_no) AS num_damages,
    CONCAT(tenant_title, '. ', tenant_givname, ' ', tenant_famname) AS tenant_name,
    CONCAT('$', CAST(SUM(dam_cost) AS DECIMAL(6, 2))) AS total_cost
FROM
    rent.TENANT t 
    JOIN rent.DAMAGE d 
    ON t.tenant_no = d.rent_agreement_no
WHERE
    to_char(d.dam_datetime, 'YYYY') = '2022'
GROUP BY
    tenant_no, 
    tenant_name
HAVING
    SUM(d.dam_cost) > 0
ORDER BY
    total_cost DESC, 
    tenant_no;

/*2*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer



--Comment out SET ECHO and SPOOL commands before submitting your portfolio
SPOOL OFF
SET ECHO OFF