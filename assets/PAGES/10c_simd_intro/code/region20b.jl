Random.seed!(123)       #setting the seed for reproducibility #hide
x                 = rand(1_000_000)
y                 = rand(1_000_000)


function foo(x,y)
    out = 0.0

    @inbounds @simd for i in eachindex(x)
        if (x[i] > 0.3) *  (y[i] < 0.6) *  (x[i] > y[i])
            out += x[i]
        end
    end

    return out
end
@ctime foo($x,$y) #hide