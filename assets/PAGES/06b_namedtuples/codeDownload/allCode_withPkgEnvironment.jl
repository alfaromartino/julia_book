####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used on the website.
# It requires having all files in the same folder (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml).

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    It provides the same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. 
        e.g., `@ctime foo($x)` for timing `foo(x)` =#

# uncomment the following if you don't have the package for @ctime installed
    # import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
using FastBenchmark
 
############################################################################
#
#			SECTION: "NAMED TUPLES AND DICTIONARIES"
#
############################################################################
 
############################################################################
#
#       KEY AND VALUES
#
############################################################################
 
x        = [4, 5, 6]

x_keys   = collect(keys(x))
x_values = collect(values(x))
 
println(x_keys)
 
println(x_values)
 



x        = (4, 5, 6)

x_keys   = collect(keys(x))
x_values = collect(values(x))
 
println(x_keys)
 
println(x_values)
 



####################################################
#	THE TYPE PAIR
####################################################
 
some_pair = ("a" => 1)      # or simply 'some_pair = "a" => 1'

some_pair = Pair("a", 1)    # equivalent
 
println(some_pair)
 
println(some_pair[1])
 
println(some_pair.first)
 



some_pair = ("a" => 1)      # or simply 'some_pair = "a" => 1'

some_pair = Pair("a", 1)    # equivalent
 
println(some_pair)
 
println(some_pair[2])
 
println(some_pair.second)
 
############################################################################
#
#       TYPE SYMBOL
#
############################################################################
 
vector_symbols = [:x, :y]
 
println(vector_symbols)
 



vector_symbols = [Symbol("x"), Symbol("y")]
 
println(vector_symbols)
 
############################################################################
#
#			NAMED TUPLES
#
############################################################################
 
# all 'nt' are equivalent
nt = (  a=10, b=20)
nt = (; a=10, b=20)
nt = (  :a => 10, :b => 20)
nt = (; :a => 10, :b => 20)
 
println(nt)
 
println(nt.a)
 
println(nt[:a])
 



# all 'nt' are equivalent
nt = (  a=10,)
nt = (; a=10 )
nt = (  :a => 10,)
nt = (; :a => 10 )

#not 'nt =  (a = 10)'  -> this is interpreted as 'nt = a = 10'
#not 'nt = (:a => 10)' -> this is interpreted as a pair
 
println(nt)
 
println(nt.a)
 
println(nt[:a])
 



####################################################
#	remark
####################################################
 
nt        = (a=10, b=20)

nt_keys   = collect(keys(nt))
nt_values = collect(values(nt))
 
println(nt_keys)
 
println(nt_values)
 



####################################################
#	Distinction Between The Creation Of Tuples and Named Tuples
####################################################
 
x   = 10
y   = 20

nt  = (; x, y)
tup = (x, y)
 
println(nt)
 
println(tup)
 



x   = 10


nt  = (; x)
tup = (x, )
 
println(nt)
 
println(tup)
 
############################################################################
#
#       DICTIONARIES
#
############################################################################
 
some_dict = Dict(3 => 10, 4 => 20)
 
println(some_dict)
 
println(some_dict[3])
 



some_dict = Dict("a" => 10, "b" => 20)
 
println(some_dict)
 
println(some_dict["a"])
 



some_dict = Dict(:a => 10, :b => 20)
 
println(some_dict)
 
println(some_dict[:a])
 



some_dict = Dict((1,1) => 10, (1,2) => 20)
println(some_dict)
 
println(some_dict[(1,1)])
 
println(some_dict[(1,1)])
 



####################################################
#	dictionaries are unordered
####################################################
 
some_dict      = Dict(3 => 10, 4 => 20)

keys_from_dict = collect(keys(some_dict))
println(keys_from_dict)
 



some_dict      = Dict("a" => 10, "b" => 20)

keys_from_dict = collect(keys(some_dict))
println(keys_from_dict)
 



some_dict      = Dict(:a => 10, :b => 20)

keys_from_dict = collect(keys(some_dict))
println(keys_from_dict)
 



some_dict      = Dict((1,1) => 10, (1,2) => 20)

keys_from_dict = collect(keys(some_dict))
println(keys_from_dict)
 
############################################################################
#
#			CREATING TUPLES, NAMED TUPLES, AND DICTIONARIES
#
############################################################################
 
####################################################
#	CREATING DICTIONARIES
####################################################
 
vector = [10, 20] # or tupl = (10,20)



dict = Dict(pairs(vector))
 
println(dict)
 



keys_for_dict   = [:a, :b]
values_for_dict = [10, 20]


dict = Dict(zip(keys_for_dict, values_for_dict))
 
println(dict)
 



keys_for_dict   = (:a, :b)
values_for_dict = (10, 20)


dict = Dict(zip(keys_for_dict, values_for_dict))
 
println(dict)
 



nt_for_dict = (a = 10, b = 20)



dict = Dict(pairs(nt_for_dict))
 
println(dict)
 



keys_for_dict      = (:a, :b)
values_for_dict    = (10, 20)
vector_keys_values = [(keys_for_dict[i], values_for_dict[i]) for i in eachindex(keys_for_dict)]

dict = Dict(vector_keys_values)
 
println(dict)
 



####################################################
#	CREATING TUPLES
####################################################
 
a              = 10
b              = 20

tup            = (a, b)
 
println(tup)
 



values_for_tup = [10, 20]

tup            = Tuple(values_for_tup)
 
println(tup)
 



values_for_tup = [10, 20]

tup            = (values_for_tup... ,)
 
println(tup)
 
####################################################
#	CREATING NAMED TUPLES
####################################################
 
a = 10
b = 20


nt = (; a, b)
 
println(nt)
 



keys_for_nt   = [:a, :b]
values_for_nt = [10, 20]


nt = NamedTuple(zip(keys_for_nt, values_for_nt))
 
println(nt)
 



keys_for_nt   = (:a, :b)
values_for_nt = (10, 20)


nt = NamedTuple(zip(keys_for_nt, values_for_nt))
 
println(nt)
 



keys_for_nt   = [:a, :b]
values_for_nt = [10, 20]


nt = (; zip(keys_for_nt, values_for_nt)...)
 
println(nt)
 



keys_for_nt        = [:a, :b]
values_for_nt      = [10, 20]
vector_keys_values = [(keys_for_nt[i], values_for_nt[i]) for i in eachindex(keys_for_nt)]

nt = NamedTuple(vector_keys_values)
 
println(nt)
 



dict = Dict(:a => 10, :b => 20)



nt = NamedTuple(vector_keys_values)
 
println(nt)
 



############################################################################
#
#			DESTRUCTURING TUPLES AND NAMED TUPLES
#
############################################################################
 
####################################################
#	Destructuring Collections Through Tuples 
####################################################
 
list = [3,4]

x,y  = list
 
println(x)
 
println(y)
 



list = 3:4

x,y  = list
 
println(x)
 
println(y)
 



list = (3,4)

x,y  = list
 
println(x)
 
println(y)
 



list = (a = 3, b = 4)

x,y  = list
 
println(x)
 
println(y)
 



####################################################
#	not possible to skip values
####################################################
 
list  = [3,4,5]

(x,)  = list
 
println(x)
 



list  = [3,4,5]

x,y   = list
 
println(x)
 
println(y)
 



list  = [3,4,5]

_,_,z = list        # _ or any symbol (_ just signals we don't care about that value)
 
println(z)
 



list  = [3,4,5]

x,_,z = list        # _ or any symbol (it just signals we don't care about that value)
 
println(x)
 
println(z)
 



####################################################
#	Destructuring with Named Tuples on Both Sides 
####################################################
 
nt             = (; key1 = 10, key2 = 20, key3 = 30)

(; key3, key1) = nt            # keys in any order
 
println(key1)
 
println(key3)
 



nt             = (; key1 = 10, key2 = 20, key3 = 30)

(; key2)       = nt            # only one key
 
println(key2)
 
####################################################
#	remark
####################################################
 
nt = (; key1 = 10, key2 = 20, key3 = 30)

 key2, key1    = nt     # variables defined according to POSITION
(key2, key1)   = nt     # alternative notation
 
println(key2)
 
println(key1)
 



nt = (; key1 = 10, key2 = 20, key3 = 30)

(; key2, key1) = nt     # variables defined according to KEY
 ; key2, key1  = nt     # alternative notation
 
println(key1)
 
println(key2)
 



# same caveat for single variables
 
nt       = (; key1 = 10, key2 = 20)

(key2,)  = nt            # variable defined according to POSITION
 
println(key2)
 



nt       = (; key1 = 10, key2 = 20)

(; key2) = nt            # variable defined according to KEY
 
println(key2)
 
####################################################
#	application destructuring 1: storing parameters of a model
####################################################
 
β = 3 
δ = 4 
ϵ = 5

# function 'foo' uses β and δ, but not ϵ
function foo(x, δ, β) 
    x * δ + exp(β) / β
end

output = foo(2, δ, β)
 
println(output)
 



parameters_list = (; β = 3, δ = 4, ϵ = 5)



# function 'foo' uses β and δ, but not ϵ
function foo(x, parameters_list) 
    x * parameters_list.δ + exp(parameters_list.β) / parameters_list.β
end

output = foo(2, parameters_list.β, parameters_list.δ)
 
println(output)
 



parameters_list = (; β = 3, δ = 4, ϵ = 5)



# function 'foo' uses β and δ, but not ϵ
function foo(x, parameters_list) 
    x * parameters_list.δ + exp(parameters_list.β) / parameters_list.β
end

output = foo(2, parameters_list)
 
println(output)
 



####################################################
#	application destructuring 2: storing outputs of function
####################################################
 
function foo()
    out1 = 2
    out2 = 3
    out3 = 4

    out1, out2, out3
end

x, y, z = foo()
 



function foo()
    out1 = 2
    out2 = 3
    out3 = 4

    [out1, out2, out3]
end

x, y, z = foo()
 



function foo()
    out1 = 2
    out2 = 3
    out3 = 4

    out1, out2, out3
end

x, _, z = foo()
 



function foo()
    out1 = 2
    out2 = 3
    out3 = 4

    [out1, out2, out3]
end

x, _, z = foo()
 



function foo()
    out1 = 2
    out2 = 3
    out3 = 4

    (; out1, out2, out3)
end

(; out1, out3) = foo()
 
