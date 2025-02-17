include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Pipe
 
####################################################
#	                     EXAMPLE 1
####################################################
 
a = -2

output = round(log(abs(a)))
print_asis(output) #hide
 
print_asis(temp1) #hide
 
print_asis(temp2) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
a = -2

temp1  = abs(a)
temp2  = log(temp1)
output = round(temp2)
print_asis(output) #hide
 
print_asis(temp1) #hide
 
print_asis(temp2) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
a = -2

output = let b = a         # 'b' is a local variable having the value of 'a' 
   temp1 = abs(b)
   temp2 = log(temp1)
   round(temp2)
end
print_asis(output) #hide
 
print_asis(temp1) #hide
 
print_asis(temp2) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
a = -2

output = let a = a         # the 'a' on the left of `=` defines a local variable
   temp1 = abs(a)
   temp2 = log(temp1)
   round(temp2)
end
print_asis(output) #hide
 
print_asis(temp1) #hide
 
print_asis(temp2) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
a = -2

output = a |> abs |> log |> round
 
# just like functions, be careful as you can mutate the global variable   # hide 
# just like functions too, you can't reassign a value through a let block # hide 
x = [2,2,2]

output = let x = x
   x[1] = 0
end
 
print_asis(x) #hide
 
# just like functions, be careful as you can mutate the global variable   # hide 
# just like functions too, you can't reassign a value through a let block # hide 
x = [2,2,2]

output = let x = x
   x = 0
end
 
print_asis(x) #hide
 
####################################################
#	                     EXAMPLE 2
####################################################
 
x = [-1,2,3]

output = sum(log.(abs.(x)))
 
print_asis(output) # hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [-1,2,3]

temp1  = abs.(x)
temp2  = log.(temp1)
output = sum(temp2)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [-1,2,3]

output = x .|> abs .|> log |> sum
 
####################################################
#	                     EXAMPLE 3
####################################################
 
a = -2

output = round(2 * abs(a))
print_asis(output) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
a = -2

temp1  = abs(a)
temp2  = 2 * temp1
output = round(temp2)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
a = -2

output = a |> abs |> (x -> 2 * x) |> round

#equivalent and more readable
output = a              |>
         abs            |>
         x -> 2 * x     |>
         round
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
#
a = -2

output = a |> abs |> (x -> 2 * x) |> round

#equivalent and more readable
output =       a            |>
               abs          |>
               x -> 2 * x   |>
               round
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Pipe
a = -2

output = @pipe a |> abs |> 2 * _ |> round

#equivalent and more readable
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
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
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
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x        = [1, 2, 3]



# all `output` are equivalent
output   = log.(abs.(x))
output   = x .|> abs .|> log
output   = (log ∘ abs).(x)
output   = ∘(log, abs).(x)
print_asis(output) # hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
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
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
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
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
variable_with_a_long_name = 2

temp   = variable_with_a_long_name
output = temp - log(temp) / abs(temp)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
variable_with_a_long_name = 2

output = variable_with_a_long_name       |>
         a -> a - log(a) / abs(a)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
variable_with_a_long_name = 2 ; using Pipe

output = @pipe variable_with_a_long_name |>
               _ - log(_) / abs(_)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
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
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
object_with_a_long_name = [-1,2,3]

temp   = object_with_a_long_name
output = [abs(temp[i]) + temp[i] / exp(temp[i]) for i in eachindex(temp)]
 
print_asis(output) # hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
object_with_a_long_name = [-1,2,3]

output = object_with_a_long_name |>
         x -> [abs(x[i]) + x[i] / exp(x[i]) for i in eachindex(x)]
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
object_with_a_long_name = [-1,2,3]

output = @pipe object_with_a_long_name |>
               [abs(_[i]) + _[i] / exp(_[i]) for i in eachindex(_)]
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
object_with_a_long_name = [-1,2,3]

output = let x = object_with_a_long_name
   [abs(x[i]) + x[i] / exp(x[i]) for i in eachindex(x)]
end
 
