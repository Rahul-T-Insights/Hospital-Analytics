-- INDEXES

-- Fact Admissions

CREATE INDEX idx_fact_admissions_patient
ON mart.fact_admissions(patient_id);

CREATE INDEX idx_fact_admissions_doctor
ON mart.fact_admissions(doctor_id);

CREATE INDEX idx_fact_admissions_department
ON mart.fact_admissions(department_id);

CREATE INDEX idx_fact_admissions_room
ON mart.fact_admissions(room_id);

-- Fact Appointments

CREATE INDEX idx_fact_appointments_patient
ON mart.fact_appointments(patient_id);

CREATE INDEX idx_fact_appointments_doctor
ON mart.fact_appointments(doctor_id);

CREATE INDEX idx_fact_appointments_department
ON mart.fact_appointments(department_id);

-- Fact Billing

CREATE INDEX idx_fact_billing_admission
ON mart.fact_billing(admission_id);