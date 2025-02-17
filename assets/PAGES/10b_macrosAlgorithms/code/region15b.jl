Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

function foo(x)
    output = 0.    

    for i in eachindex(x)
        @inbounds a       = log(x[i])
        @inbounds b       = exp(x[i])
                  output += a / b
    end

    return output
end
@btime foo($x) #hide