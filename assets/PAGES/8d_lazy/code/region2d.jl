using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = collect(1:100)

function foo(x)
    y = (a for a in x if a > 50)            # 0 allocations

    sum(y)
end
    
@btime foo(ref($x))