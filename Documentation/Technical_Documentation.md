# CarePulse | Technical documentation

## Model and implementation
Multi-fact dimensional model: appointment-level fact and daily hospital-specialty capacity fact. Hospital, specialty and calendar filter both; patient dimension filters appointments only. Power Query CSV import, headers and types; calculated age, lead-time, day and time bands with sort columns. DAX includes rolling 12-month measures, prior-year comparison, patient repeat counts, rank/insight measures and disconnected scenario, waterfall and heatmap tables. Capacity utilisation uses the daily fact, which lacks time-of-day and patient grain: validate appointment day/time heatmap before publication. Scenario slicer scope must be tested. Estimated cost uses illustrative slot values; not actual NHS expenditure. Age uses reference age. Thresholds are illustrative.

## Pages
Overview, Operational, Attendance, Opportunities.

## Reproduce
Open PBIX or complete PBIP in Power BI Desktop, repoint CSV sources to local Data folder, refresh and validate. Exported DAX and M collections are reference definitions, not a single executable script. See data dictionary and relationship export. Model inspected, not executed in Desktop.
