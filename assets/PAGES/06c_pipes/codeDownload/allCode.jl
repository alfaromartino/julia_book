############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    Same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. E.g., `@ctime foo($x)` for timing `foo(x)`=#

# import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
    # uncomment if you don't have the package installed
using FastBenchmark
    

############################################################################
#
#			START OF THE CODE
#
############################################################################
 
# necessary packages for this file
using Pipe
 
############################################################################
#
#			LET BLOCKS
#
############################################################################
 
a      = -2

output = round(log(abs(a)))
println(output)
 



a      = -2

temp1  = abs(a)
temp2  = log(temp1)
output = round(temp2)
println(output)
 
println(temp1)
 
println(temp2)
 



a      = -2

output = let b = a         # 'b' is a local variable having the value of 'a' 
   temp1 = abs(b)
   temp2 = log(temp1)
   round(temp2)
end
println(output)
 
#println(temp1) #ERROR in a new session
 
#println(temp2) #ERROR in a new session
 



a      = -2

output = let a = a         # the 'a' on the left of `=` defines a local variable
   temp1 = abs(a)
   temp2 = log(temp1)
   round(temp2)
end
println(output)
 
#println(temp1) #ERROR in a new session
 
#println(temp2) #ERROR in a new session
 



####################################################
#	remark: Let Blocks Can Mutate Variables
####################################################
 
# just like functions, be careful as you can mutate the global variable 
x = [2,2,2]

output = let x = x
   x[1] = 0
end
println(x)
 
# just like functions too, you can't reassign a value through a let block 
x = [2,2,2]

output = let x = x
   x = 0
end
println(x)
 
############################################################################
#
#			PIPES
#
############################################################################
 
a      = -2

output = round(log(abs(a)))
println(output)
 



a      = -2

output = a |> abs |> log |> round
println(output)
 



####################################################
#	remark: Let Blocks and Pipes For Long Names
####################################################
 
variable_with_a_long_name = 2

output = variable_with_a_long_name - log(variable_with_a_long_name) / abs(variable_with_a_long_name)
println(output)
 



variable_with_a_long_name = 2

temp   = variable_with_a_long_name
output = temp - log(temp) / abs(temp)
println(output)
 



variable_with_a_long_name = 2

output = variable_with_a_long_name  |>
         a -> a - log(a) / abs(a)
println(output)
 



variable_with_a_long_name = 2

output = let x = variable_with_a_long_name
    x - log(x) / abs(x)
end
println(output)
 



####################################################
#	broadcasting pipes
####################################################
 
x      = [-1,2,3]

output = sum(log.(abs.(x)))
println(output)
 



x      = [-1,2,3]

temp1  = abs.(x)
temp2  = log.(temp1)
output = sum(temp2)
println(output)
 



x      = [-1,2,3]

output = x .|> abs .|> log |> sum
println(output)
 



####################################################
#	Pipes with More Complex Operations 
####################################################
 
a      = -2

output = round(2 * abs(a))
println(output)
 



a      = -2

temp1  = abs(a)
temp2  = 2 * temp1
output = round(temp2)
println(output)
 



a      = -2

output = a |> abs |> (x -> 2 * x) |> round

#equivalent and more readable
output = a              |>
         abs            |>
         x -> 2 * x     |>
         round
println(output)
 



####################################################
#	Package Pipe
####################################################
 
#
a      = -2

output = a |> abs |> (x -> 2 * x) |> round

#equivalent and more readable
output =       a            |>
               abs          |>
               x -> 2 * x   |>
               round
println(output)
 



using Pipe
a = -2

output = @pipe a |> abs |> 2 * _ |> round

#equivalent and more readable
output = @pipe a            |>
               abs          |>
               2 * _        |>
               round
println(output)
 



############################################################################
#
#			FUNCTION COMPOSITION
#
############################################################################
 
a        = -1



# all `output` are equivalent
output   = log(abs(a))
output   = a |> abs |> log
output   = (log ∘ abs)(a)
output   = ∘(log, abs)(a)
println(output)
 



a        = 2
outer(a) = a + 2
inner(a) = a / 2

# all `output` are equivalent
output   = (a / 2) + 2
output   = outer(inner(a))
output   = a |> inner |> outer
output   = (outer ∘ inner)(a)
output   = ∘(outer, inner)(a)
println(output)
 



x        = [1, 2, 3]



# all `output` are equivalent
output   = log.(abs.(x))
output   = x .|> abs .|> log
output   = (log ∘ abs).(x)
output   = ∘(log, abs).(x)
println(output)
 



x        = [1, 2, 3]
outer(a) = a + 2
inner(a) = a / 2

# all `output` are equivalent
output   = (x ./ 2) .+ 2
output   = outer.(inner.(x))
output   = x .|> inner .|> outer
output   = (outer ∘ inner).(x)
output   = ∘(outer, inner).(x)
println(output)
 



a            = -1

inners       = abs
outers       = [log, sqrt]
compositions = outers .∘ inners

# all `output` are equivalent
output       = [log(abs(a)), sqrt(abs(a))]
output       = [foo(a) for foo in compositions]
 
println(compositions)
 
println(output)
 
