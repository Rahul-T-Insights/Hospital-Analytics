--- hospital_overview
SELECT ( SELECT count(*) AS count
           FROM mart.dim_patient) AS total_patients,
    ( SELECT count(*) AS count
           FROM mart.fact_admissions) AS total_admissions,
    ( SELECT count(*) AS count
           FROM mart.fact_appointments) AS total_appointments,
    ( SELECT round(sum(fact_billing.amount), 2) AS round
           FROM mart.fact_billing) AS total_revenue;

SELECT *
FROM mart.vw_hospital_overview;
		   
-- patient_demographics
SELECT gender,blood_type,state,count(*) AS total_patients
FROM mart.dim_patient
GROUP BY gender, blood_type, state;

-- department_performance
SELECT d.department_name,
    count(DISTINCT a.admission_id) AS total_admissions,
    round(avg(a.length_of_stay_days), 2) AS avg_length_of_stay,
    round(sum(b.amount), 2) AS total_revenue
   FROM ((mart.dim_departments d
     LEFT JOIN mart.fact_admissions a ON ((d.department_id = a.department_id)))
     LEFT JOIN mart.fact_billing b ON ((a.admission_id = b.admission_id)))
  GROUP BY d.department_name;

-- admission_analysis
 SELECT admission_type,
    diagnosis,
    discharge_status,
    count(*) AS total_admissions,
    avg(length_of_stay_days) AS avg_length_of_stay
   FROM mart.fact_admissions
  GROUP BY admission_type, diagnosis, discharge_status;

-- vw_appointment_analysis
 SELECT status,
    follow_up_required,
    count(*) AS total_appointments
   FROM mart.fact_appointments
  GROUP BY status, follow_up_required;

-- vw_billing_analysis
 SELECT service_type,
    payment_status,
    insurance_covered,
    count(*) AS total_transactions,
    sum(amount) AS total_revenue,
    sum(insurance_amount) AS insurance_paid,
    sum(patient_amount) AS patient_paid
   FROM mart.fact_billing
  GROUP BY service_type, payment_status, insurance_covered;

--


---------------------------- diagnosis_los_analysis
CREATE VIEW mart.vw_diagnosis_los_analysis AS
WITH diagnosis_avg AS (
SELECT admission_type,diagnosis,AVG(length_of_stay_days) AS avg_length_of_stay
FROM mart.fact_admissions
GROUP BY admission_type,diagnosis)
SELECT a.admission_type,a.diagnosis,COUNT(*) AS total_patients,ROUND(d.avg_length_of_stay, 2) AS avg_length_of_stay,
COUNT(*) FILTER (WHERE a.length_of_stay_days > d.avg_length_of_stay) AS patients_above_average,
ROUND(COUNT(*) FILTER (WHERE a.length_of_stay_days > d.avg_length_of_stay) * 100.0 / COUNT(*),2) AS percentage_above_average
FROM mart.fact_admissions a
JOIN diagnosis_avg d ON a.admission_type = d.admission_type AND a.diagnosis = d.diagnosis
GROUP BY a.admission_type,a.diagnosis,d.avg_length_of_stay;

select * from mart.vw_diagnosis_los_analysis;

------------------------------------------Doctor Appointment Summary

create or replace view mart.vw_Doctor_Appointment_Summary AS
SELECT d.doctor_id,d.first_name || ' ' || d.last_name AS doctor_name,d.specialization,a.status,
COUNT(*) AS total_appointments,COUNT(*) FILTER (WHERE a.follow_up_required = TRUE) AS follow_up_required
FROM mart.fact_appointments a
JOIN mart.dim_doctors d
ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_id,doctor_name,d.specialization,a.status;

select * from mart.vw_Doctor_Appointment_Summary;

-----------------------------------------doctor_revenue_analysis---------------------------------

CREATE OR REPLACE VIEW mart.vw_doctor_revenue_analysis AS
WITH doctor_monthly_revenue AS (
SELECT d.doctor_id,d.first_name || ' ' || d.last_name AS doctor_name,d.specialization,
DATE_TRUNC('month', b.billing_date) AS billing_month,SUM(b.amount) AS monthly_revenue
FROM mart.fact_billing b
JOIN mart.fact_admissions a ON b.admission_id = a.admission_id
JOIN mart.dim_doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_id,doctor_name,d.specialization,billing_month),
doctor_average AS (
SELECT doctor_id,AVG(monthly_revenue) AS avg_monthly_revenue
FROM doctor_monthly_revenue
GROUP BY doctor_id)
SELECT m.doctor_name,m.specialization,m.billing_month,ROUND(m.monthly_revenue,2) AS monthly_revenue,
ROUND(a.avg_monthly_revenue,2) AS avg_monthly_revenue,
ROUND(((m.monthly_revenue - a.avg_monthly_revenue)/a.avg_monthly_revenue) * 100,2) AS percentage_difference
FROM doctor_monthly_revenue m
JOIN doctor_average a ON m.doctor_id = a.doctor_id
ORDER BY percentage_difference ASC,m.doctor_name,m.billing_month;

select * from mart.vw_doctor_revenue_analysis;

---------------------------------------department financial summary
CREATE OR REPLACE VIEW mart.vw_department_financial_summary AS
SELECT d.department_id,d.department_name,COUNT(DISTINCT a.admission_id) AS total_admissions,
ROUND(SUM(b.amount), 2) AS total_revenue,
ROUND(AVG(b.amount), 2) AS average_bill_amount,
ROUND(SUM(b.amount) /COUNT(DISTINCT a.admission_id),2) AS revenue_per_admission,
ROUND(SUM(b.amount) * 100.0 /SUM(SUM(b.amount)) OVER (),2) AS revenue_contribution_percentage
FROM mart.dim_departments d
JOIN mart.fact_admissions a ON d.department_id = a.department_id
JOIN mart.fact_billing b ON a.admission_id = b.admission_id
GROUP BY d.department_id,d.department_name;

select * from mart.vw_department_financial_summary;

--------------------------------insurance_summary-------------------------
CREATE OR REPLACE VIEW mart.vw_insurance_summary AS
SELECT i.insurance_provider_name,i.plan_type,COUNT(DISTINCT p.patient_id) AS total_patients,
COUNT(DISTINCT a.admission_id) AS total_admissions,ROUND(SUM(b.amount),2) AS total_revenue,
ROUND(AVG(b.amount),2) AS average_bill_amount,
ROUND(SUM(b.amount) * 100.0 /SUM(SUM(b.amount)) OVER (),2) AS revenue_contribution_percentage
FROM mart.dim_insurance_providers i
JOIN mart.dim_patient p ON i.insurance_id = p.insurance_id
JOIN mart.fact_admissions a ON p.patient_id = a.patient_id
JOIN mart.fact_billing b ON a.admission_id = b.admission_id
GROUP BY i.insurance_provider_name,i.plan_type;

SELECT * FROM mart.vw_insurance_summary;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'mart';

SELECT table_name
FROM information_schema.views
WHERE table_schema = 'mart'
ORDER BY table_name;

SELECT
    viewname,
    definition
FROM pg_views
WHERE schemaname = 'mart'
ORDER BY viewname;