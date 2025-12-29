Random.seed!(123)       #setting seed for reproducibility #hide
x     = rand(100)
f_tup = (abs,)

function foo(f_tup, x)
    f_tup[1].(x)    
end