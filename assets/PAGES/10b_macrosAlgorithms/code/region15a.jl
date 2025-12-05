Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

function foo(x)
    output = 0.    

    @inbounds for i in eachindex(x)
                  a       = log(x[i])
                  b       = exp(x[i])
                  output += a / b
    end

    return output
end
@ctime foo($x) #hide