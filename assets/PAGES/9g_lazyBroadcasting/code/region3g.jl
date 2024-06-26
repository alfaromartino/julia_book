Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    term1(a)  = 2 * a + 1
    term2(b)  = 3 * b - 1
    temp(a,b) = term1(a) * term2(b)
    
    sum(@~ temp.(x,y))
end

@btime foo($x, $y) #hide