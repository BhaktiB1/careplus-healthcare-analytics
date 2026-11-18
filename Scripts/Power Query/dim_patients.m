let
  Source = Csv.Document(File.Contents("C:\Portfolio\CarePulse\Data\dim_patients.csv"), [Delimiter = ",", Columns = 5, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"patient_id", type text}, {"age_at_reference", Int64.Type}, {"imd_decile", Int64.Type}, {"gender", type text}, {"ethnicity", type text}}, "en-US")
in
  #"Changed column type"
