x = [2, 4, 6]

for i in eachindex(x)
    x[i] = x[i] * 10       # mutates the `x` defined outside the for-loop
end
print_asis(x)     #hide