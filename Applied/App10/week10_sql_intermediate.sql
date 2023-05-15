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


--6 Find the total number of enrolments per semester for each unit in the year 2019. 
-- The list should include the unit code, semester and the total number of enrolments. 
-- Order the list in increasing order of enrolment numbers. 
-- For units with the same number of enrolments, display them by the unit code order then by the semester order.

SELECT
    unitcode,
    ofsemester,
    COUNT(stuid) AS total_enrolment
FROM
    uni.enrolment
WHERE
    to_char(ofyear, 'YYYY') = '2019'
GROUP BY
    unitcode,
    ofsemester
ORDER BY
    total_enrolment,
    unitcode,
    ofsemester;


--7 Find the total number of prerequisite units for each unit.  
-- In the list, include the unit code for which the count is applicable. Order the list by unit code.

SELECT
    unitcode,
    COUNT(prerequnitcode) AS no_prereqs
FROM
    uni.prereq
GROUP BY
    unitcode
ORDER BY
    unitcode;

--8 Find the total number of students whose marks are being withheld (grade is recorded as WH) for each unit offered in semester 2 2020. 
-- In the listing include the unit code for which the count is applicable. 
-- Sort the list by descending order of the total number of students whose marks are being withheld, then by the unit code.

SELECT
    unitcode,
    COUNT(stuid) AS total_no_students
FROM
    uni.enrolment
WHERE
    ofsemester = 2
    AND to_char(ofyear, 'yyyy') = '2020'
    AND upper(enrolgrade) = 'WH'
GROUP BY
    unitcode
ORDER BY
    total_no_students DESC, unitcode;

--9 For each prerequisite unit, calculate how many times it has been used as a prerequisite (number of times used). 
-- In the listing include the prerequisite unit code, the prerequisite unit name and the number of times used. 
-- Sort the output by prerequisite unit code.

SELECT
    prerequnitcode    AS unitcode,
    u.unitname,
    COUNT(u.unitcode) AS no_times_used
FROM
         uni.prereq p
    JOIN uni.unit u
    ON u.unitcode = p.prerequnitcode
GROUP BY
    prerequnitcode,
    u.unitname
ORDER BY
    unitcode;


--10 Display the unit code and unit name of units which had 
-- at least 2 students who were granted a deferred exam (grade is recorded as DEF) in semester 2 2021. 
-- Order the list by unit code.

SELECT
    unitcode,
    unitname
FROM
         uni.enrolment
    NATURAL JOIN uni.unit
WHERE
        ofsemester = 2
    AND to_char(ofyear, 'yyyy') = '2021'
    AND upper(enrolgrade) = 'DEF'
GROUP BY
    unitcode,
    unitname
HAVING
    COUNT(*) >= 2
ORDER BY
    unitcode;



--11 Find the oldest student/s in FIT9132. Display the student’s id, full name and the date of birth.
-- Sort the list by student id.
SELECT
    s.stuid,
    stufname
    || ' '
    || stulname                   AS fullname,
    to_char(studob, 'dd/mm/yyyy') AS date_of_birth
FROM
         uni.student s
    JOIN uni.enrolment e
    ON s.stuid = e.stuid
WHERE
        upper(e.unitcode) = 'FIT9132'
    AND studob = (
        SELECT
            MIN(studob)
        FROM
                 uni.student s
            JOIN uni.enrolment e
            ON s.stuid = e.stuid
        WHERE
            upper(e.unitcode) = 'FIT9132'
    )
ORDER BY
    s.stuid;



--12 A unit offering is an instance of a particular unit in a particular semester - for example FIT1045 offered in semester 1 of 2019 - is a unit offering. 
-- All unit offerings are listed in the OFFERING table. 
-- Find the unit offering/s with the highest number of enrolments for any unit offering which occurred in the year 2019. 
-- Display the unit code, offering semester andnumber of students enrolled in the offering. 
-- Sort the list by semester then by unit code.
SELECT
    unitcode,
    ofsemester,
    COUNT(stuid) AS student_count
FROM
    uni.enrolment
WHERE
    to_char(ofyear, 'YYYY') = '2019'
GROUP BY
    unitcode,
    ofsemester
HAVING
    COUNT(stuid) = (
        SELECT
            MAX(COUNT(stuid))
        FROM
            uni.enrolment
        WHERE
            to_char(ofyear, 'YYYY') = '2019'
        GROUP BY
            unitcode,
            ofsemester
    )
ORDER BY
    ofsemester,
    unitcode;

--13 Find all students enrolled in FIT3157 in semester 1, 2020 who have scored more than the average mark for FIT3157 in the same offering. 
-- Display the students' name and the mark.
-- Sort the list in the order of the mark from the highest to the lowest then in increasing order of student name.

SELECT
    stufname
    || ' '
    || stulname AS student_name,
    enrolmark
FROM
         uni.student s
    JOIN uni.enrolment e
    ON s.stuid = e.stuid
WHERE
        upper(unitcode) = 'FIT3157'
    AND ofsemester = 1
    AND to_char(ofyear, 'YYYY') = '2020'
    AND enrolmark > (
        SELECT
            AVG(enrolmark)
        FROM
            uni.enrolment
        WHERE
                upper(unitcode) = 'FIT3157'
            AND ofsemester = 1
            AND to_char(ofyear, 'YYYY') = '2020'
    )
ORDER BY
    enrolmark DESC,
    student_name;


