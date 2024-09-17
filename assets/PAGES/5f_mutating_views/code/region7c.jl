x     = zeros(3)
slice = view(x, 1:2)

for i in eachindex(slice)
    slice[i] = 1
end
print_asis(x) #hide