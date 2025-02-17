using Pipe
function stats_subset(visits, payrates, condition)
    nrvideos = sum(condition)
    audience = sum(visits[condition])
    
    
    revenue  = @pipe (visits .* payrates) |> x -> sum(x[condition])
    
    return (; nrvideos, audience, revenue)
end