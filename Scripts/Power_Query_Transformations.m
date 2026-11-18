// Reference collection; queries are separate expressions.

// Query: dim_hospitals
let
  Source = Csv.Document(File.Contents("C:\Portfolio\CarePulse\Data\dim_hospitals.csv"), [Delimiter = ",", Columns = 3, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true])
in
  #"Promoted headers"

// Query: dim_patients
let
  Source = Csv.Document(File.Contents("C:\Portfolio\CarePulse\Data\dim_patients.csv"), [Delimiter = ",", Columns = 5, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"patient_id", type text}, {"age_at_reference", Int64.Type}, {"imd_decile", Int64.Type}, {"gender", type text}, {"ethnicity", type text}}, "en-US")
in
  #"Changed column type"

// Query: dim_specialties
let
  Source = Csv.Document(File.Contents("C:\Portfolio\CarePulse\Data\dim_specialties.csv"), [Delimiter = ",", Columns = 2, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true])
in
  #"Promoted headers"

// Query: fact_appointments
let
  Source = Csv.Document(File.Contents("C:\Portfolio\CarePulse\Data\fact_appointments.csv"), [Delimiter = ",", Columns = 17, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"appointment_id", type text}, {"patient_id", type text}, {"specialty_id", type text}, {"hospital_id", type text}, {"appointment_date", type date}, {"booking_date", type date}, {"lead_time_days", Int64.Type}, {"appointment_type", type text}, {"consultation_mode", type text}, {"appointment_time", type time}, {"slot_minutes", Int64.Type}, {"appointment_status", type text}, {"dna_flag", Int64.Type}, {"attended_flag", Int64.Type}, {"cancelled_flag", Int64.Type}, {"illustrative_tariff_gbp", Int64.Type}, {"illustrative_slot_cost_gbp", Int64.Type}}, "en-US")
in
  #"Changed column type"

// Query: fact_daily_capacity
let
  Source = Csv.Document(File.Contents("C:\Portfolio\CarePulse\Data\fact_daily_capacity.csv"), [Delimiter = ",", Columns = 6, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"date", type date}, {"hospital_id", type text}, {"specialty_id", type text}, {"scheduled_slots", Int64.Type}, {"attended_slots", Int64.Type}, {"available_slots_estimate", Int64.Type}}, "en-US")
in
  #"Changed column type"
