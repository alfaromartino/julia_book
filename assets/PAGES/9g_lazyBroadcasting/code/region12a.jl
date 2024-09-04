Random.seed!(123)       #setting the seed for reproducibility #hide
x = [1, 2, 3]
β = 2

foo(x,β) = x * β

print_asis(foo(x,β)) #hide