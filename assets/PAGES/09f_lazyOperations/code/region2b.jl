Random.seed!(123)       #setting seed for reproducibility #hide
x = collect(1:100)

function foo(x)
    y = filter(a -> a > 50, x)              # 1 allocation 

    sum(y)
end
    
@ctime foo($x) #hide