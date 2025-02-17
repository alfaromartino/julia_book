using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(f, x)
    y      = map(f[1], x)


    for i in 1:100_000
        sum(y) + i
    end
end
tup = (abs,)
#@btime foo($tup, $x) #hide