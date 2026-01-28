Random.seed!(1234)       #setting seed for reproducibility #hide
x_small  = rand(    1_000)
x_medium = rand(  100_000)
x_big    = rand(1_000_000)

function foo(x)    
    a           = maximum(x)
    b           = sum(x)
    
    all_outputs = (a,b)
end