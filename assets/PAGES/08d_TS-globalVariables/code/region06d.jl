using Random; Random.seed!(1234) # hide
x           = rand(200_000)


function foo(x)
    y    = similar(x)
    den  = sum(x)

    @inbounds for i in eachindex(x,y)
        y[i] = x[i] / den
    end

    return y
end
@btime foo($x)    # hide