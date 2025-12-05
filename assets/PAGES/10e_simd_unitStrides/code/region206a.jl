Random.seed!(123)       #setting the seed for reproducibility #hide
x_size = 1_000_000

x = rand(x_size)

y = zeros(eltype(x),x_size * 2)
    temp  = view(y, 2:2:length(y))
    temp .= x