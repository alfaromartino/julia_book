using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    condition(x) = 0.75 > x > 0.25
    


    sum(@~ condition.(x))
end


@btime foo(ref($x)) #hide