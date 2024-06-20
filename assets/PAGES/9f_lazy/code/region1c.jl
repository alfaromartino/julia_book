Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)


foo(x) = sum(a * 2 for a in x)              # 0 allocations
    
@btime foo($x) #hide