--Comment out SET ECHO and SPOOL commands before submitting your portfolio
SET ECHO ON
SPOOL sql_portfolio2_basic_output.txt

--****PLEASE ENTER YOUR DETAILS BELOW****
--sql_portfolio2_basic.sql

--Student ID: 33049246
--Student Name: Xiaowen Zhou
--Unit Code: FIT2094
--Applied Class No: Applied 01, Melbourne Wed 18:00


/*1*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    m.maint_id,
    m.maint_desc,
    m.maint_cost,
    to_char(maint_datetime, 'dd-Mon-yyyy HH24:MI:SS') AS maint_date_time,
    p.prop_address,
    o.owner_givname
    || ' '
    || o.owner_famname AS owner_name
FROM
    rent.maintenance m
    NATURAL JOIN property p
    NATURAL JOIN owner    o
WHERE
    m.maint_cost BETWEEN 1000 AND 3000
    AND m.maint_assigned = 'Y'
ORDER BY
    m.maint_cost DESC,
    m.maint_datetime DESC;

/*2*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    r.rent_agreement_no,
    t.tenant_no, 
    t.tenant_title 
    || '. ' 
    || t.tenant_givname 
    || ' ' 
    || t.tenant_famname AS tenant_name,
    p.prop_address,
    o.owner_givname
    || ' ' 
    || o.owner_famname AS owner_name, 
    r.rent_lease_period 
    || ' months' AS rent_lease_period 
FROM
    rent.rent r
    JOIN rent.property p ON r.prop_no = p.prop_no 
    JOIN rent.tenant t ON r.tenant_no = t.tenant_no 
    JOIN rent.owner o ON p.owner_no = o.owner_no 
WHERE 
    r.rent_lease_start >= to_date('01-JAN-2022','dd-MON-yyyy')
    AND r.rent_weekly_rate < 425 
    AND r.rent_lease_period >= 6 
ORDER BY 
    r.rent_lease_period DESC, 
    t.tenant_no ASC;

--Comment out SET ECHO and SPOOL commands before submitting your portfolio
SPOOL OFF
SET ECHO OFF