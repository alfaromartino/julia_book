using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(f, x)
    y = map(f, x)
    

    sum(y)    
end
#@btime foo(ref(abs), $x) #hide