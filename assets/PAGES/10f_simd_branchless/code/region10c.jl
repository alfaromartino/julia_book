Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds for i in eachindex(x)
        output[i] = 2/x[i]
    end

    return output
end
@ctime foo($x) #hide