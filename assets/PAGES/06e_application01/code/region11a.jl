targetNonViral = let viewers = viewers, payrates = payrates, threshold = viral_threshold
    new_viewers = copy(viewers)
    temp        = @view new_viewers[new_viewers .< threshold]
    temp       .= 1.2 .* temp

    allvideos  = trues(length(new_viewers))
    stats_subset(new_viewers, payrates, allvideos)
end
print_compact(targetNonViral) #hide