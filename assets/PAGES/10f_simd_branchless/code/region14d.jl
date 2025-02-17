Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(5_000_000)

function foo(x)
    output      = similar(x)
    boolvector  = Vector{Bool}(undef,length(x))
    boolvector .= x .> 0.5

    @inbounds @simd for i in eachindex(x)
        output[i] = ifelse(boolvector[i], x[i]/i, x[i]*i)
    end

    return output
end
@ctime foo($x) #hide