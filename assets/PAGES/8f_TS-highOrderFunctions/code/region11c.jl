using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10)

function foo1(x)
    max(x...)
end
#@btime foo1($x) #hide