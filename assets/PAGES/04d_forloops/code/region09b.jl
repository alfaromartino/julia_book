x      = [1,2,3]

foo(a) = a^2
y      = [foo(a) for a in x]     # or y = [foo(x[i]) for i in eachindex(x)]
print_asis(y)   #hide