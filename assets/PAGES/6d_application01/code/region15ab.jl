indices         = sortperm(earnings, rev=true)[1:3]

sorted_payrates = payrates[indices]
print_compact(sorted_payrates) #hide