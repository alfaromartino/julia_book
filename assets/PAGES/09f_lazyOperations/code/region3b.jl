Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)

function foo(x)
    y = Iterators.map(a -> a * 2, x)        # it does NOT allocate

    sum(y)
end
    
@ctime foo($x) #hide