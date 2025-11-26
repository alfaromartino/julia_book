#
function stats_subset(viewers, payrates, condition)
    nrvideos = sum(condition)
    audience = sum(viewers[condition])
    
    earnings = viewers .* payrates
    revenue  = sum(earnings[condition])
    
    return (; nrvideos, audience, revenue)
end