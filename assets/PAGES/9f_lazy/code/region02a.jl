Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    a = @. 3 * exp(x) + 2 * x
    b = @. 2 * exp(y) + 3 * y
    
    
    a ./ b
end

@btime foo($x, $y) #hide