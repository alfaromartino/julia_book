using BenchmarkTools

x = 1:100
@btime sum($x)        # provides minimum time only