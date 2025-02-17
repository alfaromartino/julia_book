Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = a^4

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide