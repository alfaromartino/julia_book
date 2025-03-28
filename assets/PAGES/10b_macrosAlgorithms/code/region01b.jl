Random.seed!(123)       #setting the seed for reproducibility #hide
v,w,x,y = (rand(100_000) for _ in 1:4)       # it assigns random vectors to v,w,x,y

function foo(v, w, x, y)
    output = 0.0

    @inbounds for i in 2:length(v)-1
        output += v[i-1] / v[i+1] / w[i-1] * w[i+1] + x[i-1] * x[i+1] / y[i-1] * y[i+1]
    end

    return output
end
@btime foo($v,$w,$x,$y) #hide