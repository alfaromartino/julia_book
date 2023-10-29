x      = collect(1:10)
foo(x) = x .* 2

function replicate(x)
   for _ in 1:100_000
      foo(x)
   end
end

@btime replicate(ref($x))