days     = ["one", "two", "three"]
failures = [8, 2, 4]

index            = sortperm(earnings)
days_by_failures = days[index]                     # days sorted by lowest failures