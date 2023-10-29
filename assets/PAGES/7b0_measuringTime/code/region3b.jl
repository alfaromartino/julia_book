x      = collect(1:10)
foo()  = x .* 2

function replicate()
   for _ in 1:100_000
      foo()
   end
end

@btime replicate()