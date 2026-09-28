x            = [1, 2, 3, 100, 200]

condition(a) = (a < 10)             #function to eventually broadcast
y            = x[condition.(x)]