using BenchmarkTools

@benchmark begin
   x = 1:100
   sum(ref($x))
end