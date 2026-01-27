Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)

function foo(x)
    y = [a * 2 for a in x]       # 1 allocation
    
    sum(y)
end
    
@ctime foo($x) #hide