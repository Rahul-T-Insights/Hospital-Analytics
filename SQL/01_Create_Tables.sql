

-- INSURANCE PROVIDERS

CREATE TABLE insurance_providers
(
    insurance_id              INT PRIMARY KEY,
    insurance_provider_name   VARCHAR(100),
    plan_type                 VARCHAR(50)
);

-- PATIENTS

CREATE TABLE patients
(
    patient_id                INT PRIMARY KEY,
    first_name                VARCHAR(50),
    last_name                 VARCHAR(50),
    dob                       DATE,
    age                       INT,
    gender                    VARCHAR(20),
    address                   TEXT,
    city                      VARCHAR(100),
    state                     VARCHAR(100),
    zip_code                  VARCHAR(20),
    phone                     VARCHAR(50),
    email                     VARCHAR(100),
    blood_type                VARCHAR(10),
    insurance_id              INT,
	registration_date         Date
);

-- DEPARTMENTS

CREATE TABLE departments
(
    department_id             INT PRIMARY KEY,
    department_name           VARCHAR(100),
    floor                     INT,
    department_budget         NUMERIC(15,2),
    head_doctor_id            INT
);

-- DOCTORS

CREATE TABLE doctors
(
    doctor_id                 INT PRIMARY KEY,
    first_name                VARCHAR(50),
    last_name                 VARCHAR(50),
    gender                    VARCHAR(20),
    specialization            VARCHAR(100),
    department_id             INT,
    years_experience          INT,
    consultation_fee          NUMERIC(10,2),
    phone                     VARCHAR(50),
    email                     VARCHAR(100),
    hire_date                 DATE
);

-- ROOMS

CREATE TABLE rooms
(
    room_id                   INT PRIMARY KEY,
    room_number               VARCHAR(20),
    room_type                 VARCHAR(50),
    department_id             INT,
    capacity                  INT,
    daily_rate                NUMERIC(10,2)
);

-- ADMISSIONS

CREATE TABLE admissions
(
    admission_id              INT PRIMARY KEY,
    patient_id                INT,
    doctor_id                 INT,
    room_id                   INT,
    department_id             INT,
    admission_date            DATE,
    discharge_date            DATE,
    admission_type            VARCHAR(30),
    diagnosis                 VARCHAR(255),
    length_of_stay_days       INT,
    discharge_status          VARCHAR(30)
);

-- APPOINTMENTS

CREATE TABLE appointments
(
    appointment_id            INT PRIMARY KEY,
    patient_id                INT,
    doctor_id                 INT,
    department_id             INT,
    appointment_date          DATE,
    appointment_time          TIME,
    status                    VARCHAR(30),
    reason                    VARCHAR(255),
    follow_up_required        BOOLEAN
);

-- BILLING

CREATE TABLE  billing
(
    billing_id                INT PRIMARY KEY,
    admission_id              INT,
    service_type              VARCHAR(100),
    amount                    NUMERIC(12,2),
    insurance_covered         BOOLEAN,
    insurance_amount          NUMERIC(12,2),
    patient_amount            NUMERIC(12,2),
    payment_status            VARCHAR(30),
    billing_date              DATE
);



