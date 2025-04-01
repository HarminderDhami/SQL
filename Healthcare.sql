CREATE DATABASE HEALTHCARE_SYSTEM;

USE HEALTHCARE_SYSTEM;

CREATE TABLE user_account_T (
user_id int(11) not null AUTO_INCREMENT,
username varchar(100) not null,
user_password varchar(100) not null,
user_role ENUM('Patient', 'Doctor', 'Nurse', 'Receptionist') not null,
CONSTRAINT user_pk PRIMARY KEY (user_id)
);

CREATE TABLE patient_T (
patient_id int(11) not null AUTO_INCREMENT,
patient_name varchar(100) not null,
date_of_birth date not null,
gender ENUM('Male', 'Female', 'Other') not null,
address varchar(255),
phone_number varchar(15),
age int(11),
user_id int(11) not null,
CONSTRAINT patient_pk PRIMARY KEY (patient_id),
CONSTRAINT patient_fk FOREIGN KEY (user_id) REFERENCES user_account_T(user_id)
);

CREATE TABLE employee_T(
employee_id int(11) not null AUTO_INCREMENT,
employee_name varchar(100) not null,
gender ENUM('Male', 'Female', 'Other') not null,
phone_number varchar(15),
employee_schedule varchar(255),
employee_role ENUM('Doctor', 'Nurse', 'Receptionist') not null,
user_id int(11),
CONSTRAINT employee_pk PRIMARY KEY (employee_id),
CONSTRAINT employee_fk FOREIGN KEY (user_id) REFERENCES user_account_T(user_id)
);

CREATE TABLE doctor_T (
employee_id int(11) not null,
department varchar(100) not null,
license_number varchar(50) not null,
CONSTRAINT doctor_pk PRIMARY KEY (employee_id),
CONSTRAINT doctor_fk FOREIGN KEY (employee_id) REFERENCES employee_T(employee_id)
);

CREATE TABLE receptionist_T (
employee_id int(11) not null,
CONSTRAINT receptionist_pk PRIMARY KEY (employee_id),
CONSTRAINT receptionist_fk FOREIGN KEY (employee_id) REFERENCES employee_T(employee_id)
);

CREATE TABLE nurse_T (
employee_id int(11) not null,
certification varchar(100),
shift varchar(50),
CONSTRAINT nurse_pk PRIMARY KEY (employee_id),
CONSTRAINT nurse_fk FOREIGN KEY (employee_id) REFERENCES employee_T(employee_id)
);

CREATE TABLE appointment_T (
appointment_id int(11) not null AUTO_INCREMENT,
patient_id int(11) not null,
employee_id int(11) not null,
appointment_date date not null,
appointment_time time not null,
CONSTRAINT appointment_pk PRIMARY KEY (appointment_id),
CONSTRAINT appointment_fk1 FOREIGN KEY (patient_id) REFERENCES patient_T(patient_id),
CONSTRAINT appointment_fk2 FOREIGN KEY (employee_id) REFERENCES employee_T(employee_id)
);

CREATE TABLE medical_history_T (
medical_history_id int(11) not null AUTO_INCREMENT,
patient_id int(11) not null,
past_medical_history text,
family_medical_history text,
current_diagnoses text,
current_medications text,
CONSTRAINT medical_history_pk PRIMARY KEY (medical_history_id),
CONSTRAINT medical_history_fk FOREIGN KEY (patient_id) REFERENCES patient_T(patient_id)
);

CREATE TABLE billing_T (
billing_id int(11) not null AUTO_INCREMENT,
patient_id int(11) not null,
appointment_id int(11) not null,
total_amount decimal(10, 2) not null,
payment_status ENUM('Paid', 'Pending', 'Canceled') not null,
payment_date date,
CONSTRAINT billing_pk PRIMARY KEY (billing_id),
CONSTRAINT billing_fk1 FOREIGN KEY (patient_id) REFERENCES patient_T(patient_id),
CONSTRAINT billing_fk2 FOREIGN KEY (appointment_id) REFERENCES appointment_T(appointment_id)
);

CREATE TABLE pharmacy_T (
pharmacy_id int(11) not null AUTO_INCREMENT,
pharmacy_name varchar(100) not null,
address varchar(255),
phone_number varchar(15),
CONSTRAINT pharmacy_pk PRIMARY KEY (pharmacy_id)
);

CREATE TABLE medication_T (
medication_id int(11) not null AUTO_INCREMENT,
medication_name varchar(100) not null,
dosage varchar(50),
frequency varchar(50),
form ENUM('Tablet', 'Liquid'),
side_effects text,
CONSTRAINT medication_pk PRIMARY KEY (medication_id)
);

CREATE TABLE prescription_T (
prescription_id int(11) not null AUTO_INCREMENT,
patient_id int(11) not null,
doctor_id int(11) not null,
medication_id int(11) not null,
prescription_date date not null,
duration int,
instructions text,
CONSTRAINT prescription_pk PRIMARY KEY (prescription_id),
CONSTRAINT prescription_fk1 FOREIGN KEY (patient_id) REFERENCES patient_T(patient_id),
CONSTRAINT prescription_fk2 FOREIGN KEY (doctor_id) REFERENCES doctor_T(employee_id),
CONSTRAINT prescription_fk3 FOREIGN KEY (medication_id) REFERENCES medication_T(medication_id)
);

CREATE TABLE dispensation_T (
dispensation_id int(11) not null AUTO_INCREMENT,
prescription_id int(11) not null,
medication_id int(11) not null,
patient_id int(11) not null,
pharmacy_id int(11) not null,
dispensation_date date not null,
quantity_dispensed int(11) not null,
notes text,
CONSTRAINT dispensation_pk PRIMARY KEY (dispensation_id),
CONSTRAINT dispensation_fk1 FOREIGN KEY (prescription_id) REFERENCES prescription_T(prescription_id),
CONSTRAINT dispensation_fk2 FOREIGN KEY (medication_id) REFERENCES medication_T(medication_id),
CONSTRAINT dispensation_fk3 FOREIGN KEY (patient_id) REFERENCES patient_T(patient_id),
CONSTRAINT dispensation_fk4 FOREIGN KEY (pharmacy_id) REFERENCES pharmacy_T(pharmacy_id)
);

CREATE TABLE lab_tests_T (
lab_test_id int(11) not null AUTO_INCREMENT,
patient_id int(11) not null,
test_name varchar(100) not null,
test_date date not null,
results text,
lab_status ENUM('Pending', 'Completed') not null,
CONSTRAINT lab_test_pk PRIMARY KEY (lab_test_id),
CONSTRAINT lab_test_fk FOREIGN KEY (patient_id) REFERENCES patient_T(patient_id)
);
