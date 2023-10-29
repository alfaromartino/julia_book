using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    y = (a * 2 for a in x)                  # 0 allocations
    
    sum(y)
end
    
@btime foo(ref($x))