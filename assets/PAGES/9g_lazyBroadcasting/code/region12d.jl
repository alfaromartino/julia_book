Random.seed!(123)       #setting the seed for reproducibility #hide
x = [1, 2, 3]
y = [4, 5, 6]

foo(x,y) = x .* y

print_asis(foo(x,y)) #hide