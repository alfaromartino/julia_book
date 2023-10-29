using BenchmarkTools

x = 1:100
@benchmark sum(ref($x))    # more statistics than `@btime`