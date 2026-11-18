let
  Source = Csv.Document(File.Contents("C:\Portfolio\CarePulse\Data\dim_hospitals.csv"), [Delimiter = ",", Columns = 3, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true])
in
  #"Promoted headers"
