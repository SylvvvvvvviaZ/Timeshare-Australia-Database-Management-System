--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-tsa-dm.sql

--Student ID: 33049246
--Student Name: Xiaowen Zhou
--Unit Code: FIT2094
--Applied Class No: Applied 01, Melbourne Wed 18:00

/* Comments for your marker:

*/

---**This command shows the outputs of triggers**---
---**Run the command before running the insert statements.**---
---**Do not remove**---
SET SERVEROUTPUT ON
---**end**---

--3(a)

-- Drop sequence if it exists
DROP SEQUENCE booking_seq;

-- Create sequence for BOOKING table
CREATE SEQUENCE booking_seq
  START WITH 100
  INCREMENT BY 10
  ;

--3(b)

INSERT
    INTO cabin (
        resort_id,
        cabin_no,
        cabin_nobedrooms,
        cabin_sleeping_capacity,
        cabin_bathroom_type,
        cabin_points_cost_day,
        cabin_description
    ) VALUES ( 
        (
        SELECT
            resort_id
        FROM
            resort
        WHERE
            upper(resort_name) = upper('Awesome Resort')
        And
            ROWNUM = 1  
        ),
        4,
        4,
        10,
        'I',
        220,
        'Description of the cabin: in Broome (latitude:-17.9644, longitude:122.2304)'
    );

--3(c)
INSERT INTO booking (
    booking_id,
    resort_id,
    cabin_no,
    booking_from,
    booking_to,
    booking_noadults,
    booking_nochildren,
    booking_total_points_cost,
    member_id,
    staff_id
) VALUES (
    booking_seq.NEXTVAL,
    (
        SELECT
            resort_id
        FROM
            resort
        WHERE
            upper(resort_name) = upper('Awesome Resort')
        And
            ROWNUM = 1  
        ),
    4,
    TO_DATE('2023-05-26', 'YYYY-MM-DD'),
    TO_DATE('2023-05-28', 'YYYY-MM-DD'),
    3,
    4,
    220 * (TO_DATE('2023-05-28', 'YYYY-MM-DD') - TO_DATE('2023-05-26', 'YYYY-MM-DD')), -- calculate as 2 days booking
    (
        SELECT member_id
        FROM member
        WHERE upper(member_gname) = upper('Noah')
        AND upper(member_fname) = upper('Garrard')
    ),
    (
        SELECT staff_id
        FROM staff
        WHERE staff_phone = '0493427245'
    )
);
    
--3(d)




--3(e)