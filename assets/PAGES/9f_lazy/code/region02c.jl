Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx(a)     = 3 * exp(a) + 2 * a
    ly(b)     = 2 * exp(b) + 3 * b
    

    @. lx(x) / ly(y)
end

@btime foo($x, $y) #hide