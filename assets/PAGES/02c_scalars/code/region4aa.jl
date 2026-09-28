using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x) 
    temp   = [x .> x[i] for i in eachindex(x)]
    output = sum.(temp)
end

@btime foo($x) #hide