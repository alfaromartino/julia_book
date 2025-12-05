Random.seed!(1234) #hide
x                 = rand(1_000_000)

step1(a)          = sqrt(a)
step2(a)          = exp(a)
step3(a)          = log(a)

function foo(x)
   output = similar(x)

   @sync begin
      for i in eachindex(output)
         @spawn begin
            y         = step1(x[i])
            z         = step2(y)
            output[i] = step3(z)
         end
      end
   end

   return output
end
@ctime foo($x) #hide