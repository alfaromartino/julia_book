Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
y              = rand(1_000_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a,b)    =  a * b

function foo(x,y)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += ifelse(condition(x[i],y[i]), branch(x[i],y[i]), 0)
    end

    return output
end
@ctime foo($x,$y) #hide