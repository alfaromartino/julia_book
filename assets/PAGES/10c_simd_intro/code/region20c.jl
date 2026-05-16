Random.seed!(123)       #setting the seed for reproducibility #hide
x                 = rand(1_000_000)
y                 = rand(1_000_000)
condition(a,b)    = (a > 0.3) && (b < 0.6) && (a > b)

function foo(x,y)
    out = 0.0

    for i in eachindex(x)
        if condition(x[i],y[i])
            out += x[i]
        end
    end

    return out
end
@ctime foo($x,$y) #hide