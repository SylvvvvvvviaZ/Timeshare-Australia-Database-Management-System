--Comment out SET ECHO and SPOOL commands before submitting your portfolio
SET ECHO ON
SPOOL sql_portfolio1_output.txt

--****PLEASE ENTER YOUR DETAILS BELOW****
--sql_portfolio1.sql

--Student ID:33049246
--Student Name:XiaowenZhou
--Unit Code:FIT2094
--Applied Class No: Applied 01, Melbourne Wed 18:00

--set echo on
--spool week7_schema_output.txt

DROP TABLE policy CASCADE CONSTRAINTS PURGE;

/*Task 1: CREATE table POLICY and non FK constraints*/

CREATE TABLE policy (
    policy_id        NUMBER(7) NOT NULL,
    prop_no          NUMBER(4) NOT NULL,
    policy_startdate DATE NOT NULL,
    policy_type_code CHAR(1) NOT NULL,
    policy_length    NUMBER(3) NOT NULL,
    insurer_code     CHAR(3) NOT NULL, );
COMMENT ON COLUMN policy.policy_id IS
    'Policy unique identifier';

COMMENT ON COLUMN policy.prop_no IS
    'Property unique identifierr';

COMMENT ON COLUMN policy.policy_startdate IS
    'Policy start date';

COMMENT ON COLUMN policy.policy_type_code IS
    'Address of property owner';

COMMENT ON COLUMN policy.policy_length IS
    'Length of the policy in months (minimum 6 months long)';

COMMENT ON COLUMN policy.insurer_code IS
    'Insurance company unique identifier';

/*Task 1: Add FK constraints*/

ALTER TABLE policy ADD CONSTRAINT policy_pk PRIMARY KEY ( policy_id );

ALTER TABLE policy ADD CONSTRAINT policy_uq UNIQUE ( prop_no );

ALTER TABLE policy
    ADD CONSTRAINT property_policy FOREIGN KEY ( prop_no )
        REFERENCES owner ( prop_no );

ALTER TABLE policy ADD CONSTRAINT policy_uq UNIQUE ( policy_startdate );

ALTER TABLE policy ADD CONSTRAINT policy_uq UNIQUE ( policy_type_code );

ALTER TABLE policy
    ADD CONSTRAINT property_type_policy FOREIGN KEY ( policy_type_code )
        REFERENCES owner ( policy_type_code );

ALTER TABLE policy
    ADD CONSTRAINT insurer_policy FOREIGN KEY ( insurer_code )
        REFERENCES owner ( insurer_code );


/*Task 2*/
    INSERT INTO policy (
        policy_id,
        prop_no,
        policy_startdate,
        policy_type_code,
        policy_length,
        insurer_code
    ) VALUES (
        policy_id_seq.NEXTVAL,
        7145,
        TO_DATE('2023-04-21', 'YYYY-MM-DD'),
        'B',
        12,
        'LW'
    ),
(
    policy_id_seq.NEXTVAL,
    9346,
    TO_DATE('2023-04-21', 'YYYY-MM-DD'),
    'B',
    12,
    'LW'
);
       
--The policy_type_code 'B' indicates that this is a building insurance policy.       
--The insurer_code 'LW' indicates that this is  Ludovika Wiggins as an insurance company.
/*Task 3*/



/*Task 4*/



--Comment out SET ECHO and SPOOL commands before submitting your portfolio
SPOOL OFF
SET ECHO OFF