Random.seed!(1234) #hide
x                 = rand(2_000_000)

parallel_step1(x) = Folds.map(a -> a * 2, x)
parallel_step2(y) = Folds.map(a -> a + 2, y)
parallel_step3(z) = Folds.map(log, z)

function foo(x)
   y      = parallel_step1(x)
   z      = parallel_step2(y)
   output = parallel_step3(z)
   
   return output
end

@ctime foo($x) #hide