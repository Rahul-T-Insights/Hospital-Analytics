CREATE SCHEMA mart;

CREATE TABLE mart.dim_patient AS
SELECT patient_id,first_name,last_name,dob,gender,address,city,
       state,zip_code,blood_type,insurance_id,registration_date
FROM public.patients;

CREATE TABLE mart.dim_insurance_providers as
select insurance_id,insurance_provider_name,plan_type
from public.insurance_providers;

create table mart.fact_appointments as
select appointment_id,patient_id,doctor_id,department_id,appointment_date,
appointment_time,status,reason,follow_up_required 
from public.appointments;

create table mart.fact_billing as 
select billing_id,admission_id,service_type,amount,insurance_covered,insurance_amount,
patient_amount,payment_status,billing_date
from public.billing;

create table mart.fact_admissions as
select admission_id,patient_id,doctor_id,room_id,department_id,admission_date,
discharge_date,admission_type,diagnosis,length_of_stay_days,discharge_status 
from public.admissions;

create table mart.dim_departments as
select department_id,department_name,floor,department_budget,head_doctor_id 
from public.departments;

create table mart.dim_doctors as
select doctor_id,first_name,last_name,gender,specialization,department_id,
years_experience,consultation_fee,phone,email,hire_date 
from public.doctors;

create table mart.dim_rooms as
select room_id,room_number,room_type,department_id,capacity,daily_rate  
from public.rooms;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'mart'
ORDER BY table_name;