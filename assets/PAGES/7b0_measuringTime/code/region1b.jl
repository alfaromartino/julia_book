using BenchmarkTools

x = 1:100
@btime sum(ref($x))        # only average time