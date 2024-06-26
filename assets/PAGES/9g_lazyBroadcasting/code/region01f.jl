Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x) 
    output = similar(x)
    
    @inbounds for i in eachindex(x)
        output[i] = exp(2 * x[i]) + (3 * x[i]) * 5
    end

    return output
end

@btime foo($x) #hide