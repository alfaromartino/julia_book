Random.seed!(123)       #setting seed for reproducibility #hide
x         = rand(100)

term_1    = @~ x .* 2
term_2    = @~ x .* 3

foo(term1, term2) = term1 .+ term2
@ctime foo($term_1, $term_2) #hide