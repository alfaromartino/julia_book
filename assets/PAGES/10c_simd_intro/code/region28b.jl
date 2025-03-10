Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1:10, 2_000_000)   # random integers between 1 and 10

function foo(x)
    output = 0

    @simd for i in eachindex(x)
        output += x[i]
    end

    return output
end
@ctime foo($x) #hide