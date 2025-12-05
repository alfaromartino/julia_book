Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @simd for i in eachindex(x)             # or `@inbounds @simd for i in eachindex(x)`
        @inbounds output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x) #hide