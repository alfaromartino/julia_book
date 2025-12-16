Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(100_000)
y              = rand(100_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a,b)    =  a * b

function foo(x,y)
    out = 0.0

    for i in eachindex(x)
        out += ifelse(condition(x[i],y[i]), branch(x[i],y[i]), 0)
    end

    return out
end
@ctime foo($x,$y) #hide