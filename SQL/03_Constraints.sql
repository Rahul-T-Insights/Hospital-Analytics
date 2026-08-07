-- Constraints

ALTER TABLE mart.dim_patient
ADD CONSTRAINT pk_dim_patient
PRIMARY KEY (patient_id);

ALTER TABLE mart.fact_admissions
ADD CONSTRAINT pk_fact_admissions
PRIMARY KEY (admission_id);

ALTER TABLE mart.fact_admissions
ADD CONSTRAINT fk_fact_patient
FOREIGN KEY (patient_id)
REFERENCES mart.dim_patient(patient_id);

