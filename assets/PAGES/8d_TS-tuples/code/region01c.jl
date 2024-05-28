using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)
f_tup = (abs,)

function foo(f_tup, x)
    y = map(f_tup[1], x)
    

    sum(y)
end
#@btime foo($f_tup, $x) #hide