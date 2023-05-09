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
    m.maint_cost,
    m.maint_desc,   
    to_char(maint_datetime, 'dd-Mon-yyyy HH24:MI:SS') AS maint_date_time,
    p.prop_address,
    o.owner_givname 
    || ' ' 
    || o.owner_famname AS owner_name
FROM
    MAINTENANCE m
    NATURAL JOIN PROPERTY p
    NATURAL JOIN OWNER o 
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




--Comment out SET ECHO and SPOOL commands before submitting your portfolio
SPOOL OFF
SET ECHO OFF