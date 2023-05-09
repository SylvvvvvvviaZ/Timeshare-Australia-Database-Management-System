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

/*Task 1: CREATE table POLICY and non FK constraints*/

CREATE TABLE policy (
    policy_id        NUMBER(7) NOT NULL,
    prop_no          NUMBER(4) NOT NULL,
    policy_startdate DATE NOT NULL,
    policy_type_code CHAR(1) NOT NULL,
    policy_length    NUMBER(3) NOT NULL CHECK (policy_length >= 6),
    insurer_code     CHAR(3) NOT NULL
);

COMMENT ON COLUMN policy.policy_id IS
    'Policy unique identifier';

COMMENT ON COLUMN policy.prop_no IS
    'Property unique identifier';

COMMENT ON COLUMN policy.policy_startdate IS
    'Policy start date';

COMMENT ON COLUMN policy.policy_type_code IS
    'Policy type code';

COMMENT ON COLUMN policy.policy_length IS
    'Length of policy in months (minimum 6 months)';

COMMENT ON COLUMN policy.insurer_code IS
    'Insurance company code';

/*Task 1: Add FK constraints*/

ALTER TABLE policy ADD CONSTRAINT policy_pk PRIMARY KEY ( policy_id );

ALTER TABLE policy ADD CONSTRAINT policy_no_uq UNIQUE (prop_no);
ALTER TABLE policy ADD CONSTRAINT policy_startdate_uq UNIQUE (policy_startdate);
ALTER TABLE policy ADD CONSTRAINT policy_type_code_uq UNIQUE (policy_type_code);

ALTER TABLE policy ADD CONSTRAINT property_policy 
    FOREIGN KEY (prop_no) REFERENCES property(prop_no);
    
ALTER TABLE policy ADD CONSTRAINT property_type_policy 
    FOREIGN KEY (policy_type_code) REFERENCES policy_type(policy_type_code);
    
ALTER TABLE policy ADD CONSTRAINT insurer_policy 
    FOREIGN KEY (insurer_code) REFERENCES insurer(insurer_code);
    
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
    'LAS'
);

INSERT INTO policy (
    policy_id,
    prop_no,
    policy_startdate,
    policy_type_code,
    policy_length,
    insurer_code
) VALUES (
    policy_id_seq.NEXTVAL,
    9346,
    TO_DATE('2023-04-21', 'YYYY-MM-DD'),
    'B',
    12,
    'LAS'
);

COMMIT;

       
/*Task 3*/

UPDATE policy

SET
    policy_length = policy_length + 6
WHERE
        prop_no = 7145
    AND policy_type_code = 'B'
    AND policy_startdate = TO_DATE('2023-04-21', 'YYYY-MM-DD');

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
    TO_DATE('2023-05-01', 'YYYY-MM-DD'),
    'C',
    12,
    'LAS'
);

COMMIT;


/*Task 4*/

DELETE FROM policy

WHERE
        prop_no = 7145
    AND policy_type_code = 'B'
    AND policy_startdate = TO_DATE('2023-04-21', 'YYYY-MM-DD');

DELETE FROM policy
WHERE
        prop_no = 7145
    AND policy_type_code = 'C'
    AND policy_startdate = TO_DATE('2023-05-01', 'YYYY-MM-DD');

COMMIT;

--Comment out SET ECHO and SPOOL commands before submitting your portfolio
SPOOL OFF
SET ECHO OFF