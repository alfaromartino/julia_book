Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
y              = rand(1_000_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a)      = exp(a) / 3 + log(a) / 2

function foo(x,y)
    out = 0.0

    @inbounds @simd for i in eachindex(x)
        out += condition(x[i],y[i]) ? branch(x[i]) : 0
    end

    return out
end
@ctime foo($x,$y) #hide