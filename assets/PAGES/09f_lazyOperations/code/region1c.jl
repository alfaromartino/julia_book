Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)


foo(x) = sum(a * 2 for a in x)  # it does NOT allocate
    
@ctime foo($x) #hide