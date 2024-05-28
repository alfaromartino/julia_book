using Chairmarks
using Random; Random.seed!(1234) #hide
x = rand(100)

display(@be sum($x))       # analogous to `@benchmark` in BenchmarkTools
print_asis(@be sum($x))    #hide