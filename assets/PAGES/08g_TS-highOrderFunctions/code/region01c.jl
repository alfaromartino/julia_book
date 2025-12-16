Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)

function foo(f, x)
    f(1)                # irrelevant computation to force specialization
    f.(x)
end
@ctime foo(abs, $x) #hide