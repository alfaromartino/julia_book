#
function stats_subset(visits, payrates, condition)
    nrvideos = sum(condition)
    audience = sum(visits[condition])
    
    earnings = visits .* payrates
    revenue  = sum(earnings[condition])
    
    return (; nrvideos, audience, revenue)
end