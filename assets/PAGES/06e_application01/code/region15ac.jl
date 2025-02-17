indices         = sortperm(earnings, rev=true)[1:3]

sorted_visits   = visits[indices]
print_compact(sorted_visits) #hide