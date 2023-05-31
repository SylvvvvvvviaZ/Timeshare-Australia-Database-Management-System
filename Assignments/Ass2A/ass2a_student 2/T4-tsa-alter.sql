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
    role_id         CHAR(1) NOT NULL,
    role_name       VARCHAR2(20) NOT NULL,
    job_description VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN staff_role.role_id IS
    'Unique identifier for staff role';

COMMENT ON COLUMN staff_role.role_name IS
    'Name of the staff role';

COMMENT ON COLUMN staff_role.job_description IS
    'Description of the job responsibilities for the staff role';

ALTER TABLE staff_role ADD CONSTRAINT staff_role_pk PRIMARY KEY ( role_id );

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
DROP TABLE cleaning_schedule CASCADE CONSTRAINTS PURGE;

CREATE TABLE cleaning_schedule (
    resort_id NUMBER(4) NOT NULL,
    cabin_no NUMBER(3) NOT NULL,
    cleaning_date DATE NOT NULL,
    staff_id NUMBER(5) NOT NULL,
    start_time DATE NOT NULL,
    end_time DATE NOT NULL
);

COMMENT ON COLUMN cleaning_schedule.resort_id IS
    'Resort identifier';

COMMENT ON COLUMN cleaning_schedule.cabin_no IS
    'Cabin number';

COMMENT ON COLUMN cleaning_schedule.cleaning_date IS
    'Date of cleaning';

COMMENT ON COLUMN cleaning_schedule.staff_id IS
    'Staff member ID';

COMMENT ON COLUMN cleaning_schedule.start_time IS
    'Start time of cleaning';

COMMENT ON COLUMN cleaning_schedule.end_time IS
    'End time of cleaning';

ALTER TABLE cleaning_schedule
    ADD CONSTRAINT cleaning_schedule_pk PRIMARY KEY ( resort_id,
                                                      cabin_no,
                                                      cleaning_date );

ALTER TABLE cleaning_schedule
    ADD CONSTRAINT fk_cleaning_resort FOREIGN KEY ( resort_id,
                                                    cabin_no )
        REFERENCES cabin ( resort_id,
                           cabin_no );

ALTER TABLE cleaning_schedule
    ADD CONSTRAINT fk_cleaning_staff FOREIGN KEY ( staff_id )
        REFERENCES staff ( staff_id );
        
-- Update the CABIN table structure 
-- Include the new column cleaning_status indicating whether the cabin needs cleaning or not

ALTER TABLE cabin ADD cleaning_status CHAR(1) DEFAULT 'N' NOT NULL;

DESC cleaning_schedule;

DESC cabin;

