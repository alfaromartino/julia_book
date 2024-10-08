using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    condition1(a)     = a > 0.25
    condition2(a)     = a < 0.75    
    all_conditions    = Iterators.map(a -> condition1(a) && condition2(a) , x)    

    sum(all_conditions)
end

@btime foo(ref($x)) #hide