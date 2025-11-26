Random.seed!(123)       #setting the seed for reproducibility #hide
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]





function foo(score)
    temp = similar(score)
    
    for i in eachindex(score)
        temp[i] = score[i] > 0.5
    end

    return temp
end

function repeated_call(scores) 
    output = Vector{Float64}(undef,length(scores))

    for col in eachindex(scores)
        score       = scores[col]
        temp        = foo(score)
        output[col] = std(temp) / mean(temp)
    end

    return output
end
@ctime repeated_call($scores) #hide