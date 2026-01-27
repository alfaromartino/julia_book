Random.seed!(123)       #setting seed for reproducibility #hide
x = collect(1:100)

function foo(x)
    y = Iterators.filter(a -> a > 50, x)    # 0 allocations 

    sum(y)
end
    
@ctime foo($x) #hide