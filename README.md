# CarePlus | Outpatient Performance & Attendance Analytics

**Healthcare Analytics · Business Intelligence · Operational Performance · Scenario Modelling**

![Power BI](https://img.shields.io/badge/Power_BI-F2C811?logo=powerbi&logoColor=black) ![DAX](https://img.shields.io/badge/DAX-326BA4) ![Power Query](https://img.shields.io/badge/Power_Query-M-326BA4) ![Data](https://img.shields.io/badge/Data-Synthetic-lightgrey)

## Project overview

CarePlus is an independently developed Power BI solution for a fictional outpatient healthcare service. It explores appointment attendance, booked-slot utilisation, non-attendance patterns and potential opportunities to recover clinical capacity. The solution combines descriptive analysis with interactive what-if modelling to support operational planning.

![CarePlus executive overview](Screenshots/01.%20Overview.png)

## Business objectives

- Monitor outpatient demand, appointment outcomes and attendance trends.
- Understand the operational impact of cancellations and Did Not Attend (DNA) appointments.
- Explore attendance patterns across specialties, hospitals and patient or booking characteristics.
- Estimate potential capacity recovery and cost avoidance under alternative DNA reduction scenarios.

## Key findings | Simulated full-year 2026

| KPI | Result |
|---|---:|
| Scheduled appointments | 16,000 |
| Attended appointments | 13,855 |
| Cancelled appointments | 1,222 |
| DNA appointments | 923 |
| DNA rate | 6.25% |
| Attendance rate | 93.75% |
| Booked-slot utilisation | 86.59% |
| DNA rate change vs prior year | −2.72 percentage points |
| Lost appointment capacity | 402.5 hours |
| Estimated DNA cost | £67,620 |

Attendance and DNA rates exclude cancellations, whereas booked-slot utilisation uses all scheduled appointments as its denominator. Missed appointments have an average booking lead time of 32.11 days, compared with 29.35 days overall. This is an observed association rather than evidence of causation.

## Dashboard walkthrough

### 1. Overview

Executive appointment KPIs, current and prior-year trends, rolling DNA rate, specialty and hospital comparisons and appointment outcomes.
[View Overview dashboard](Screenshots/01.%20Overview.png)

### 2. Operational performance

Capacity utilisation, appointment outcome waterfall, mode-level comparisons, hospital performance and dynamic day/time heatmaps.

![Operational dashboard](Screenshots/02.%20Operational.png)

### 3. Attendance analysis

Repeat non-attendance, age and deprivation patterns, appointment characteristics and booking lead-time analysis.

![Attendance dashboard](Screenshots/03.%20Attendence.png)

### 4. Opportunities and scenario modelling

Interactive DNA reduction scenarios that estimate recovered appointments, slot hours, projected attendance and potential cost avoidance.

![Opportunities dashboard](Screenshots/04.%20Opportunities.png)

## Scenario analysis | Illustrative 20% DNA reduction

| Metric | Baseline | Projected |
|---|---:|---:|
| DNA appointments | 923 | ~738 |
| DNA rate | 6.25% | 5.00% |
| Attendance rate | 93.75% | 95.00% |
| Lost appointment hours | 402.5 | 322.0 |
| Estimated DNA cost | £67,620 | £54,096 |

The scenario represents approximately **185 recovered appointments, 80.5 recovered appointment hours and £13,524 potential cost avoidance**. It assumes prevented DNAs become attended, all else remains constant, hours and costs reduce proportionally and intervention costs are excluded. These are hypothetical estimates, not realised savings.

## Technical implementation

| Component | Approach |
|---|---|
| Data preparation | CSV ingestion and Power Query M transformations |
| Semantic model | Multi-fact dimensional model with appointment and daily capacity data |
| Business logic | DAX measures, calculated columns, date and time bands |
| Time intelligence | Prior-year comparison and rolling 12-month measures |
| Dynamic reporting | Disconnected heatmap and waterfall selectors, rankings and narrative measures |
| Scenario modelling | Disconnected what-if parameter and projected outcome calculations |

### Data model

Appointment-level records and daily hospital-specialty capacity are supported by shared hospital, specialty and calendar dimensions. Patient attributes filter appointment records. The different fact-table grains are important when interpreting capacity and patient-level metrics.

![CarePlus data model](Screenshots/05.%20Data%20model.png)

## Business recommendations

| Priority | Recommended action |
|---|---|
| Recover unused capacity | Pilot cancellation waitlists and earlier cancellation notices. |
| Improve attendance | Test targeted reminders and flexible scheduling for longer lead-time bookings. |
| Support equitable access | Explore deprivation and appointment-mode patterns with suitable minimum sample sizes. |
| Evaluate interventions | Monitor attendance, utilisation and intervention costs before claiming savings. |

## Project files

- [Power BI report (PBIX)](Outpatient%20Performance%20%26%20Attendance%20Analytics.pbix)
- [Full dashboard report (PDF)](Outpatient%20Performance%20%26%20Attendance%20Analytics.pdf)
- [Source datasets](Data%202024%20to%202026/)
- [Implementation scripts](Scripts/)

## Supporting documentation

- [Business insights and recommendations](Documentation/Business_Insights.md)
- [Technical documentation](Documentation/Technical_Documentation.md)
- [KPI dictionary](Documentation/KPI_Dictionary.md)
- [Data dictionary](Documentation/Data_Dictionary.csv)
- [Table inventory](Documentation/Table_Inventory.csv)

## Scope and limitations

This repository presents the reporting solution and supporting documentation. The repository includes the Power BI report, synthetic source data and implementation scripts. Daily capacity records do not contain time-of-day or patient-level detail, so capacity-based heatmap results require validation at those grains. Scenario slicer interactions should also be validated. Costs are illustrative slot estimates, not actual NHS expenditure. Observed attendance patterns are descriptive, not causal.

## Data disclaimer

Independent professional portfolio project using synthetic data. No real patient records, clinical outcomes, achieved savings or production deployment are represented.
