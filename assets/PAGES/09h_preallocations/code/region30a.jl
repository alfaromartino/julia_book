Random.seed!(123)       #setting seed for reproducibility #hide
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]





function foo(score)
    temp = similar(score)
    
    for i in eachindex(score)
        temp[i] = score[i] > 0.5
    end

    return std(temp) / mean(temp)
end

function repeated_call(scores) 
    output = Vector{Float64}(undef,length(scores))

    for col in eachindex(scores)
        output[col] = foo(scores[col])
    end

    return output
end
@ctime repeated_call($scores) #hide