using Chairmarks
using Random; Random.seed!(1234) #hide

@b begin
   x = rand(100)
   sum($x)
end