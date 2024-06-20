Random.seed!(123)       #setting the seed for reproducibility #hide
x = collect(1:100)

function foo(x)
    sum(x .> 50)                            # 1 allocation
end
    
@btime foo($x) #hide