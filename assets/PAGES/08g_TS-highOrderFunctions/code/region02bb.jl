Random.seed!(123)       #setting seed for reproducibility #hide
x     = rand(100)

function foo(f, x)
    
    f.(x)
end