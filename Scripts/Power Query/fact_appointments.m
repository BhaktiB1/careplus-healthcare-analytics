let
  Source = Csv.Document(File.Contents("C:\Portfolio\CarePulse\Data\fact_appointments.csv"), [Delimiter = ",", Columns = 17, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"appointment_id", type text}, {"patient_id", type text}, {"specialty_id", type text}, {"hospital_id", type text}, {"appointment_date", type date}, {"booking_date", type date}, {"lead_time_days", Int64.Type}, {"appointment_type", type text}, {"consultation_mode", type text}, {"appointment_time", type time}, {"slot_minutes", Int64.Type}, {"appointment_status", type text}, {"dna_flag", Int64.Type}, {"attended_flag", Int64.Type}, {"cancelled_flag", Int64.Type}, {"illustrative_tariff_gbp", Int64.Type}, {"illustrative_slot_cost_gbp", Int64.Type}}, "en-US")
in
  #"Changed column type"
