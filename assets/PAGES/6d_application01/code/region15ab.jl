indices      = sortperm(pay_per_video, rev=true)[1:3]

sorted_pay   = pay_per_views[indices]
print_compact(sorted_pay) #hide