using Random; Random.seed!(1234) # hide
x           = rand(100_000)


function foo(x)
    y    = similar(x)
    
    for i in eachindex(x,y)
        y[i] = x[i] / sum(x)
    end

    return y
end
@btime foo($x)    # hide