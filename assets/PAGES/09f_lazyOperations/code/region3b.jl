Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)

function foo(x)
    y = Iterators.map(a -> a * 2, x)        # 0 allocations

    sum(y)
end
    
@ctime foo($x) #hide