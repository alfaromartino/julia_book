Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100_000)

function foo(x)
    output = similar(x)

    @inbounds for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end
@fast_btime foo($x) #hide