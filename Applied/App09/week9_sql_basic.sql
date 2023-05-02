/*
Databases Week 9 Applied Class
week9_sql_basic.sql

student id: 33049246
student name:xiaowen zhou
applied class number: Wed8:00am
last modified date:3/5/2023

*/

/* Part A - Retrieving data from a single table */

-- A1 List all units and their details. Order the output by unit code.
SELECT *
FROM uni.unit
--WHERE
ORDER BY unitcode

-- A2 List the full student details for those students who live in Caulfield. Order the output by student id.
SELECT *
FROM uni.student
WHERE UPPER(STUADDRESS) LIKE UPPER (%caufield%)
ORDER BY stuid

-- A3

-- A4 List the student's id, surname, first name and address for those students who have a surname starting with the letter S and first name which contains the letter i. Order the output by student id.
SELECT stuid,stufame as SURAME
FROM uni.student
WHERE UPPER(stulame) LIKE UPPER ('s%')
ORDER BY stuid

-- A5


-- A6 List the unit code and semester of all units that are offered in 2021. Order the output by unit code, and within a given unit code order by semester. To complete this question, you need to use the Oracle function to_char to convert the data type for the year component of the offering date into text. For example, to_char(ofyear,'yyyy') - here we are only using the year part of the date.
SELECT *
FROM UNI.OFFERING
WHERE TO_CHAR(OFYEAR,'YYYY')= '2021'
ORDER BY UNICODE

-- A7


-- A8


-- A9



/* Part B - Retrieving data from multiple tables */

-- B1


-- B2


-- B3


-- B4


-- B5


-- B6


-- B7


-- B8


-- B9


-- B10