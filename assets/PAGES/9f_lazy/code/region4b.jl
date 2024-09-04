using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    condition1     = (a > 0.25 for a in x)
    condition2     = (a < 0.75 for a in x)
    all_conditions = ((x && y) for (x,y) in  zip(condition1, condition2))
        
    sum(all_conditions)
end

@btime foo(ref($x)) #hide