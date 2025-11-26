Random.seed!(1234) # hide
x      = rand(100)

function foo(x)
    output      = similar(x)
    denominator = sum(x)

    @inbounds for i in eachindex(x)
        output[i] = x[i] / denominator
    end

    return output
end
@btime foo($x)    # hide