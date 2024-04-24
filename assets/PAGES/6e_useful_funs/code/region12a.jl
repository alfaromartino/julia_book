days     = [1, 2, 3]
earnings = [8, 2, 4]

index            = sortperm(earnings, rev=true)
days_by_earnings = days[index]                     # days sorted by highest earnings