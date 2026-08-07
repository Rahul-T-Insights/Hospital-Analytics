
# Load Libraries

import pandas as pd
import numpy as np

# Read Datasets

patients = pd.read_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Raw\patients.csv")
doctors = pd.read_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Raw\doctors.csv")
departments = pd.read_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Raw\departments.csv")
rooms = pd.read_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Raw\rooms.csv")
admissions = pd.read_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Raw\admissions.csv")
appointments = pd.read_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Raw\appointments.csv")
billing = pd.read_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Raw\billing.csv")
insurance = pd.read_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Raw\insurance_providers.csv")

# INSURANCE PROVIDERS ETL

# Inspect Dataset

print(insurance.head(5))
insurance.info()
print(insurance.shape)
print(insurance.describe(include="all"))

# Missing Values
print(insurance.isnull().sum())

# Duplicate Records

print(insurance.duplicated().sum())
print(insurance["insurance_id"].duplicated().sum())

# Standardize Column Names

insurance.columns = (insurance.columns.str.strip().str.lower())

# Standardize Text Columns

insurance["provider_name"] = (insurance["provider_name"].str.strip().str.title())
insurance["plan_type"] = (insurance["plan_type"].str.strip().str.title())

# Remove Duplicate Rows

insurance = insurance.drop_duplicates()

# Verify

print(insurance.isnull().sum())
print(insurance.shape)

# PATIENTS ETL

# Inspect Dataset

print(patients.head())
patients.info()
print(patients.shape)
print(patients.describe(include="all"))

# Missing Values

print(patients.isnull().sum())

# Duplicate Records

print(patients.duplicated().sum())
print(patients["patient_id"].duplicated().sum())

# Standardize Text Columns

patients["email"] = patients["email"].str.strip().str.lower()
patients["gender"] = patients["gender"].str.strip().str.title()
patients["blood_type"] = patients["blood_type"].str.strip().str.upper()

# Convert Date Columns

patients["dob"] = pd.to_datetime(patients["dob"],errors="coerce")
patients["registration_date"] = pd.to_datetime(patients["registration_date"],errors="coerce")

# DEPARTMENTS ETL

# Inspect Dataset

print(departments.head())
departments.info()
print(departments.shape)
print(departments.describe(include="all"))

# Missing Values

print(departments.isnull().sum())

# Duplicate Records

print(departments.duplicated().sum())
print(departments["department_id"].duplicated().sum())

# Standardize Text Columns

departments["department_name"] = (departments["department_name"].str.strip().str.title())

# Verify
print(departments.info())
print(departments.shape)

# DOCTORS ETL

# Inspect Dataset

print(doctors.head())
doctors.info()
print(doctors.shape)
print(doctors.describe(include="all"))

# Missing Values

print(doctors.isnull().sum())

# Duplicate Records

print(doctors.duplicated().sum())
print(doctors["doctor_id"].duplicated().sum())

# Standardize Text Columns

doctors["first_name"] = doctors["first_name"].str.strip().str.title()
doctors["last_name"] = doctors["last_name"].str.strip().str.title()
doctors["gender"] = doctors["gender"].str.strip().str.title()
doctors["specialization"] = (doctors["specialization"].str.strip().str.title())
doctors["email"] = doctors["email"].str.strip().str.lower()

# Convert Date Column

doctors["hire_date"] = pd.to_datetime(doctors["hire_date"],errors="coerce")

# Verify

print(doctors.info())
print(doctors.shape)

# ADMISSIONS ETL

# Inspect Dataset

print(admissions.head())
admissions.info()
print(admissions.shape)
print(admissions.describe(include="all"))

# Missing Values

print(admissions.isnull().sum())

# Duplicate Records

print(admissions.duplicated().sum())
print(admissions["admission_id"].duplicated().sum())

# Standardize Text Columns

admissions["admission_type"] = (admissions["admission_type"].str.strip().str.title())
admissions["diagnosis"] = (admissions["diagnosis"].str.strip().str.title())
admissions["discharge_status"] = (admissions["discharge_status"].str.strip().str.title())

# Convert Date Columns

admissions["admission_date"] = pd.to_datetime(admissions["admission_date"],errors="coerce")
admissions["discharge_date"] = pd.to_datetime(admissions["discharge_date"],errors="coerce")

# Verify

print(admissions.info())
print(admissions.shape)

# Standardize Text Columns

admissions["admission_type"] = (admissions["admission_type"].str.strip().str.title())
admissions["diagnosis"] = (admissions["diagnosis"].str.strip().str.title())
admissions["discharge_status"] = (admissions["discharge_status"].str.strip().str.title())

# Convert Date Columns

admissions["admission_date"] = pd.to_datetime(admissions["admission_date"],errors="coerce")
admissions["discharge_date"] = pd.to_datetime(admissions["discharge_date"],errors="coerce")

# Convert Datatype

admissions["length_of_stay_days"] = (
    admissions["length_of_stay_days"]
    .astype("Int64")
)

# Verify
print(admissions[admissions["discharge_date"].isnull()])

# BILLING ETL

# Inspect Dataset

print(billing.head())
billing.info()
print(billing.shape)
print(billing.describe(include="all"))

# Missing Values

print(billing.isnull().sum())

# Duplicate Records

print(billing.duplicated().sum())
print(billing["billing_id"].duplicated().sum())

# Standardize Text Columns

billing["service_type"] = (billing["service_type"].str.strip().str.title())
billing["payment_status"] = (billing["payment_status"].str.strip().str.title())

# Convert Date Column

billing["billing_date"] = pd.to_datetime(billing["billing_date"],errors="coerce")

# Verify

print(billing.info())
print(billing.shape)

# ROOMS ETL

# Inspect Dataset

print(rooms.head())
rooms.info()
print(rooms.shape)
print(rooms.describe(include="all"))

# Missing Values

print(rooms.isnull().sum())

# Duplicate Records

print(rooms.duplicated().sum())
print(rooms["room_id"].duplicated().sum())

# Standardize Text Columns

rooms["room_number"] = (rooms["room_number"].str.strip().str.upper())
rooms["room_type"] = (rooms["room_type"].str.strip().str.title())

# Verify

print(rooms.info())
print(rooms.shape)

# APPOINTMENTS ETL

# Inspect Dataset

print(appointments.head())
appointments.info()
print(appointments.shape)
print(appointments.describe(include="all"))

# Missing Values

print(appointments.isnull().sum())

# Duplicate Records

print(appointments.duplicated().sum())
print(appointments["appointment_id"].duplicated().sum())


# Standardize Text Columns

appointments["status"] = (appointments["status"].str.strip().str.title())
appointments["reason"] = (appointments["reason"].str.strip().str.title())

# Convert Date Column

appointments["appointment_date"] = pd.to_datetime(appointments["appointment_date"],errors="coerce")

# Convert Time Column

appointments["appointment_time"] = pd.to_datetime(appointments["appointment_time"],errors="coerce").dt.time

# Verify

print(appointments.info())
print(appointments.shape)

# EXPORT CLEAN DATA

# insurance.to_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Processed\insurance_providers.csv",index=False)
# patients.to_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Processed\patients.csv",index=False)
# departments.to_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Processed\departments.csv",index=False)
# doctors.to_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Processed\doctors.csv",index=False)
# rooms.to_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Processed\rooms.csv",index=False)
admissions.to_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Processed\admissions.csv",index=False)
# appointments.to_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Processed\appointments.csv",index=False)
# billing.to_csv(r"C:\Users\hp\Desktop\Projects\Hospital_Data_Engineering\Data\Processed\billing.csv",index=False)

print("\nETL Completed Successfully!")

