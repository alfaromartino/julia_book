Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)

indices = x .> 0.5
y       = x[indices]

function foo(y)    
    output = 0.0

    @simd for i in eachindex(y)
        output += 2 * y[i]
    end

    return output
end
@ctime foo($y) #hide