using Random; Random.seed!(1234) #hide
x      = rand(100_000)
foo(x) = sum(a -> 2 * a, x)

function replicate(x)
   for _ in 1:100_000
      foo(x)
   end
end

@btime replicate($x)    #hide