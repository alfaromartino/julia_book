# necessary packages for this file
using Pipe

# to execute the benchmarks
using BenchmarkTools
ref(x) = (Ref(x))[]

# To print results with a specific format (only relevant for the website construction)
print_asis(x)             = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_asis(x,nr_lines)    = show(IOContext(stdout, :limit => true, :displaysize =>(nr_lines,100)), MIME("text/plain"), x)
print_compact(x)          = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x)
print_compact(x,nr_lines) = show(IOContext(stdout, :limit => true, :displaysize =>(nr_lines,6), :compact => true), MIME("text/plain"), x)

################################################################################################################################  ###code region1a (((
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

output = let a = a         # the 'a' on the left refers to the local variable
   temp1 = abs(a)
   temp2 = exp(temp1)
   round(temp2)
end 
 
 a = -2

output = let b = a         # 'b' is a local variable having the value of 'a' 
   temp1 = abs(b)
   temp2 = exp(temp1)
   round(temp2)
end 
 
 a = -2

output = a |> abs |> exp |> round 
 
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
 
 x = [-1,2,3]

output = round.(abs.(x) ./ sum(abs.(x))) 
 
 print_asis(output) # hide 
 
 x = [-1,2,3]

temp1  = abs.(x)
temp2  = temp1 ./ sum(temp1)
output = round.(temp2) 
 
 x = [-1,2,3]

output = abs.(x) |> (y -> y ./ sum(y)) |> (y -> round.(y))

#equivalent, but more readable
output = abs.(x)                  |>
         y -> y ./ sum(y)         |>
         y -> round.(y) 
 
 x = [-1,2,3] ; using Pipe

output = @pipe abs.(x) |> (_ ./ sum(_)) |> (round.(_))

#equivalent, but more readable
output = @pipe abs.(x)            |>
               _ ./ sum(_)        |>
               round.(_) 
 
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
 
 