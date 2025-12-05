Random.seed!(123)       #setting the seed for reproducibility #hide
x,y = (rand(2_000_000) for _ in 1:2)               # it assigns random vectors to x and y

function foo(x,y)
    output = similar(x)

    for i in eachindex(x,y,output)
        output[i] = x[i] * y[i]
    end

    return output
end
@fast_btime foo($x,$y) #hide