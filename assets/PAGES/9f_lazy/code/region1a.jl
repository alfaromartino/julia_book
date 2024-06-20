Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    y = [a * 2 for a in x]                  # 1 allocation (same as y = x .* 2)
    
    sum(y)
end
    
@btime foo($x) #hide