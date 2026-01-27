Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)

function foo(x) 
    y = map(a -> a * 2, x)                  # 1 allocation

    sum(y)
end
    
@ctime foo($x) #hide