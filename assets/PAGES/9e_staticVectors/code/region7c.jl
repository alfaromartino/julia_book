using BenchmarkTools
x2 = SVector(rand(100)...)
y2 = SVector(rand(100)...)

@btime sum($x .* $y)