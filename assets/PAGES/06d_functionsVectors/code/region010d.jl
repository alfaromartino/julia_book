using StatsBase
x = [6, 6, 0, 5]

y = ordinalrank(x, rev=true)
print_asis(y) #hide