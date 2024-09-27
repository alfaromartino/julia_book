Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

function foo(x)
    output = similar(x)

    for i in eachindex(x,output)
        output[i] = 2 * x[i]
    end

    return output
end
@btime foo($x) #hide