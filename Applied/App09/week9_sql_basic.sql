/*
Databases Week 9 Applied Class
week9_sql_basic.sql

student id: 33049246
student name: Xiaowen Zhou
applied class number: Wed 8:00am
last modified date:3/5/2023

*/

/* Part A - Retrieving data from a single table */

-- A1 List all units and their details. Order the output by unit code.
SELECT
    *
FROM
    uni.unit
ORDER BY
    unitcode;

-- A2 List the full student details for those students who live in Caulfield. Order the output by student id.
SELECT
    stuid,
    stufname,
    stulname,
    to_char(
        studob, 'dd-Mon-yyyy'
    ) AS date_of_birth,
    stuaddress,
    stuphone,
    stuemail
FROM
    uni.student
WHERE
    upper(stuaddress) LIKE upper('%Caulfield')
ORDER BY
    stuid;

-- A3 List the full student details for those students who have a surname starting with the letter M.
--In the display, rename the columns stufname and stulname to firstname and lastname. Order the output by student id.

SELECT
    stuid,
    stufname AS firstname,
    stulname AS lastname,
    to_char(
        studob, 'dd-Mon-yyyy'
    )        AS date_of_birth,
    stuaddress,
    stuphone,
    stuemail
FROM
    uni.student
WHERE
    upper(stulname) LIKE 'M%'
ORDER BY
    stuid;

-- A4 List the student's id, surname, first name and address for those students 
-- who have a surname starting with the letter S and first name which contains the letter i. Order the output by student id.
SELECT
    stuid,
    stulname,
    stufname,
    stuaddress
FROM
    uni.student
WHERE
    upper(stulname) LIKE 'S%'
    AND lower(stufname) LIKE '%i%'
ORDER BY
    stuid;
    
-- A5 Assuming that a unit code is created based on the following rules:
--■ The first three letters represent the faculty abbreviation, eg. FIT for the Faculty of Information Technology.
--■ The first digit of the number following the letter represents the year level. For example,
--FIT2094 is a unit code from the Faculty of IT (FIT) and the number 2 refers to a second year unit.
--List the unit details for all first year units in the Faculty of Information Technology. Order the output by unit code.
SELECT
    *
FROM
    uni.unit
WHERE
    upper(unitcode) LIKE 'FIT1%'
ORDER BY
    unitcode;

-- A6 List the unit code and semester of all units that are offered in 2021. Order the output by unit
--code, and within a given unit code order by semester. To complete this question, you need to
--use the Oracle function to_char to convert the data type for the year component of the
--offering date into text. For example, to_char(ofyear,'yyyy') - here we are only using the year part of the date.
SELECT
    unitcode,
    ofsemester
FROM
    uni.offering
WHERE
    to_char(ofyear, 'yyyy') = '2021'
ORDER BY
    unitcode,
    ofsemester;
    
-- A7 List the year, semester, and unit code for all units that were offered in either semester 2 of
-- 2019 or semester 2 of 2020. Order the output by year and semester then by unit code. 
-- To display the offering year correctly in Oracle, you need to use the to_char function. For example, to_char(ofyear,'yyyy').
SELECT
    to_char(ofyear, 'yyyy') AS offering_year,
    ofsemester,
    unitcode
FROM
    uni.offering
WHERE
        ofsemester = 2
    AND ( ( to_char(ofyear, 'yyyy') = '2019' )
          OR ( to_char(ofyear, 'yyyy') = '2020' ) )
ORDER BY
    offering_year,
    ofsemester,
    unitcode;

-- A8 List the student id, unit code and mark for those students who have failed any unit in
-- semester 2 of 2021. Order the output by student id then order by unit code.
SELECT
    stuid,
    unitcode,
    enrolmark
FROM
    uni.enrolment
WHERE
        enrolmark < 50
    AND ofsemester = 2
    AND to_char(ofyear, 'yyyy') = '2021'
ORDER BY
    stuid,
    unitcode;
    
/* OR*/

SELECT
    stuid,
    unitcode,
    enrolmark
FROM
    uni.enrolment
WHERE
        enrolgrade = 'N'
    AND ofsemester = 2
    AND to_char(ofyear, 'yyyy') = '2021'
ORDER BY
    stuid,
    unitcode;
    
-- A9 List the student id for all students who have no mark and no grade in FIT3176 in semester 1of 2020. 
-- Order the output by student id.
SELECT
    stuid
FROM
    uni.enrolment
WHERE
    enrolmark IS NULL
    AND enrolgrade IS NULL
    AND upper(unitcode) = 'FIT3176'
    AND to_char(ofyear, 'yyyy') = '2020'
    AND ofsemester = 1
ORDER BY
    stuid;


/* Part B - Retrieving data from multiple tables */

-- B1 List all the unit codes, semesters and name of chief examiners 
-- (ie. the staff who is responsible for the unit) for all the units that are offered in 2021. 
-- Order the output by semester then by unit code.
SELECT
    unitcode,
    ofsemester,
    stafffname,
    stafflname
FROM
         uni.offering o
    JOIN uni.staff s
    ON o.staffid = s.staffid
WHERE
    to_char(ofyear, 'yyyy') = '2021'
ORDER BY
    ofsemester,
    unitcode;


-- B2 List all unit codes, unit names and their year and semester of offering. Order the output by
-- unit code then by offering year and then semester.
SELECT
    u.unitcode,
    unitname,
    to_char(ofyear, 'yyyy') AS offeringyear,
    ofsemester
FROM
         uni.unit u
    JOIN uni.offering o
    ON u.unitcode = o.unitcode
ORDER BY
    unitcode,
    offeringyear,
    ofsemester;


-- B3 List the student id, student name (firstname and surname) as one attribute and the unit name
-- of all enrolments for semester 1 of 2021. Order the output by unit name, within a given unit name, order by student id.
SELECT
    e.stuid,
    stufname
    || ' '
    || stulname AS studentname,
    unitname
FROM
         uni.student s
    JOIN uni.enrolment e
    ON s.stuid = e.stuid
    JOIN uni.unit      u
    ON u.unitcode = e.unitcode
WHERE
        ofsemester = 1
    AND to_char(ofyear, 'yyyy') = '2021'
ORDER BY
    unitname,
    stuid;

-- B4 List the id and full name of all students who have marks in the range of 80 to 100 in FIT9132 semester 2 of 2019. 
-- Order the output by full name. If there are more than one student with the same name, order them based on their id.
SELECT
    s.stuid,
    stulname
    || ' '
    || stufname AS fullname
FROM
         uni.student s
    JOIN uni.enrolment e
    ON s.stuid = e.stuid
WHERE
    enrolmark BETWEEN 80 AND 100
    AND upper(unitcode) = 'FIT9132'
    AND ofsemester = 2
    AND to_char(ofyear, 'yyyy') = '2019'
ORDER BY
    fullname,
    stuid;

-- B5 List the unit code, semester, class type (lecture or tutorial), day, time and duration (in minutes) for all units taught by Windham Ellard in 2021. 
-- Sort the list according to the unit code, within a given unit code, order by offering semester.
SELECT
    unitcode,
    ofsemester,
    cltype,
    clday,
    to_char(cltime, 'HHAM') AS time,
    clduration * 60         AS duration
FROM
         uni.staff s
    JOIN uni.schedclass sc
    ON s.staffid = sc.staffid
WHERE
        to_char(ofyear, 'yyyy') = '2021'
    AND upper(stafffname) = upper('Windham')
    AND upper(stafflname) = upper('Ellard')
ORDER BY
    unitcode,
    ofsemester;

-- B6 Create a study statement for Brier Kilgour. A study statement contains unit code, unit name,
-- semester and year the study was attempted, the mark and grade. 
-- If the mark and/or grade is unknown, show the mark and/or grade as ‘N/A’. 
-- Sort the list by year, then by semester and unit code.
SELECT
    e.unitcode,
    unitname,
    ofsemester,
    to_char(ofyear, 'yyyy') AS year,
    nvl(to_char(enrolmark, '999'),
        'N/A')              AS mark,
    nvl(enrolgrade, 'N/A')  AS grade
FROM
         uni.student s
    JOIN uni.enrolment e
    ON s.stuid = e.stuid
    JOIN uni.unit      u
    ON e.unitcode = u.unitcode
WHERE
        upper(stufname) = upper('Brier')
    AND upper(stulname) = upper('Kilgour')
ORDER BY
    year,
    ofsemester,
    unitcode;
    
-- B7 List the unit code, unit name and the unit code and unit name of the prerequisite units for all
-- units in the database which have prerequisites. Order the output by unit code and prerequisite unit code.
SELECT
    u1.unitcode,
    u1.unitname,
    prerequnitcode AS prereq_unitcode,
    u2.unitname    AS prereq_unitname
FROM
    uni.unit u1
    JOIN uni.prereq p ON u1.unitcode = p.unitcode
    JOIN uni.unit   u2 ON u2.unitcode = p.prerequnitcode
ORDER BY
    unitcode,
    prereq_unitcode;

-- B8 List the unit code and unit name of the prerequisite units of the Introduction to data science unit.
-- Order the output by prerequisite unit code.
SELECT
    prerequnitcode AS prereq_unitcode,
    u2.unitname    AS prereq_unitname
FROM
    uni.unit u1
    JOIN uni.prereq p ON u1.unitcode = p.unitcode
    JOIN uni.unit   u2 ON u2.unitcode = p.prerequnitcode
WHERE
    upper(u1.unitname) = upper('Introduction to data science')
ORDER BY
    prereq_unitcode;

-- B9 Find all students (list their id, firstname and surname) who have received an HD for FIT2094
-- in semester 2 of 2021. Sort the list by student id.
SELECT
    s.stuid,
    stufname,
    stulname
FROM
         uni.student s
    JOIN uni.enrolment e
    ON s.stuid = e.stuid
WHERE
        upper(enrolgrade) = 'HD'
    AND upper(unitcode) = 'FIT2094'
    AND ofsemester = 2
    AND to_char(ofyear, 'yyyy') = '2021'
ORDER BY
    s.stuid;

-- B10 List the student's full name, unit code for those students who have no mark in any unit in semester 1 of 2021.
-- Sort the list by student full name.
SELECT
    stufname
    || ' '
    || stulname AS student_fullname,
    e.unitcode
FROM
         uni.student s
    JOIN uni.enrolment e
    ON s.stuid = e.stuid
WHERE
    enrolmark IS NULL
    AND ofsemester = 1
    AND to_char(ofyear, 'yyyy') = '2021'
ORDER BY
    student_fullname;