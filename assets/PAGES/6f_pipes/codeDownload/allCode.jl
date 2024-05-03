############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# We use `foo(ref($x))` for more accurate benchmarks of any function `foo(x)`
using BenchmarkTools
ref(x) = (Ref(x))[]


############################################################################
#
#                           START OF THE CODE 
#
############################################################################
 
# necessary packages for this file
using Pipe
 
####################################################
#	                     EXAMPLE 1
####################################################
 
a = -2

output = round(log(abs(a)))
 
a = -2

temp1  = abs(a)
temp2  = log(temp1)
output = round(temp2)
 
a = -2

output = let b = a         # 'b' is a local variable having the value of 'a' 
   temp1 = abs(b)
   temp2 = log(temp1)
   round(temp2)
end
 
a = -2

output = let a = a         # the 'a' on the left still refers to a local variable
   temp1 = abs(a)
   temp2 = log(temp1)
   round(temp2)
end
 
a = -2

output = a |> abs |> log |> round
 
# just like functions, be careful as you can mutate the global variable   # hide 
# just like functions too, you can't reassign a value through a let block # hide 
x = [2,2,2]

output = let x = x
   x[1] = 0
end
 
# just like functions, be careful as you can mutate the global variable   # hide 
# just like functions too, you can't reassign a value through a let block # hide 
x = [2,2,2]

output = let x = x
   x = 0
end
 
####################################################
#	                     EXAMPLE 2
####################################################
 
x = [-1,2,3]

output = sum(log.(abs.(x)))
 
# hide
 
x = [-1,2,3]

temp1  = abs.(x)
temp2  = log.(temp1)
output = sum(temp2)
 
x = [-1,2,3]

output = x .|> abs .|> log |> sum
 
####################################################
#	                     EXAMPLE 3
####################################################
 
a = -2

output = round(2 * abs(a))
 
a = -2

temp1  = abs(a)
temp2  = 2 * temp1
output = round(temp2)
 
a = -2

output = a |> abs |> (x -> 2 * x) |> round

#equivalent, but more readable
output = a              |>
         abs            |>
         x -> 2 * x     |>
         round
 
#
a = -2

output = a |> abs |> (x -> 2 * x) |> round

#equivalent, but more readable
output =       a            |>
               abs          |>
               x -> 2 * x   |>
               round
 
using Pipe
a = -2

output = @pipe a |> abs |> 2 * _ |> round

#equivalent, but more readable
output = @pipe a            |>
               abs          |>
               2 * _        |>
               round
 
####################################################
#	                     EXAMPLE 4
####################################################
 
variable_with_a_long_name = 2

output = variable_with_a_long_name - log(variable_with_a_long_name) / abs(variable_with_a_long_name)
 
# hide
 
variable_with_a_long_name = 2

temp   = variable_with_a_long_name
output = temp - log(temp) / abs(temp)
 
variable_with_a_long_name = 2

output = variable_with_a_long_name       |>
         a -> a - log(a) / abs(a)
 
variable_with_a_long_name = 2 ; using Pipe

output = @pipe variable_with_a_long_name |>
               _ - log(_) / abs(_)
 
variable_with_a_long_name = 2

output = let x = variable_with_a_long_name
    x - log(x) / abs(x)
end
 
####################################################
#	                     EXAMPLE 4 bis
####################################################
 
object_with_a_long_name = [-1,2,3]

output = [abs(object_with_a_long_name[i]) + object_with_a_long_name[i] / exp(object_with_a_long_name[i])
          for i in eachindex(object_with_a_long_name)]
 
object_with_a_long_name = [-1,2,3]

temp   = object_with_a_long_name
output = [abs(temp[i]) + temp[i] / exp(temp[i]) for i in eachindex(temp)]
 
# hide
 
object_with_a_long_name = [-1,2,3]

output = object_with_a_long_name |>
         x -> [abs(x[i]) + x[i] / exp(x[i]) for i in eachindex(x)]
 
object_with_a_long_name = [-1,2,3]

output = @pipe object_with_a_long_name |>
               [abs(_[i]) + _[i] / exp(_[i]) for i in eachindex(_)]
 
object_with_a_long_name = [-1,2,3]

output = let x = object_with_a_long_name
   [abs(x[i]) + x[i] / exp(x[i]) for i in eachindex(x)]
end
 
