Random.seed!(123)       #setting seed for reproducibility #hide
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]


output  = Vector{Float64}(undef,length(scores))

function repeated_call!(output, scores) 
    for col in eachindex(scores)
        score       = scores[col]
        temp        = (score[i] > 0.5 for i in eachindex(score))    # lazy (generator)
        output[col] = std(temp) / mean(temp)
    end

    return output
end
@ctime repeated_call!($output,$scores)    #hide