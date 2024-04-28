using StatsBase
counts_pay_per_views = countmap(pay_per_views) |> sort
counts_pay_per_views |> print_compact #hide