using Pipe
function stats_subset(viewers, payrates, condition)
    nrvideos = sum(condition)
    audience = sum(viewers[condition])
    
    
    revenue  = @pipe (viewers .* payrates) |> sum(_[condition])
    
    return (; nrvideos, audience, revenue)
end