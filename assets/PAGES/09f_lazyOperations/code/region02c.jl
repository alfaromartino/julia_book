Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    num(a)    = a^2 + 2 * a
    den(b)    = b^2 + 3 * b
    

    @. num(x) / den(y)
end

@btime foo($x, $y) #hide