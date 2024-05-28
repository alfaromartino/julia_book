using BenchmarkTools
x = 2

function foo(x, repetitions)
   for i in 1:repetitions
      x * i
   end
end

@btime foo(x, 100)