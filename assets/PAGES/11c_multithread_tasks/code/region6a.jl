Random.seed!(1234) #hide
x                 = rand(2_000_000)

step1(a)          = a * 2
step2(a)          = a + 2
step3(a)          = log(a)

function foo(x)
   output = similar(x)

   for i in eachindex(output) 
      y         = step1(x[i])
      z         = step2(y)
      output[i] = step3(z)
   end

   return output
end

@ctime foo($x) #hide