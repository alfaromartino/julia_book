Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx(a)     = 3 * exp(a) + 2 * a
    ly(b)     = 2 * exp(b) + 3 * b
    temp(a,b) = lx(a) / ly(b)
    
    sum(Iterators.map(temp, x,y))
end

@btime foo($x, $y) #hide