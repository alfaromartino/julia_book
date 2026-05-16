Random.seed!(123)       #setting seed for reproducibility #hide
x         = rand(100)

foo(f, x) = f.(x)
@code_warntype foo(abs, x) #hide