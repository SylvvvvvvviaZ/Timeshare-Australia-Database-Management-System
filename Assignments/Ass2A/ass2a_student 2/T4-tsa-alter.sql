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
-- Show the updated structure of the cabin table
DESC cabin;

SELECT
    resort_id,
    cabin_no,
    booking_count
FROM
    cabin;

--4(b)
DROP TABLE staff_role CASCADE CONSTRAINTS PURGE;

CREATE TABLE staff_role (
    role_id         CHAR(1) PRIMARY KEY,
    role_name       VARCHAR2(20),
    job_description VARCHAR2(100)
);

INSERT INTO staff_role (
    role_id,
    role_name,
    job_description
) VALUES (
    'A',
    'Admin',
    'Take bookings, and reply to customer inquiries'
);

INSERT INTO staff_role (
    role_id,
    role_name,
    job_description
) VALUES (
    'C',
    'Cleaning',
    'Clean cabins and maintain resorts public area'
);

INSERT INTO staff_role (
    role_id,
    role_name,
    job_description
) VALUES (
    'M',
    'Marketing',
    'Prepare and present marketing ideas and deliverables '
);

ALTER TABLE staff ADD role_id CHAR(1);

UPDATE staff
SET
    role_id = 'A';

ALTER TABLE staff
    ADD CONSTRAINT fk_staff_role FOREIGN KEY ( role_id )
        REFERENCES staff_role ( role_id );
        
-- Show the updated structure of the staff table
DESC staff;

-- Show the newly created staff_role table
DESC staff_role;


SELECT
    staff_id,
    staff_gname
    || ' '
    || staff_fname AS staff_name,
    role_name
FROM
         staff
    JOIN staff_role
    ON staff.role_id = staff_role.role_id;
    
--4(c)
