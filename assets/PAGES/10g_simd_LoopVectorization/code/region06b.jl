Random.seed!(123)       #setting seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = sin(a)

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide