using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo!(x)
    output, temp = (similar(x) for _ in 1:2)

    for i in eachindex(x)
        temp     .= x .> x[i]
        output[i] = sum(temp)
    end

    return output
end

#@btime foo!(ref($x));