using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function baseline(x)
    output = similar(x)

    for i in eachindex(x)
        temp      = x ./ x[i]
        output[i] = sum(temp)
    end

    return output
end

#@btime baseline(ref($x))