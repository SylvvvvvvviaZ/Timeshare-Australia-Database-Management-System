/*
Databases Week 10 Applied Class
week10_sql_intermediate.sql

student id: 33049246
student name: Xiaowen Zhou
last modified date: 15 May 2023

*/

--1 Find the maximum mark for FIT9136 in semester 2, 2019.

SELECT
    MAX(enrolmark) AS max_mark
FROM
    uni.enrolment
WHERE
        upper(unitcode) = 'FIT9136'
    AND ofsemester = 2
    AND to_char(ofyear, 'YYYY') = '2019';
    
--2 Find the average mark for FIT2094 in semester 2, 2020. 
-- Show the average mark with two decimal places. Name the output column as average_mark.

SELECT
    to_char(AVG(enrolmark), '990.00') AS average_mark
FROM
    uni.enrolment
WHERE
    upper(unitcode) = 'FIT2094'
    AND ofsemester = 2
    AND to_char(ofyear, 'YYYY') = '2020';
    
--3 List the average mark for each offering of FIT9136. 
-- A unit offering is an instance of a particular unit in a particular semester - for example FIT1045 offered in semester 1 of 2019 - is a unit offering. 
-- In the listing, include the year and semester number. 
-- Sort the result according to the year then the semester.

SELECT
    to_char(ofyear, 'YYYY') AS year,
    ofsemester,
    to_char(AVG(enrolmark), '990.0') AS average_mark
FROM
    uni.enrolment
WHERE
    upper(unitcode) = 'FIT9136'
GROUP BY
    to_char(ofyear, 'YYYY'),
    ofsemester
ORDER BY
    year,
    ofsemester;


--4 Find the number of students enrolled in FIT1045 in the year 2019, under the following conditions (note two separate selects are required):

-- a.Repeat students are counted multiple times in each semester of 2019

SELECT
    COUNT(stuid) AS student_count
FROM
    uni.enrolment
WHERE
    upper(unitcode) = 'FIT1045'
    AND to_char(ofyear, 'YYYY') = '2019';

-- b. Repeat students are only counted once across 2019

SELECT
    COUNT(DISTINCT stuid) AS student_count  -- It counts the distinct student IDs.
FROM
    uni.enrolment
WHERE
    upper(unitcode) = 'FIT1045'
    AND to_char(ofyear, 'YYYY') = '2019';


--5 Find the total number of prerequisite units for FIT5145.

SELECT
    COUNT(prerequnitcode) AS no_prereqs
FROM
    uni.prereq
WHERE
    upper(unitcode) = 'FIT5145';


--6



--7



--8



--9



--10




--11



--12



--13







