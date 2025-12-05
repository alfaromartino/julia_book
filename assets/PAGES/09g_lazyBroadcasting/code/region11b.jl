Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

function foo(x)
    output = zero(eltype(x))

    for i in eachindex(x)
        output += 2 * x[i]
    end

    return output
end
@ctime foo($x) #hide