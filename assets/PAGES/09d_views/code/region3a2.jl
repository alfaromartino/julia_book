Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100_000)

function foo(x) 
    y = @view x[1:2:length(x)]
    
    max.(y, 0.5)
end
@ctime foo($x) #hide