Random.seed!(123)       #setting the seed for reproducibility #hide
v,w,x,y = (rand(100_000) for _ in 1:4) # it assigns random vectors to v, w, x, y
compute(i, v,w,x,y) = v[i-1] / v[i+1] / w[i-1] * w[i+1] + 
                      x[i-1] * x[i+1] / y[i-1] * y[i+1]

function foo(v,w,x,y)
    output = 0.0

    @inbounds for i in 2:length(v)-1
        output += compute(i, v,w,x,y)

    end

    return output
end
@ctime foo($v,$w,$x,$y) #hide