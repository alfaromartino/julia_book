Random.seed!(123)       #setting the seed for reproducibility #hide
x         = rand(100)

term_1    = @~ x .* 2
term_2    = @~ x .* 3

foo(term1, term2) = term1 .+ term2
@btime foo($term_1, $term_2) #hide