using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function prealloc_temp(x)
    output, temp = (similar(x) for _ in 1:2)

    for i in eachindex(x)
        temp     .= x ./ x[i]
        output[i] = sum(temp)
    end

    return output
end

#@btime prealloc_temp(ref($x));