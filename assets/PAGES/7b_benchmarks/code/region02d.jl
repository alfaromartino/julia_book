using BenchmarkTools
using Random; Random.seed!(1234) #hide
x = rand(100)

@btime sum($x)