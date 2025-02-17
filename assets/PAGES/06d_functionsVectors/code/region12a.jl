days     = [1, 2, 3]
failures = [8, 2, 4]

index            = sortperm(failures, rev=true)
days_by_failures = days[index]                     # days sorted by highest earnings