Random.seed!(123)       #setting seed for reproducibility #hide
x       = rand(1_000_000)

indices = 1:length(x)
y       = x[indices]

function foo(y)    
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide