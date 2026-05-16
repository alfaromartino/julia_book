using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx(x)     = 4 * x^3 + 3 * x^2 + 2 * x + 1
    ly(y)     = 2 * y^3 + 3 * y^2 + 4 * y + 1
    calc(x,y) = lx(x) / ly(y)
    
    sum(Iterators.map(calc, x,y))
end

@btime foo(ref($x),ref($y))