using BenchmarkTools

x = 1:100
@benchmark sum($x)    # provides more statistics than `@btime`