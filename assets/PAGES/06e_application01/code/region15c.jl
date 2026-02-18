using StatsBase
occurrences_payrates = countmap(payrates) |> sort
occurrences_payrates |> print_compact #hide