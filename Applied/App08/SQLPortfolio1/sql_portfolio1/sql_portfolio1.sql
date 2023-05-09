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

DECLARE
  v_policy_id_1 NUMBER;
  v_policy_id_2 NUMBER;
  
BEGIN
    SELECT policy_id_seq.NEXTVAL INTO v_policy_id_1 FROM DUAL;
    SELECT policy_id_seq.NEXTVAL INTO v_policy_id_2 FROM DUAL;

--The policy_type_code 'B' indicates that this is a building insurance policy.       
--The insurer_code 'LW' indicates that this is  Ludovika Wiggins as an insurance company.

INSERT INTO policy (
    policy_id,
    prop_no,
    policy_startdate,
    policy_type_code,
    policy_length,
    insurer_code
) VALUES (
    v_policy_id_1,
    7145,
    TO_DATE('21-APR-2023', 'DD-MON-YYYY'),
    'B',
    12,
    'LW'
);

INSERT INTO policy (
    policy_id,
    prop_no,
    policy_startdate,
    policy_type_code,
    policy_length,
    insurer_code
) VALUES (
    v_policy_id_2,
    9346,
    TO_DATE('21-APR-2023', 'DD-MON-YYYY'),
    'B',
    12,
    'LW'
);

COMMIT;

END;
       
/*Task 3*/

DECLARE
    v_policy_id NUMBER;
    
BEGIN
    SELECT
        policy_id
    INTO v_policy_id
    FROM
        policy
    WHERE
            prop_no = 7145
        AND policy_startdate = TO_DATE('21-APR-2023', 'DD-MON-YYYY')

UPDATE policy
SET
    policy_length = 18
WHERE
    policy_id = v_policy_id;

SELECT
    policy_id_seq.NEXTVAL
INTO v_policy_id
FROM
    dual;

INSERT INTO policy (
    policy_id,
    prop_no,
    policy_startdate,
    policy_type_code,
    policy_length,
    insurer_code
) VALUES (
    v_policy_id,
    7145,
    TO_DATE('01-MAY-2023', 'DD-MON-YYYY'),
    'C',
    12,
    'LAI'
);

COMMIT;

end;
        
-- Insert a new policy record
INSERT
    INTO policy (
        policy_id,
        prop_no,
        policy_startdate,
        policy_type_code,
        policy_length,
        insurer_code
    )
VALUES (3,
           7145,
           '01-MAY-23',
           'B',
           12,
           'LW');

COMMIT;


/*Task 4*/

DELETE FROM policy
WHERE
        prop_no = 7145
    AND policy_startdate = DATE '2023-05-02'
    AND policy_type_code = 'B'
    AND policy_length = 6
    AND insurer_code = 'LW';

DELETE FROM policy
WHERE
        prop_no = 7145
    AND policy_startdate = DATE '2023-05-02'
    AND policy_type_code = 'B'
    AND policy_length = 12
    AND insurer_code = 'LW';

COMMIT;



--Comment out SET ECHO and SPOOL commands before submitting your portfolio
SPOOL OFF
SET ECHO OFF