indices      = sortperm(pay_per_video, rev=true)[1:3]

sorted_views = views_per_video[indices]
print_compact(sorted_views) #hide