USE HEALTHCARE_SYSTEM;

/*Query 1 to list patient details along with their user account*/
SELECT p.patient_name, p.date_of_birth, p.gender, p.address, p.phone_number, u.username
FROM patient_T p
JOIN user_account_T u ON p.user_id = u.user_id;

/*Query 2 to list all appointments for a patient*/
SELECT a.appointment_date, a.appointment_time, e.employee_name
FROM appointment_T a
JOIN patient_T p ON a.patient_id = p.patient_id
JOIN employee_T e ON a.employee_id = e.employee_id
WHERE p.patient_id = 1;

/*Query 3 to list all prescriptions for a patient*/
SELECT pr.prescription_date, m.medication_name, pr.duration, pr.instructions
FROM prescription_T pr
JOIN medication_T m ON pr.medication_id = m.medication_id
JOIN patient_T p ON pr.patient_id = p.patient_id
WHERE p.patient_id = 1;

/*Query 4 to list billing information for a patient*/
SELECT b.total_amount, b.payment_status, b.payment_date
FROM billing_T b
JOIN patient_T p ON b.patient_id = p.patient_id
WHERE p.patient_id = 1;

/*Query 5 to list all prescriptions that have a duration longer than 10 days*/
SELECT p.patient_name, m.medication_name, pr.prescription_date, pr.duration, pr.instructions
FROM prescription_T pr
JOIN patient_T p ON pr.patient_id = p.patient_id
JOIN medication_T m ON pr.medication_id = m.medication_id
WHERE pr.duration > 10;

/*View 1: Patients and their assigned doctors*/
CREATE VIEW patients_doctors_view AS
SELECT p.patient_name, e.employee_name AS doctor_name
FROM patient_T p
JOIN appointment_T a ON p.patient_id = a.patient_id
JOIN employee_T e ON a.employee_id = e.employee_id
WHERE e.employee_role = 'Doctor';

SELECT * FROM patients_doctors_view;

/*View 2: Billing status summary*/
CREATE VIEW billing_summary_view AS
SELECT p.patient_name, b.total_amount, b.payment_status
FROM patient_T p
JOIN billing_T b ON p.patient_id = b.patient_id;

SELECT * FROM billing_summary_view;