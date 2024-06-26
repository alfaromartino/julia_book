Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x) 
    aux1  = 2 .* x
        term1 = exp.(aux1)
    aux2  = 3 .* x
        term2 = aux2 .* 5

    return term1 + term2
end

@btime foo($x) #hide