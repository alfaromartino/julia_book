Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    num = @. x^2 + 2 * x
    den = @. y^2 + 3 * y
    
    
    num ./ den
end

@btime foo($x, $y) #hide