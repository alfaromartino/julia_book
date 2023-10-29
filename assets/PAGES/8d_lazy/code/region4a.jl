using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    condition1     = x .> 0.25
    condition2     = x .< 0.75    


    sum(condition1 .&& condition2)
end

@btime foo(ref($x))