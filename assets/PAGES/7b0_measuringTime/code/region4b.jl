x = collect(1 : 1_000_000)

function replicate()
   y = similar(x)

   for i in 1:1_000_000
      y[i] = x[i] * 2
   end

   return y
end

@btime replicate()