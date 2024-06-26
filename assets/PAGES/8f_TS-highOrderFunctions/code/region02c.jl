using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(f, x)
    y = map(f, x)
    f(1)                            # irrelevant computation to force specialization

    for i in 1:100_000
        sum(y) + i
    end
end
#@btime foo(ref(abs), $x) #hide