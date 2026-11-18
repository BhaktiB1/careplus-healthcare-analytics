# CarePulse | KPI dictionary

Definitions and exact formulas from saved model. All calculations respect filter context unless specified.

## Total Appointments

Home table: 01 Appointment Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Total Appointments =
COUNTROWS(fact_appointments)
```

## DNA Appointments

Home table: 01 Appointment Measures  
Supporting measure; calculation and dependencies shown below.

```dax
DNA Appointments =
CALCULATE(
    [Total Appointments],
    fact_appointments[dna_flag] = 1
)
```

## Cancelled Appointments

Home table: 01 Appointment Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Cancelled Appointments =
CALCULATE(
    [Total Appointments],
    fact_appointments[cancelled_flag] = 1
)
```

## DNA Rate %

Home table: 01 Appointment Measures  
DNA / (attended + DNA), excludes cancellations.

```dax
DNA Rate % =
DIVIDE(
    [DNA Appointments],
    [Attended Appointments] + [DNA Appointments]
)
```

## Attendance Rate %

Home table: 01 Appointment Measures  
Attended / (attended + DNA), excludes cancellations.

```dax
Attendance Rate % =
DIVIDE(
    [Attended Appointments],
    [Attended Appointments] + [DNA Appointments]
)
```

## Attended Appointments

Home table: 01 Appointment Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Attended Appointments =
CALCULATE(
    [Total Appointments],
    fact_appointments[attended_flag] = 1
)
```

## Completed Outcome Appointments

Home table: 01 Appointment Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Completed Outcome Appointments =
[Attended Appointments] + [DNA Appointments]
```

## Cancellation Rate %

Home table: 01 Appointment Measures  
Cancelled / all bookings.

```dax
Cancellation Rate % =
DIVIDE(
    [Cancelled Appointments],
    [Total Appointments]
)
```

## DNA Contribution %

Home table: 01 Appointment Measures  
Supporting measure; calculation and dependencies shown below.

```dax
DNA Contribution % =
DIVIDE(
    [DNA Appointments],
    CALCULATE(
        [DNA Appointments],
        ALLSELECTED(dim_specialties)
    )
)
```

## Average Appointments per Month

Home table: 01 Appointment Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Average Appointments per Month =
AVERAGEX(
    VALUES(calendar[Year Month]),
    [Total Appointments]
)
```

## DNA Heatmap Colour

Home table: 01 Appointment Measures  
Presentation helper for conditional formatting.

```dax
DNA Heatmap Colour =
VAR Rate = [DNA Rate %]
RETURN
    SWITCH(
        TRUE(),
        ISBLANK(Rate), BLANK(),
        Rate >= 0.08, "#F4CCCC",
        Rate >= 0.06, "#FCE5CD",
        "#D9EAD3"
    )
```

## Non-Attended Slots

Home table: 01 Appointment Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Non-Attended Slots =
[Scheduled Slots] - [Attended Appointments]
```

## Scheduled Appointments

Home table: 01 Appointment Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Scheduled Appointments =
COUNTROWS(fact_appointments)
```

## Total Appointments PY

Home table: 02 Time Intelligence  
Supporting measure; calculation and dependencies shown below.

```dax
Total Appointments PY =
CALCULATE(
    [Total Appointments],
    SAMEPERIODLASTYEAR(calendar[Date])
)
```

## Appointments YoY %

Home table: 02 Time Intelligence  
Supporting measure; calculation and dependencies shown below.

```dax
Appointments YoY % =
DIVIDE(
    [Total Appointments] - [Total Appointments PY],
    [Total Appointments PY]
)
```

## DNA Appointments PY

Home table: 02 Time Intelligence  
Supporting measure; calculation and dependencies shown below.

```dax
DNA Appointments PY =
CALCULATE(
    [DNA Appointments],
    SAMEPERIODLASTYEAR(calendar[Date])
)
```

## DNA Rate PY

Home table: 02 Time Intelligence  
Supporting measure; calculation and dependencies shown below.

```dax
DNA Rate PY =
CALCULATE(
    [DNA Rate %],
    SAMEPERIODLASTYEAR(calendar[Date])
)
```

## DNA Rate YoY pp

Home table: 02 Time Intelligence  
Current less prior-year rate in percentage points.

```dax
DNA Rate YoY pp =
VAR PreviousRate = [DNA Rate PY]
RETURN
IF(
    NOT ISBLANK(PreviousRate),
    ([DNA Rate %] - PreviousRate) * 100
)
```

## Attendance Rate PY

Home table: 02 Time Intelligence  
Supporting measure; calculation and dependencies shown below.

```dax
Attendance Rate PY =
CALCULATE(
    [Attendance Rate %],
    SAMEPERIODLASTYEAR(calendar[Date])
)
```

## Rolling 12M Appointments

Home table: 02 Time Intelligence  
Supporting measure; calculation and dependencies shown below.

```dax
Rolling 12M Appointments =
CALCULATE(
    [Total Appointments],
    DATESINPERIOD(
        calendar[Date],
        MAX(calendar[Date]),
        -12,
        MONTH
    )
)
```

## Rolling 12M DNA Rate

Home table: 02 Time Intelligence  
Supporting measure; calculation and dependencies shown below.

```dax
Rolling 12M DNA Rate =
CALCULATE(
    [DNA Rate %],
    DATESINPERIOD(
        calendar[Date],
        MAX(calendar[Date]),
        -12,
        MONTH
    )
)
```

## Scheduled Slots

Home table: 03 Operational Measures  
Sum of daily scheduled slots.

```dax
Scheduled Slots =
SUM(fact_daily_capacity[scheduled_slots])
```

## Available Slots Estimate

Home table: 03 Operational Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Available Slots Estimate =
SUM(
    fact_daily_capacity[available_slots_estimate]
)
```

## Scheduled Slot Attendance %

Home table: 03 Operational Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Scheduled Slot Attendance % =
DIVIDE(
    [Attended Slots],
    [Scheduled Slots]
)
```

## Attended Slots

Home table: 03 Operational Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Attended Slots =
SUM(fact_daily_capacity[attended_slots])
```

## Total Slot Hours

Home table: 03 Operational Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Total Slot Hours =
DIVIDE(
    SUM(fact_appointments[slot_minutes]),
    60
)
```

## Attended Slot Hours

Home table: 03 Operational Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Attended Slot Hours =
DIVIDE(
    CALCULATE(
        SUM(fact_appointments[slot_minutes]),
        fact_appointments[attended_flag] = 1
    ),
    60
)
```

## Average Lead Time

Home table: 03 Operational Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Average Lead Time =
AVERAGE(fact_appointments[lead_time_days])
```

## Average Slot Duration

Home table: 03 Operational Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Average Slot Duration =
AVERAGE(fact_appointments[slot_minutes])
```

## DNA Slot Hours

Home table: 03 Operational Measures  
Missed slot minutes / 60.

```dax
DNA Slot Hours =
DIVIDE(
    CALCULATE(
        SUM(fact_appointments[slot_minutes]),
        fact_appointments[dna_flag] = 1
    ),
    60
)
```

## Capacity Utilisation %

Home table: 03 Operational Measures  
Attended slots / scheduled slots from daily capacity, not all available capacity.

```dax
Capacity Utilisation % =
DIVIDE(
    [Attended Slots],
    [Scheduled Slots]
)
```

## Capacity Waterfall Value

Home table: 03 Operational Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Capacity Waterfall Value =
SWITCH(
    SELECTEDVALUE('Capacity Waterfall'[Stage]),
    "Scheduled", [Scheduled Slots],
    "Cancelled", -[Cancelled Appointments],
    "DNA", -[DNA Appointments],
    BLANK()
)
```

## Operational Heatmap Value

Home table: 03 Operational Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Operational Heatmap Value =
VAR SelectedMetric =
    SELECTEDVALUE(
        'Operational Heatmap Selector'[Metric],
        "Capacity Utilisation %"
    )
RETURN
    SWITCH(
        SelectedMetric,
        "Capacity Utilisation %", [Capacity Utilisation %],
        "DNA Rate %", [DNA Rate %],
        "Cancellation Rate %", [Cancellation Rate %],
        "Scheduled Appointments", [Scheduled Appointments]
    )
```

## Operational Heatmap Colour

Home table: 03 Operational Measures  
Presentation helper for conditional formatting.

```dax
Operational Heatmap Colour =
VAR Metric =
    SELECTEDVALUE(
        'Operational Heatmap Selector'[Metric],
        "Capacity Utilisation %"
    )
VAR Val = [Operational Heatmap Value]

RETURN
IF(
    ISBLANK(Val),
    BLANK(),
    SWITCH(
        Metric,

        "Capacity Utilisation %",
            SWITCH(
                TRUE(),
                Val >= 0.90, "#D9EAD3",
                Val >= 0.85, "#FCE5CD",
                "#F4CCCC"
            ),

        "DNA Rate %",
            SWITCH(
                TRUE(),
                Val <= 0.05, "#D9EAD3",
                Val <= 0.07, "#FCE5CD",
                "#F4CCCC"
            ),

        "Cancellation Rate %",
            SWITCH(
                TRUE(),
                Val <= 0.05, "#D9EAD3",
                Val <= 0.08, "#FCE5CD",
                "#F4CCCC"
            ),

        "Scheduled Appointments",
            "",

        BLANK()
    )
)
```

## Operational Heatmap Title

Home table: 03 Operational Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Operational Heatmap Title =
SELECTEDVALUE(
    'Operational Heatmap Selector'[Metric],
    "Capacity Utilisation %"
)
& " by Day & Time"
```

## Unique Patients

Home table: 04 Patient Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Unique Patients =
DISTINCTCOUNT(fact_appointments[patient_id])
```

## Appointments per Patient

Home table: 04 Patient Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Appointments per Patient =
DIVIDE(
    [Total Appointments],
    [Unique Patients]
)
```

## Patients with DNA

Home table: 04 Patient Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Patients with DNA =
CALCULATE(
    DISTINCTCOUNT(fact_appointments[patient_id]),
    fact_appointments[dna_flag] = 1
)
```

## Repeat DNA Patients

Home table: 04 Patient Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Repeat DNA Patients =
COUNTROWS(
    FILTER(
        VALUES(fact_appointments[patient_id]),
        CALCULATE([DNA Appointments]) >= 2
    )
)
```

## Repeat DNA Rate %

Home table: 04 Patient Measures  
Patients with at least two DNAs / patients with any DNA.

```dax
Repeat DNA Rate % =
DIVIDE(
    [Repeat DNA Patients],
    [Patients with DNA]
)
```

## Average Lead Time DNA

Home table: 04 Patient Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Average Lead Time DNA =
CALCULATE(
    [Average Lead Time],
    fact_appointments[dna_flag] = 1
)
```

## DNA Lead Time Gap

Home table: 04 Patient Measures  
Mean missed appointment lead time minus overall mean.

```dax
DNA Lead Time Gap =
[Average Lead Time DNA] - [Average Lead Time]
```

## Potential Appointments Recovered

Home table: 05 Improvement Measures  
DNA count times target reduction.

```dax
Potential Appointments Recovered =
[DNA Appointments] *
[DNA Reduction Target Value]
```

## Potential Hours Recovered

Home table: 05 Improvement Measures  
Lost hours times target.

```dax
Potential Hours Recovered =
[DNA Slot Hours] *
[DNA Reduction Target Value]
```

## Projected DNA Appointments

Home table: 05 Improvement Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Projected DNA Appointments =
[DNA Appointments] *
(1 - [DNA Reduction Target Value])
```

## Projected DNA Rate %

Home table: 05 Improvement Measures  
Baseline DNA rate times (1 minus target).

```dax
Projected DNA Rate % =
[DNA Rate %] *
(1 - [DNA Reduction Target Value])
```

## Estimated DNA Cost

Home table: 05 Improvement Measures  
Sum of illustrative missed slot costs, not actual cash loss.

```dax
Estimated DNA Cost =
CALCULATE(
    SUM(fact_appointments[illustrative_slot_cost_gbp]),
    fact_appointments[dna_flag] = 1
)
```

## Potential Cost Avoidance

Home table: 05 Improvement Measures  
Estimated DNA cost times target; not cash saving.

```dax
Potential Cost Avoidance =
[Estimated DNA Cost] *
[DNA Reduction Target Value]
```

## Projected Attendance Rate %

Home table: 05 Improvement Measures  
(Attended + recovered appointments) / (attended + DNA).

```dax
Projected Attendance Rate % =
VAR ProjectedDNA = [Projected DNA Appointments]
VAR CompletedAppointments =
    [Completed Outcome Appointments]
RETURN
DIVIDE(
    [Attended Appointments]
        + [Potential Appointments Recovered],
    CompletedAppointments
)
```

## Specialty DNA Rank

Home table: 05 Improvement Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Specialty DNA Rank =
IF(
    ISBLANK([DNA Appointments]),
    BLANK(),
    RANKX(
        ALLSELECTED(dim_specialties[specialty_name]),
        [DNA Appointments],
        ,
        DESC,
        DENSE
    )
)
```

## Projected Lost Slot Hours

Home table: 05 Improvement Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Projected Lost Slot Hours =
[DNA Slot Hours] -
[Potential Hours Recovered]
```

## Projected DNA Cost

Home table: 05 Improvement Measures  
Supporting measure; calculation and dependencies shown below.

```dax
Projected DNA Cost =
[Estimated DNA Cost] -
[Potential Cost Avoidance]
```

## Highest DNA Specialty Insight

Home table: 06_Dynamic_Insights  
Filter-responsive narrative.

```dax
Highest DNA Specialty Insight =
VAR RankedSpecialties =
    TOPN(
        1,
        FILTER(
            ADDCOLUMNS(
                ALLSELECTED(dim_specialties[specialty_name]),
                "@Rate", [DNA Rate %],
                "@Volume", [Completed Outcome Appointments]
            ),
            [@Volume] >= 30
                && NOT ISBLANK([@Rate])
        ),
        [@Rate], DESC,
        dim_specialties[specialty_name], ASC
    )
VAR Specialty =
    MAXX(
        RankedSpecialties,
        dim_specialties[specialty_name]
    )
VAR Rate =
    MAXX(RankedSpecialties, [@Rate])
RETURN
IF(
    ISBLANK(Specialty),
    "Insufficient data for specialty comparison.",
    Specialty & " has the highest DNA rate at "
        & FORMAT(Rate, "0.0%") & "."
)
```

## DNA Trend Insight

Home table: 06_Dynamic_Insights  
Filter-responsive narrative.

```dax
DNA Trend Insight =
VAR Change = [DNA Rate YoY pp]
RETURN
SWITCH(
    TRUE(),
    ISBLANK(Change),
        "No comparable previous-year data.",
    Change > 0,
        "DNA rate increased by "
        & FORMAT(Change, "0.0")
        & " percentage points versus last year.",
    Change < 0,
        "DNA rate decreased by "
        & FORMAT(ABS(Change), "0.0")
        & " percentage points versus last year.",
    "DNA rate is unchanged versus last year."
)
```

## Lead Time Insight

Home table: 06_Dynamic_Insights  
Filter-responsive narrative.

```dax
Lead Time Insight =
VAR DNALeadTime = [Average Lead Time DNA]
VAR OverallLeadTime = [Average Lead Time]
RETURN
IF(
    ISBLANK(DNALeadTime),
    "No missed appointments in this selection.",
    "Average booking lead time for missed appointments: "
    & FORMAT(DNALeadTime, "0.0")
    & " days, compared with "
    & FORMAT(OverallLeadTime, "0.0")
    & " days across all appointments."
)
```

## Scenario Insight

Home table: 06_Dynamic_Insights  
Filter-responsive narrative.

```dax
Scenario Insight =
VAR Reduction =
    [DNA Reduction Target Value]
VAR Appointments =
    [Potential Appointments Recovered]
VAR Hours =
    [Potential Hours Recovered]
RETURN
IF(
    ISBLANK([DNA Appointments]),
    "No appointment data available.",
    "A hypothetical "
        & FORMAT(Reduction, "0%")
        & " reduction in missed appointments could free approximately "
        & FORMAT(Appointments, "#,##0")
        & " appointments and "
        & FORMAT(Hours, "#,##0.0")
        & " clinical slot hours in the selected period."
)
```

## Priority Specialty Insight

Home table: 06_Dynamic_Insights  
Filter-responsive narrative.

```dax
Priority Specialty Insight =
VAR Ranked =
    TOPN(
        1,
        FILTER(
            ADDCOLUMNS(
                ALLSELECTED(dim_specialties[specialty_name]),
                "@DNA", [DNA Appointments],
                "@Rate", [DNA Rate %]
            ),
            [@DNA] > 0
        ),
        [@DNA], DESC,
        dim_specialties[specialty_name], ASC
    )
VAR Specialty =
    MAXX(Ranked, dim_specialties[specialty_name])
VAR Missed =
    MAXX(Ranked, [@DNA])
RETURN
IF(
    ISBLANK(Specialty),
    "No missed appointments in this selection.",
    "Prioritise reviewing " & Specialty
        & ", which accounts for "
        & FORMAT(Missed, "#,##0")
        & " missed appointments in the selected period."
)
```

## Executive Performance Summary

Home table: 06_Dynamic_Insights  
Filter-responsive narrative.

```dax
Executive Performance Summary =
VAR DNA = [DNA Rate %]
VAR Attendance = [Attendance Rate %]
VAR YoY = [DNA Rate YoY pp]
VAR Hours = [DNA Slot Hours]
VAR Cost = [Estimated DNA Cost]

RETURN
IF(
    ISBLANK(DNA),
    "No data available for the selected filters.",

    "PERFORMANCE SUMMARY"
    & UNICHAR(10)
    & "Attendance stands at "
    & FORMAT(Attendance, "0.0%")
    & ", with a DNA rate of "
    & FORMAT(DNA, "0.0%")
    & ". "

    & SWITCH(
        TRUE(),
        ISBLANK(YoY), "",
        YoY < 0,
            "DNA rate improved by "
            & FORMAT(ABS(YoY), "0.00")
            & " pp year on year.",
        YoY > 0,
            "DNA rate increased by "
            & FORMAT(YoY, "0.00")
            & " pp year on year.",
        "DNA rate is unchanged year on year."
    )

    & UNICHAR(10) & UNICHAR(10)

    & "SERVICE IMPACT"
    & UNICHAR(10)
    & "Missed appointments account for "
    & FORMAT(Hours, "#,##0.0")
    & " slot hours and an estimated "
    & FORMAT(Cost, "£#,##0")
    & " in costs."
)
```

## Improvement Opportunities & Priorities

Home table: 06_Dynamic_Insights  
Filter-responsive narrative.

```dax
Improvement Opportunities & Priorities =
VAR Target = [DNA Reduction Target Value]
VAR Hours = [Potential Hours Recovered]
VAR Appts = [Potential Appointments Recovered]
VAR Cost = [Potential Cost Avoidance]
VAR Attendance = [Projected Attendance Rate %]

VAR SpecialtyTable =
    ADDCOLUMNS(
        ALLSELECTED(dim_specialties[specialty_name]),
        "@Hours", [Potential Hours Recovered]
    )

VAR TopSpecialty =
    TOPN(
        1,
        FILTER(SpecialtyTable, [@Hours] > 0),
        [@Hours], DESC,
        dim_specialties[specialty_name], ASC
    )

VAR SpecialtyName =
    CONCATENATEX(
        TopSpecialty,
        dim_specialties[specialty_name]
    )

VAR SpecialtyHours =
    MAXX(TopSpecialty, [@Hours])

RETURN
IF(
    ISBLANK([DNA Rate %]),
    "No opportunity data for selected filters.",

    "IMPROVEMENT OPPORTUNITY"
    & UNICHAR(10)
    & "A "
    & FORMAT(Target, "0%")
    & " DNA reduction could recover "
    & FORMAT(Appts, "#,##0")
    & " appointments and "
    & FORMAT(Hours, "0.0")
    & " slot hours."

    & UNICHAR(10) & UNICHAR(10)

    & "ESTIMATED IMPACT"
    & UNICHAR(10)
    & "Projected attendance could reach "
    & FORMAT(Attendance, "0.0%")
    & ", with potential cost avoidance of "
    & FORMAT(Cost, "£#,##0")
    & "."

    & UNICHAR(10) & UNICHAR(10)

    & "MANAGEMENT PRIORITY"
    & UNICHAR(10)

    & IF(
        COUNTROWS(TopSpecialty) > 0,
        "Assess interventions in "
        & SpecialtyName
        & ", which offers the greatest potential "
        & "capacity recovery ("
        & FORMAT(SpecialtyHours, "0.0")
        & " hours).",

        "Select a positive reduction target or "
        & "review baseline attendance performance."
    )
)
```

## Attendance Insights & Priorities

Home table: 06_Dynamic_Insights  
Filter-responsive narrative.

```dax
Attendance Insights & Priorities =
VAR DNA = [DNA Rate %]
VAR LeadGap = [DNA Lead Time Gap]

VAR LeadTable =
    ADDCOLUMNS(
        ALLSELECTED(fact_appointments[Lead Time Band]),
        "@DNA", [DNA Rate %],
        "@Volume", [Scheduled Slots]
    )

VAR WorstLead =
    TOPN(
        1,
        FILTER(
            LeadTable,
            [@Volume] >= 100
                && NOT ISBLANK([@DNA])
        ),
        [@DNA], DESC,
        fact_appointments[Lead Time Band], ASC
    )

VAR WorstLeadName =
    CONCATENATEX(
        WorstLead,
        fact_appointments[Lead Time Band]
    )

VAR WorstLeadRate =
    MAXX(WorstLead, [@DNA])

VAR IMDTable =
    ADDCOLUMNS(
        FILTER(
            ALLSELECTED(dim_patients[imd_decile]),
            NOT ISBLANK(dim_patients[imd_decile])
        ),
        "@DNA", [DNA Rate %],
        "@Volume", [Scheduled Slots]
    )

VAR EligibleIMD =
    FILTER(
        IMDTable,
        [@Volume] >= 100
            && NOT ISBLANK([@DNA])
    )

VAR HighestIMD =
    TOPN(
        1,
        EligibleIMD,
        [@DNA], DESC,
        dim_patients[imd_decile], ASC
    )

VAR LowestIMD =
    TOPN(
        1,
        EligibleIMD,
        [@DNA], ASC,
        dim_patients[imd_decile], ASC
    )

RETURN
IF(
    ISBLANK(DNA),
    "No attendance data for selected filters.",

    "BOOKING & ATTENDANCE PATTERNS"
    & UNICHAR(10)

    & IF(
        COUNTROWS(WorstLead) > 0,
        "The highest eligible DNA rate occurs in "
        & WorstLeadName
        & " ("
        & FORMAT(WorstLeadRate, "0.00%")
        & "). ",
        "Insufficient volume to rank lead time groups. "
    )

    & SWITCH(
        TRUE(),
        ISBLANK(LeadGap), "",
        LeadGap > 0,
            "Missed appointments have lead times "
            & FORMAT(LeadGap, "0.0")
            & " days longer than average.",
        LeadGap < 0,
            "Missed appointments have lead times "
            & FORMAT(ABS(LeadGap), "0.0")
            & " days shorter than average.",
        "Average lead times are similar."
    )

    & UNICHAR(10) & UNICHAR(10)

    & "HEALTH INEQUALITIES"
    & UNICHAR(10)

    & IF(
        COUNTROWS(EligibleIMD) >= 2,

        "DNA rates range from "
        & FORMAT(MAXX(LowestIMD, [@DNA]), "0.00%")
        & " in IMD decile "
        & MAXX(
            LowestIMD,
            dim_patients[imd_decile]
        )
        & " to "
        & FORMAT(MAXX(HighestIMD, [@DNA]), "0.00%")
        & " in decile "
        & MAXX(
            HighestIMD,
            dim_patients[imd_decile]
        )
        & ".",

        "Insufficient comparable groups to assess "
        & "deprivation differences."
    )

    & UNICHAR(10) & UNICHAR(10)

    & "MANAGEMENT PRIORITY"
    & UNICHAR(10)
    & "Investigate attendance barriers and consider "
    & "targeted reminders and flexible scheduling."
)
```

## Operational Insights & Priorities

Home table: 06_Dynamic_Insights  
Filter-responsive narrative.

```dax
Operational Insights & Priorities =
VAR Utilisation = [Capacity Utilisation %]
VAR Scheduled = [Scheduled Slots]
VAR LostSlots = [Non-Attended Slots]
VAR Cancelled = [Cancelled Appointments]
VAR DNA = [DNA Appointments]
VAR CancelledShare = DIVIDE(Cancelled, LostSlots)

RETURN
IF(
    ISBLANK(Utilisation),
    "No operational data for selected filters.",

    "CAPACITY & DELIVERY"
    & UNICHAR(10)
    & "Of "
    & FORMAT(Scheduled, "#,##0")
    & " scheduled appointments, "
    & FORMAT(LostSlots, "#,##0")
    & " were not attended. "

    & IF(
        LostSlots > 0,
        "Cancellations account for "
        & FORMAT(CancelledShare, "0.0%")
        & " of non-attended appointments.",
        ""
    )

    & UNICHAR(10) & UNICHAR(10)

    & "MANAGEMENT PRIORITY"
    & UNICHAR(10)

    & SWITCH(
        TRUE(),

        LostSlots <= 0,
            "Maintain current delivery performance.",

        Cancelled > DNA,
            "Review cancellation patterns, booking "
            & "processes and opportunities to "
            & "reallocate cancelled slots.",

        DNA > Cancelled,
            "Investigate non-attendance patterns "
            & "and targeted appointment reminders.",

        "Review cancellation and DNA patterns "
        & "to improve delivered activity."
    )
)
```

## DNA Reduction Target Value

Home table: DNA Reduction Target  
Selected proportional reduction; default 20%.

```dax
DNA Reduction Target Value =
SELECTEDVALUE('DNA Reduction Target'[DNA Reduction Target], 0.2)
```

## Scenario Baseline

Home table: Scenario Comparison  
Supporting measure; calculation and dependencies shown below.

```dax
Scenario Baseline =
SWITCH(
    SELECTEDVALUE('Scenario Comparison'[Metric]),
    "DNA Appointments", [DNA Appointments],
    "DNA Rate", [DNA Rate %],
    "Attendance Rate", [Attendance Rate %],
    "Lost Slot Hours", [DNA Slot Hours],
    "Estimated DNA Cost", [Estimated DNA Cost]
)
```

## Scenario Projected

Home table: Scenario Comparison  
Supporting measure; calculation and dependencies shown below.

```dax
Scenario Projected =
SWITCH(
    SELECTEDVALUE('Scenario Comparison'[Metric]),
    "DNA Appointments", [Projected DNA Appointments],
    "DNA Rate", [Projected DNA Rate %],
    "Attendance Rate", [Projected Attendance Rate %],
    "Lost Slot Hours", [Projected Lost Slot Hours],
    "Estimated DNA Cost", [Projected DNA Cost]
)
```