using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)
output = similar(x)

foo!(output,x) = (output .= 2 .* x)

@btime foo!($output, $x) #hide