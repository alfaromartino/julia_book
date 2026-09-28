Random.seed!(123)       #setting seed for reproducibility #hide
x = collect(1:100)

function foo(x)
    sum(x .> 50)                            # 1 allocation
end
    
@ctime foo($x) #hide