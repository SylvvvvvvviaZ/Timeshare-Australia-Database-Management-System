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


--Select * From rent.RENT ;

--Select *  From rent.TENANT ;

--Select *  From rent.DAMAGE ;


SELECT
    t.tenant_no,
    t.tenant_title
    || '. '
    || t.tenant_givname
    || ' '
    || t.tenant_famname AS tenant_name,
    COUNT(d.dam_no)     AS num_of_damages,
    to_char(SUM(d.dam_cost), '$9990.99') AS total_cost
FROM
         rent.tenant t
    JOIN rent.rent   r ON t.tenant_no = r.tenant_no
    JOIN rent.damage d ON r.rent_agreement_no = d.rent_agreement_no
WHERE
    to_char(dam_datetime, 'YYYY') = '2022'
GROUP BY
    t.tenant_no,
    tenant_title,
    t.tenant_givname,
    t.tenant_famname
ORDER BY
    total_cost DESC,
    t.tenant_no ASC;

/*2*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    t.tenant_no,
    t.tenant_title 
    || '. ' 
    || t.tenant_givname 
    || ' ' 
    || t.tenant_famname AS tenant_name,
    r.prop_no,
    p.prop_address
FROM
    rent.TENANT t
    JOIN rent.RENT r ON t.tenant_no = r.tenant_no
    JOIN rent.PROPERTY p ON r.prop_no = p.prop_no
WHERE
    p.prop_address = 'Tasmania'
GROUP BY
    t.tenant_no, 
    t.tenant_title,
    t.tenant_givname,
    t.tenant_famname, 
    r.prop_no, 
    p.prop_address
HAVING
    COUNT(r.rent_agreement_no) > 1
ORDER BY
    t.tenant_no ASC;




--Comment out SET ECHO and SPOOL commands before submitting your portfolio
SPOOL OFF
SET ECHO OFF