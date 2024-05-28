using Chairmarks
using Random; Random.seed!(1234) #hide

@be begin
   x = rand(100)
   sum($x)
end