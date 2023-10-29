x = collect(1:10)

function replicate(x)
   y = similar(x)

   for i in 1:1_000_000
      y[i] = x[i] * 2
   end

   return y
end

@btime replicate(ref($x))