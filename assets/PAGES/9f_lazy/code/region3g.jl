using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx(a)     = 4 * a^3 + 3 * a^2 + 2 * a + 1
    ly(b)     = 2 * b^3 + 3 * b^2 + 4 * b + 1
    temp(a,b) = lx(a) / ly(b)
    
    sum(@~ temp.(x,y))
end

@btime foo($x, $y) #hide