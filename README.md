# 🏥 Hospital Analytics Data Warehouse & Business Intelligence Dashboard

> An end-to-end healthcare analytics project built from scratch using Python, PostgreSQL, SQL, and Power BI.

---

## 📌 Project Overview

Hospitals generate large volumes of operational and financial data every day. However, raw transactional data alone does not provide meaningful insights for hospital administrators or executives.

The objective of this project was to design and build a complete analytics solution that transforms raw hospital data into business-ready dashboards.

Instead of connecting Power BI directly to raw tables, I followed a modern analytics workflow by:

- Designing a PostgreSQL Data Warehouse
- Building a Star Schema
- Creating SQL analytical views
- Developing interactive Power BI dashboards for different business stakeholders

This project demonstrates the complete BI lifecycle—from data engineering to business intelligence.

---

# 🏗 Project Architecture

```
                Raw Hospital Data
                        │
                        ▼
                Python ETL Pipeline
                        │
                        ▼
           PostgreSQL Data Warehouse
          (Fact & Dimension Modeling)
                        │
                        ▼
             SQL Analytical Views
                        │
                        ▼
          Power BI
             ├── Operational Dashboard
             └── Executive Dashboard
```

---

# 🛠 Tech Stack

| Technology | Purpose |
|------------|---------|
| Python | ETL Pipeline |
| PostgreSQL | Data Warehouse |
| SQL | Data Modeling & Business Logic |
| Power BI | Dashboard & Visualization |

---

# 📂 Data Warehouse Design

The warehouse follows a **Star Schema**.

## Fact Tables

- fact_admissions
- fact_appointments
- fact_billing

These tables store measurable business events.

---

## Dimension Tables

- dim_patient
- dim_doctors
- dim_departments
- dim_rooms
- dim_insurance_providers

These provide descriptive attributes used for slicing and filtering reports.

---

# 📊 SQL Analytical Views

Instead of performing every calculation inside Power BI, business logic was pushed into PostgreSQL by creating reusable analytical views.

### Hospital Overview

Provides high-level KPIs including:

- Total Patients
- Total Admissions
- Total Appointments
- Total Revenue

---

### Department Financial Summary

Calculates:

- Department Revenue
- Average Bill Amount
- Revenue per Admission
- Revenue Contribution %

---

### Doctor Revenue Analysis

Compares every doctor's monthly revenue against their own historical average using window functions.

Outputs:

- Monthly Revenue
- Average Monthly Revenue
- Percentage Difference

---

### Diagnosis Length of Stay Analysis

Analyzes diagnosis-wise patient stay patterns.

Calculates:

- Average Length of Stay
- Patients Staying Above Average
- Percentage Above Average

Supports filtering by Admission Type.

---

### Doctor Appointment Summary

Provides appointment statistics for every doctor including:

- Appointment Status
- Total Appointments
- Follow-up Required

---

### Insurance Summary

Analyzes financial contribution of insurance providers.

Calculates:

- Total Revenue
- Total Patients
- Average Bill Amount
- Revenue Contribution

---

# 📈 Power BI Dashboards

The reporting layer consists of two dashboards built for different stakeholders.

---

# 🏥 Operational Dashboard

Designed for hospital administrators to monitor day-to-day hospital operations.

### KPIs

- Total Patients
- Total Admissions
- Total Appointments
- Average Length of Stay

### Visualizations

- Admissions by Department
- Appointment Status
- Top Diagnoses
- Average Length of Stay by Department
- Monthly Admission Trend

### Interactive Filters

- Department
- Admission Type
- Diagnosis
- Insurance Provider

---

# 💰 Executive Dashboard

Designed for leadership to monitor financial performance.

### KPIs

- Total Revenue
- Average Bill
- Total Bills
- Total Admissions

### Visualizations

- Revenue by Department
- Revenue Trend
- Revenue by Insurance Provider
- Payment Status
- Doctor Monthly Revenue Performance

### Interactive Filters

- Department
- Admission Type
- Diagnosis
- Insurance Provider

---

# 💡 Business Questions Answered

The dashboards answer questions such as:

### Operations

- Which departments receive the highest admissions?
- Which diagnoses contribute to longer patient stays?
- How are appointments distributed by status?
- Which departments have the longest average LOS?

### Executive

- Which departments generate the highest revenue?
- Which insurance providers contribute the most revenue?
- How does hospital revenue change over time?
- Which doctors are performing above or below their historical average?

---

# 🎯 What I Learned

This project was built from scratch to strengthen practical skills in Data Engineering and Business Intelligence.

Key learnings include:

- Designing a dimensional data model
- Building a Star Schema
- Writing analytical SQL using CTEs and Window Functions
- Creating reusable SQL Views
- Developing ETL pipelines with Python
- Building interactive Power BI dashboards
- Translating business requirements into analytical reports

# 👨‍💻 Author

**Rahul Tiwari**

If you have any suggestions or feedback, feel free to connect with me.
