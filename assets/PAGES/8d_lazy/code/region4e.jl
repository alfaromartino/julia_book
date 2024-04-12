using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    all_conditions    = Iterators.map(a ->  0.25 < a < 0.75 , x)    
    

    sum(all_conditions)
end

@btime foo(ref($x)) #hide