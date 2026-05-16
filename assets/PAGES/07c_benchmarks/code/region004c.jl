using Random; Random.seed!(1234) #hide
x      = rand(100_000)
foo()  = sum(2 .* x)

function replicate()
   for _ in 1:100_000
      foo()
   end
end

@btime replicate()    #hide