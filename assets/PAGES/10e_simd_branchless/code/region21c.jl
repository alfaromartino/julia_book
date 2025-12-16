x              = rand(1_000_000)
y              = rand(1_000_000)

branch1(a,b)   = a * b
branch2(a,b)   = a + b
condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)

foo(x,y)       = @. ifelse(condition(x,y), branch1(x,y), branch2(x,y))
@ctime foo($x,$y) #hide