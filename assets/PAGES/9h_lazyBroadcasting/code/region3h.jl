Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    term1     = @~ @. 2 * x + 1
    term2     = @~ @. 3 * y - 1
    temp      = @~ @. term1 * term2
    
    sum(temp)
end

@btime foo($x, $y) #hide