--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-tsa-alter.sql

--Student ID: 33049246
--Student Name: Xiaowen Zhou
--Unit Code: FIT2094
--Applied Class No: Applied 01, Melbourne Wed 18:00

/* Comments for your marker:

*/

--4(a)

ALTER TABLE cabin ADD booking_count NUMBER(3) DEFAULT 0;

UPDATE cabin c
SET
    booking_count = (
        SELECT
            COUNT(*)
        FROM
            booking b
        WHERE
            b.cabin_no = c.cabin_no
    );

DESC cabin;

SELECT
    resort_id,
    cabin_no,
    booking_count
FROM
    cabin;

--4(b)

        
--4(c)