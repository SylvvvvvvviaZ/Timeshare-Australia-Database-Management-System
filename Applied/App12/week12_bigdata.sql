/*
Databases Week 12 Applied Class
week12_bigdata.sql

student id: 33049246
student name: Xiaowen Zhou
last modified date: 8 Jun

*/

/*
12.1.2 MongoDB Create Update and Delete
1. Use an SQL select statement to generate a collection of documents 
using the following structure/format from the UNI database.
*/
SET PAGESIZE 300

SELECT
    JSON_OBJECT ( '_id' VALUE stuid, 'name' VALUE stufname
                || ' '
                || stulname,
                'contactInfo' VALUE JSON_OBJECT (
                                'address' VALUE stuaddress,
                                'phone' VALUE rtrim(stuphone),
                                'email' VALUE stuemail ),
                'dob' VALUE to_char(studob, 'dd-mm-yyyy'),
                'enrolmentInfo' VALUE JSON_ARRAYAGG(
                                JSON_OBJECT('unitcode' VALUE unitcode,
                                'unitname' VALUE unitname,
                                'year' VALUE to_char(ofyear, 'yyyy'),
                                'semester' VALUE ofsemester,
                                'mark' VALUE enrolmark,
                                'grade' VALUE enrolgrade))
    FORMAT JSON )
    || ','
FROM
    uni.student
    NATURAL JOIN uni.enrolment
    NATURAL JOIN uni.unit
GROUP BY
    stuid,
    stufname,
    stulname,
    stuaddress,
    stuphone,
    stuemail,
    studob
ORDER BY
    stuid;