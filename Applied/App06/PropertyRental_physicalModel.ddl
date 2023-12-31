--student id: 33049246
--student name: xiaowenzhou
-- Capture run of script in file called custorders_schema_output.txt set echo on
SPOOL custorders_schema_output.txt

-- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2023-05-03 12:24:50 AEST
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c



DROP TABLE damage CASCADE CONSTRAINTS;

DROP TABLE owner CASCADE CONSTRAINTS;

DROP TABLE payment CASCADE CONSTRAINTS;

DROP TABLE property CASCADE CONSTRAINTS;

DROP TABLE rent CASCADE CONSTRAINTS;

DROP TABLE tenant CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE damage (
    dam_date  DATE NOT NULL,
    dam_time  NUMBER NOT NULL,
    dam_type  VARCHAR2(35) NOT NULL,
    dam_cost  NUMBER(7) NOT NULL,
    prop_no   NUMBER(7) NOT NULL,
    owner__no NUMBER(7) NOT NULL
);

COMMENT ON COLUMN damage.dam_date IS
    'dam date';

COMMENT ON COLUMN damage.dam_time IS
    'dam time';

COMMENT ON COLUMN damage.dam_type IS
    ' dam type';

COMMENT ON COLUMN damage.dam_cost IS
    'dam_cost';

COMMENT ON COLUMN damage.prop_no IS
    'prop numver';

COMMENT ON COLUMN damage.owner__no IS
    'owner  no';

ALTER TABLE damage ADD CONSTRAINT damage_pk PRIMARY KEY ( dam_date,
                                                          dam_time );

CREATE TABLE owner (
    owner__no  NUMBER(7) NOT NULL,
    owner_name VARCHAR2(35) NOT NULL
);

COMMENT ON COLUMN owner.owner__no IS
    'owner  no';

COMMENT ON COLUMN owner.owner_name IS
    'owner name';

ALTER TABLE owner ADD CONSTRAINT owner_pk PRIMARY KEY ( owner__no );

CREATE TABLE payment (
    pay_no     NUMBER(7) NOT NULL,
    pay_date   DATE NOT NULL,
    pay_type   VARCHAR2(50) NOT NULL,
    pay_amount NUMBER(7) NOT NULL,
    prop_no    NUMBER(7) NOT NULL,
    owner__no  NUMBER(7) NOT NULL,
    dam_date   DATE,
    dam_time   NUMBER
);

COMMENT ON COLUMN payment.pay_no IS
    'pay number';

COMMENT ON COLUMN payment.pay_date IS
    'pay date';

COMMENT ON COLUMN payment.pay_type IS
    'pay type';

COMMENT ON COLUMN payment.pay_amount IS
    'pay amount';

COMMENT ON COLUMN payment.prop_no IS
    'prop numver';

COMMENT ON COLUMN payment.owner__no IS
    'owner  no';

COMMENT ON COLUMN payment.dam_date IS
    'dam date';

COMMENT ON COLUMN payment.dam_time IS
    'dam time';

CREATE UNIQUE INDEX payment__idx ON
    payment (
        dam_date
    ASC,
        dam_time
    ASC );

ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY ( pay_no );

CREATE TABLE property (
    prop_no      NUMBER(7) NOT NULL,
    prop_address VARCHAR2(35) NOT NULL,
    prop_value   VARCHAR2(35) NOT NULL,
    owner__no    NUMBER(7) NOT NULL
);

COMMENT ON COLUMN property.prop_no IS
    'prop numver';

COMMENT ON COLUMN property.prop_address IS
    'prop address';

COMMENT ON COLUMN property.prop_value IS
    'prop value';

COMMENT ON COLUMN property.owner__no IS
    'owner  no';

ALTER TABLE property ADD CONSTRAINT property_pk PRIMARY KEY ( prop_no,
                                                              owner__no );

CREATE TABLE rent (
    rent_lease_startdate DATE NOT NULL,
    rent_bond            NUMBER(7) NOT NULL,
    rent_lease_period    NUMBER(7),
    prop_no              NUMBER(7) NOT NULL,
    owner__no            NUMBER(7) NOT NULL,
    tenant_no            NUMBER(7) NOT NULL
);

COMMENT ON COLUMN rent.rent_lease_startdate IS
    'rent lease startdate';

COMMENT ON COLUMN rent.rent_bond IS
    'rent bond';

COMMENT ON COLUMN rent.rent_lease_period IS
    'rent lease period';

COMMENT ON COLUMN rent.prop_no IS
    'prop numver';

COMMENT ON COLUMN rent.owner__no IS
    'owner  no';

COMMENT ON COLUMN rent.tenant_no IS
    'tenant no';

ALTER TABLE rent ADD CONSTRAINT rent_pk PRIMARY KEY ( rent_lease_startdate );

CREATE TABLE tenant (
    tenant_no       NUMBER(7) NOT NULL,
    tenant_givname  CHAR(7) NOT NULL,
    tenant_famname  CHAR(7) NOT NULL,
    tenant_street   VARCHAR2(35) NOT NULL,
    tenant_city     VARCHAR2(35) NOT NULL,
    tenant_state    VARCHAR2(35) NOT NULL,
    tenant_postcode NUMBER(4) NOT NULL,
    tenant_phone    NUMBER(10) NOT NULL
);

COMMENT ON COLUMN tenant.tenant_no IS
    'tenant no';

COMMENT ON COLUMN tenant.tenant_givname IS
    'tenant given name';

COMMENT ON COLUMN tenant.tenant_famname IS
    'tenant family name';

COMMENT ON COLUMN tenant.tenant_street IS
    'tenant street';

COMMENT ON COLUMN tenant.tenant_city IS
    'tenant city';

COMMENT ON COLUMN tenant.tenant_state IS
    'tenant state';

COMMENT ON COLUMN tenant.tenant_postcode IS
    'tenant postcode';

COMMENT ON COLUMN tenant.tenant_phone IS
    'tenant phone';

ALTER TABLE tenant ADD CONSTRAINT tenant_pk PRIMARY KEY ( tenant_no );

ALTER TABLE payment
    ADD CONSTRAINT damage_payment FOREIGN KEY ( dam_date,
                                                dam_time )
        REFERENCES damage ( dam_date,
                            dam_time );

ALTER TABLE rent
    ADD CONSTRAINT peoperty_rent FOREIGN KEY ( prop_no,
                                               owner__no )
        REFERENCES property ( prop_no,
                              owner__no );

ALTER TABLE damage
    ADD CONSTRAINT property_damage FOREIGN KEY ( prop_no,
                                                 owner__no )
        REFERENCES property ( prop_no,
                              owner__no );

ALTER TABLE payment
    ADD CONSTRAINT property_damagev2 FOREIGN KEY ( prop_no,
                                                   owner__no )
        REFERENCES property ( prop_no,
                              owner__no );

ALTER TABLE property
    ADD CONSTRAINT relation_6 FOREIGN KEY ( owner__no )
        REFERENCES owner ( owner__no );

ALTER TABLE rent
    ADD CONSTRAINT tentant_rent FOREIGN KEY ( tenant_no )
        REFERENCES tenant ( tenant_no );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             1
-- ALTER TABLE                             12
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
SPOOL off
set echo off