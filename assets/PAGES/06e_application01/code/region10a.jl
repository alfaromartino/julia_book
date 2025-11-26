# 'temp' modifies 'new_viewers'
new_viewers     = copy(viewers)
temp            = @view new_viewers[new_viewers .< viral_threshold]
temp           .= 1.2 .* temp

allvideos       = trues(length(new_viewers))
targetNonViral  = stats_subset(new_viewers, payrates, allvideos)
print_compact(targetNonViral) #hide