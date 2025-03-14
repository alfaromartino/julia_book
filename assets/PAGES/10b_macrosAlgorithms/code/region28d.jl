Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(2_000_000)

function foo(x)
    output = 0.0

    @simd for i in eachindex(x)
        output += x[i]
    end

    return output
end
@btime foo($x) #hide