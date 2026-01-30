Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(50)

function foo(x)
    
    output = MVector{length(x), eltype(x)}(undef)

    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end

@code_warntype foo(x)                     # type unstable