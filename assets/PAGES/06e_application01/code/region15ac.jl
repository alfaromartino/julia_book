indices         = sortperm(earnings, rev=true)[1:3]

sorted_viewers  = viewers[indices]
print_compact(sorted_viewers) #hide