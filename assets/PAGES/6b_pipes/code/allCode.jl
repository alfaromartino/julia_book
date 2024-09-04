include(joinpath("C:/", "JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Pipe
 
####################################################
#	                     EXAMPLE 1
####################################################
 
a = -2

output = round(log(abs(a)))
 
print_asis(output)
 
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
 
print_asis(x)
 
# just like functions, be careful as you can mutate the global variable   # hide 
# just like functions too, you can't reassign a value through a let block # hide 
x = [2,2,2]

output = let x = x
   x = 0
end
 
print_asis(x)
 
####################################################
#	                     EXAMPLE 2
####################################################
 
x = [-1,2,3]

output = sum(log.(abs.(x)))
 
print_asis(output) # hide
 
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
print_asis(output) #hide
 
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
#	                     FUNCTION COMPOSITION
####################################################
 
a        = -1



# all `output` are equivalent
output   = log(abs(a))
output   = a |> abs |> log
output   = (log ∘ abs)(a)
output   = ∘(log, abs)(a)
print_asis(output) # hide
 
a        = 2
outer(a) = a + 2
inner(a) = a / 2

# all `output` are equivalent
output   = (a / 2) + 2
output   = outer(inner(a))
output   = a |> inner |> outer
output   = (outer ∘ inner)(a)
output   = ∘(outer, inner)(a)
print_asis(output) # hide
 
x        = [1, 2, 3]



# all `output` are equivalent
output   = log.(abs.(x))
output   = x .|> abs .|> log
output   = (log ∘ abs).(x)
output   = ∘(log, abs).(x)
print_asis(output) # hide
 
x        = [1, 2, 3]
outer(a) = a + 2
inner(a) = a / 2

# all `output` are equivalent
output   = (x ./ 2) .+ 2
output   = outer.(inner.(x))
output   = x .|> inner .|> outer
output   = (outer ∘ inner).(x)
output   = ∘(outer, inner).(x)
print_asis(output) # hide
 
a            = -1

inners       = abs
outers       = [log, sqrt]
compositions = outers .∘ inners

# all `output` are equivalent
output       = [log(abs(a)), sqrt(abs(a))]
output       = [foo(a) for foo in compositions]
 
print_asis(compositions) # hide
 
print_asis(output) # hide
 
####################################################
#	                     EXAMPLE 4
####################################################
 
variable_with_a_long_name = 2

output = variable_with_a_long_name - log(variable_with_a_long_name) / abs(variable_with_a_long_name)
 
print_asis(output) # hide
 
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
 
print_asis(output) # hide
 
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
 
