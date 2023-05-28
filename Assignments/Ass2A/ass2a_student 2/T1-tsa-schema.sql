--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T1-tsa-schema.sql

--Student ID: 33049246
--Student Name: Xiaowen Zhou
--Unit Code: FIT2094
--Applied Class No: Applied 01, Melbourne Wed 18:00

/* Comments for your marker:




*/

-- Task 1 Add Create table statements for the white TABLES below
-- Ensure all column comments, and constraints (other than FK's)
-- are included. FK constraints are to be added at the end of this script

-- BOOKING
CREATE TABLE booking(
    booking_id                NUMERIC(8) NOT NULL,
    resort_id                 NUMERIC(4) NOT NULL,
    cabin_no                  NUMERIC(3) NOT NULL,
    booking_from              DATE NOT NULL,
    booking_to                DATE NOT NULL,
    booking_noadults          NUMERIC(2) NOT NULL,
    booking_nochildren        NUMERIC(2) NOT NULL,
    booking_total_points_cost NUMERIC(4) NOT NULL,
    member_id                 NUMERIC(6) NOT NULL,
    staff_id                  NUMERIC(5) NOT NULL
    );

-- CABIN
CREATE TABLE cabin (
    resort_id               NUMERIC(4) NOT NULL,
    cabin_no                NUMERIC(3) NOT NULL,
    cabin_nobedrooms        NUMERIC(1) NOT NULL,
    cabin_sleeping_capacity NUMERIC(2) NOT NULL,
    cabin_bathroom_type     CHAR(1) NOT NULL,
    cabin_points_cost_day   NUMERIC(4) NOT NULL,
    cabin_description       VARCHAR2(250) NOT NULL
);

-- Add all missing FK Constraints below here
                        
   

--**Trigger for checking and updating member.member_points for each booking.**--
--**Run this code before attempting Task 2 and Task 3**--
--**DO NOT REMOVE. DO NOT MODIFY**--
CREATE OR REPLACE TRIGGER check_member_points BEFORE
    INSERT OR DELETE OR UPDATE OF booking_total_points_cost ON booking
    FOR EACH ROW
DECLARE
    var_mem_points NUMBER;
BEGIN
    IF inserting THEN
        SELECT
            member_points
        INTO var_mem_points
        FROM
            member
        WHERE
            member_id = :new.member_id;
            
        IF var_mem_points < :new.booking_total_points_cost THEN
            raise_application_error(-20001, 'Not enough member points for this booking'
            );
        ELSE
            var_mem_points := var_mem_points - :new.booking_total_points_cost;
            UPDATE member
            SET
                member_points = var_mem_points
            WHERE
                member_id = :new.member_id;

        END IF;

        dbms_output.put_line('New booking added for member '
                             || :new.member_id
                             || '. Remaining points for this member: '
                             || var_mem_points);

    END IF;

    IF deleting THEN
        SELECT
            member_points
        INTO var_mem_points
        FROM
            member
        WHERE
            member_id = :old.member_id;
        
        var_mem_points := var_mem_points + :old.booking_total_points_cost;
        
        UPDATE member
        SET
            member_points = var_mem_points
        WHERE
            member_id = :old.member_id;

        dbms_output.put_line('Booking '
                             || :old.booking_id
                             || ' for member '
                             || :old.member_id
                             || ' was deleted. Remaining points for this member: '
                             || var_mem_points);

    END IF;

    IF updating THEN
        SELECT
            member_points
        INTO var_mem_points
        FROM
            member
        WHERE
            member_id = :new.member_id;
            
        var_mem_points := var_mem_points + :old.booking_total_points_cost;
        
        IF var_mem_points < :new.booking_total_points_cost THEN
            raise_application_error(-20001, 'Not enough member points for this booking'
            );
        ELSE
            var_mem_points := var_mem_points - :new.booking_total_points_cost;
            UPDATE member
            SET
                member_points = var_mem_points
            WHERE
                member_id = :new.member_id;

            dbms_output.put_line('Booking '
                                 || :old.booking_id
                                 || ' for member '
                                 || :new.member_id
                                 || ' was updated. Remaining points for this member: '
                                 || var_mem_points);

        END IF;

    END IF;

END;
/
--**End of trigger**--