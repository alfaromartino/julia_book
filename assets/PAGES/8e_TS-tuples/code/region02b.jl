using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(f)
    y = map(f, x)

    
    for i in 1:100_000
        sum(y) + i
    end
end

#@btime foo(ref(abs)) #hide