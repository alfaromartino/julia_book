Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)


function foo(f::F, x) where F
    f.(x)
end
@ctime foo(abs, $x) #hide