Random.seed!(123)       #setting seed for reproducibility #hide
x          = rand(10)
output     = 2 .* x

# the following are equivalent and define a new variable `output`
   output  = @. 2  * x
   output  =    2 .* x