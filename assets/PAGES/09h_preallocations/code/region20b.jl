Random.seed!(123)       #setting the seed for reproducibility #hide
nr_days    = 2
nr_workers = 1_000_000

scores     = rand(nr_days, nr_workers)
temp       = Vector{Float64}(undef, nr_days)
output     = Vector{Float64}(undef,length(scores))

function foo!(temp, score)
    for i in eachindex(score)
        temp[i] = score[i] > 0.5
    end

    return temp
end

@views function repeated_call!(output, temp, scores) 
    for col in axes(scores,2)
        output[col] = sum(foo!(temp, scores[:,col]))
    end

    return output
end

@ctime repeated_call!($output,$temp,$scores) #hide