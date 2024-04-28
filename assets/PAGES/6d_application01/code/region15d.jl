indices    = sortperm(views_per_video, rev=true)
sorted_pay = pay_per_views[indices]
print_compact(sorted_pay[1:3], 12) #hide