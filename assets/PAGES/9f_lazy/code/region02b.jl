Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y)    




    @. (3 * exp(x) + 2 * x) / (2 * exp(y) + 3 * y)
end

@btime foo($x, $y) #hide