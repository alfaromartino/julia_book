using Chairmarks
using Random; Random.seed!(1234) #hide
x = rand(100)

display(@b sum($x))        # provides minimum time only
print_asis(@b sum($x))    #hide