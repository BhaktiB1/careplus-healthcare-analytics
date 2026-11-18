let
  Source = Csv.Document(File.Contents("C:\Portfolio\CarePulse\Data\fact_daily_capacity.csv"), [Delimiter = ",", Columns = 6, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"date", type date}, {"hospital_id", type text}, {"specialty_id", type text}, {"scheduled_slots", Int64.Type}, {"attended_slots", Int64.Type}, {"available_slots_estimate", Int64.Type}}, "en-US")
in
  #"Changed column type"
