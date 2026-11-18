let
  Source = Csv.Document(File.Contents("C:\Portfolio\CarePulse\Data\dim_specialties.csv"), [Delimiter = ",", Columns = 2, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true])
in
  #"Promoted headers"
