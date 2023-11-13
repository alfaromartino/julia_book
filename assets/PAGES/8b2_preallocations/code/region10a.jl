using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)
output = similar(x)

function foo!(output,x)
    for i in eachindex(x)
        output[i] = 2 * x[i]
    end

    return output
end

@btime foo!(ref($output), ref($x));