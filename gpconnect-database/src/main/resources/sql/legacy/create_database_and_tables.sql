/* Create a new poc_legacy database and begin configuration */
DROP DATABASE IF EXISTS gpconnect;
CREATE DATABASE         gpconnect DEFAULT CHARACTER SET utf8;
USE                     gpconnect;

/* Destroy all existing data */
DROP TABLE IF EXISTS gpconnect.general_practitioners;
DROP TABLE IF EXISTS gpconnect.practitioners;
DROP TABLE IF EXISTS gpconnect.medical_departments;
DROP TABLE IF EXISTS gpconnect.patients;
DROP TABLE IF EXISTS gpconnect.allergies;
DROP TABLE IF EXISTS gpconnect.medications;
DROP TABLE IF EXISTS gpconnect.problems;
DROP TABLE IF EXISTS gpconnect.referrals;
DROP TABLE IF EXISTS gpconnect.encounters;
DROP TABLE IF EXISTS gpconnect.patientsummary;
DROP TABLE IF EXISTS gpconnect.procedures;
DROP TABLE IF EXISTS gpconnect.observations;
DROP TABLE IF EXISTS gpconnect.immunisations;
DROP TABLE IF EXISTS gpconnect.adminitems;
DROP TABLE IF EXISTS gpconnect.clinicalitems;
DROP TABLE IF EXISTS gpconnect.investigations;

/* Create new table schemas */
CREATE TABLE gpconnect.general_practitioners (
  id            BIGINT        NOT NULL    AUTO_INCREMENT,
  gp_name       VARCHAR(150)  NULL,
  address_1     VARCHAR(100)  NULL,
  address_2     VARCHAR(100)  NULL,
  address_3     VARCHAR(100)  NULL,
  address_4     VARCHAR(100)  NULL,
  address_5     VARCHAR(100)  NULL,
  postcode      VARCHAR(10)   NULL,
  PRIMARY KEY   (id)
);

CREATE TABLE gpconnect.practitioners (
  id            		BIGINT        	NOT NULL    AUTO_INCREMENT,
  p_user_id				VARCHAR(30)  	NULL,
  p_role_id				VARCHAR(30)  	NULL,
  p_name_family			VARCHAR(100)  	NULL,
  p_name_given			VARCHAR(100)  	NULL,
  p_name_prefix			VARCHAR(20)  	NULL,
  p_gender				VARCHAR(10)  	NULL,
  p_organization_id		BIGINT  		NULL,
  p_role_code			VARCHAR(30)  	NULL,
  p_role_display		VARCHAR(100)  	NULL,
  p_com_code			VARCHAR(30)  	NULL,
  p_com_display			VARCHAR(100)  	NULL,
  PRIMARY KEY   (id)
);

CREATE TABLE gpconnect.medical_departments (
  id            BIGINT        NOT NULL    AUTO_INCREMENT,
  department    VARCHAR(150)  NULL,
  PRIMARY KEY   (id)
);

CREATE TABLE gpconnect.patients (
  id              BIGINT          NOT NULL    AUTO_INCREMENT,
  title           VARCHAR(10)     NULL,
  first_name      VARCHAR(30)     NULL,
  last_name       VARCHAR(30)     NULL,
  address_1       VARCHAR(100)    NULL,
  address_2       VARCHAR(100)    NULL,
  address_3       VARCHAR(100)    NULL,
  address_4       VARCHAR(100)    NULL,
  address_5       VARCHAR(100)    NULL,
  postcode        VARCHAR(10)     NULL,
  phone           VARCHAR(20)     NULL,
  date_of_birth   DATE            NULL,
  gender          VARCHAR(10)     NULL,
  nhs_number      VARCHAR(20)     NULL,
  pas_number      VARCHAR(20)     NULL,
  department_id   BIGINT          NOT NULL,
  gp_id           BIGINT          NOT NULL,
  PRIMARY KEY     (id),
  FOREIGN KEY     (department_id) REFERENCES  gpconnect.medical_departments(id),
  FOREIGN KEY     (gp_id)         REFERENCES  gpconnect.general_practitioners(id)
);

CREATE TABLE gpconnect.allergies (
  id                  BIGINT        NOT NULL    AUTO_INCREMENT,
  html                VARCHAR(4096) NULL,
  provider            VARCHAR(10)   NULL,
  PRIMARY KEY         (id)
);

CREATE TABLE gpconnect.medications (
  id                  BIGINT        NOT NULL    AUTO_INCREMENT,
  html                TEXT(25000) NULL,
  provider            VARCHAR(10)   NULL,
  PRIMARY KEY         (id)
);

CREATE TABLE gpconnect.problems (
 id                  BIGINT        NOT NULL    AUTO_INCREMENT,
 html                VARCHAR(4096) NULL,
 provider            VARCHAR(10)   NULL,
 PRIMARY KEY         (id)
);

CREATE TABLE gpconnect.referrals (
 id                  BIGINT        NOT NULL    AUTO_INCREMENT,
 html                VARCHAR(4096) NULL,
 provider            VARCHAR(10)   NULL,
 PRIMARY KEY         (id)
);

CREATE TABLE gpconnect.encounters (
 id                  BIGINT        NOT NULL    AUTO_INCREMENT,
 html                VARCHAR(4096) NULL,
 provider            VARCHAR(10)   NULL,
 PRIMARY KEY         (id)
);

CREATE TABLE gpconnect.patientsummary (
 id                  BIGINT        NOT NULL    AUTO_INCREMENT,
 html                VARCHAR(7168) NULL,
 provider            VARCHAR(10)   NULL,
 PRIMARY KEY         (id)
);

CREATE TABLE gpconnect.procedures (
 id                  BIGINT        NOT NULL    AUTO_INCREMENT,
 html                VARCHAR(4096) NULL,
 provider            VARCHAR(10)   NULL,
 PRIMARY KEY         (id)
);

CREATE TABLE gpconnect.observations (
 id                  BIGINT        NOT NULL    AUTO_INCREMENT,
 html                TEXT(25000) NULL,
 provider            VARCHAR(10)   NULL,
 PRIMARY KEY         (id)
);

CREATE TABLE gpconnect.immunisations (
 id                  BIGINT        NOT NULL    AUTO_INCREMENT,
 html                VARCHAR(4096) NULL,
 provider            VARCHAR(10)   NULL,
 PRIMARY KEY         (id)
);

CREATE TABLE gpconnect.adminitems (
 id                  BIGINT        NOT NULL    AUTO_INCREMENT,
 html                VARCHAR(15000) NULL,
 provider            VARCHAR(10)   NULL,
 PRIMARY KEY         (id)
);

CREATE TABLE gpconnect.clinicalitems (
 id                  BIGINT        NOT NULL    AUTO_INCREMENT,
 html                TEXT(25000) NULL,
 provider            VARCHAR(10)   NULL,
 PRIMARY KEY         (id)
);

CREATE TABLE gpconnect.investigations (
 id                  BIGINT        NOT NULL    AUTO_INCREMENT,
 html                VARCHAR(7168) NULL,
 provider            VARCHAR(10)   NULL,
 PRIMARY KEY         (id)
);

/* Delete the answer user (grant all to workaround MySQL not supporting 'IF EXISTS' for users) */
GRANT ALL ON gpconnect.* TO 'answer' IDENTIFIED BY 'answer99q';
DROP USER 'answer';
FLUSH PRIVILEGES;

/* Create a new answer user with full privileges */
CREATE USER 'answer'                              IDENTIFIED BY 'answer99q';
GRANT ALL ON gpconnect.* TO 'answer'@'%'          IDENTIFIED BY 'answer99q';
GRANT ALL ON gpconnect.* TO 'answer'@'localhost'  IDENTIFIED BY 'answer99q';
FLUSH PRIVILEGES;