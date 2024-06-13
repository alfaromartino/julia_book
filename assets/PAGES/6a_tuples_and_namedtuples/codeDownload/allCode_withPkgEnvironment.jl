####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used when writing this note.
# It requires having all files (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml) in the same folder.

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# For more accurate benchmarks, we interpolate variable `x` as in `foo($x)`
using BenchmarkTools



############################################################################
#
#                           START OF THE CODE 
#
############################################################################
 
# necessary packages for this file
# using Statistics, Distributions, Random, Pipe
 
############################################################################
#
#       KEY-VALUES
#
############################################################################
 
x = [4, 5, 6]
 



x = (4, 5, 6)
 



############################################################################
#
#       TYPE SYMBOL
#
############################################################################
 
some_symbol = :x
 



some_symbol = Symbol("x")
 



some_symbol = Symbol(1)
 



vector_symbols = [:x, :y]
 



vector_symbols = [Symbol("x"), Symbol("y")]
 
############################################################################
#
#       TYPE PAIRS
#
############################################################################
 



some_pair = ("a" => 1)      # or simply 'some_pair = "a" => 1'
 



some_pair = Pair("a", 1)            # equivalent
 
############################################################################
#
#       DICTIONARIES
#
############################################################################
 
some_dict = Dict("a" => 10, "b" => 20)
 



some_dict = Dict("a" => 10, "b" => 20)

keys_from_dict = collect(keys(some_dict))
 



some_dict = Dict(:a => 10, :b => 20)
 
some_dict = Dict(:a => 10, :b => 20)

keys_from_dict = collect(keys(some_dict))
 



some_dict = Dict(3 => 10, 4 => 20)
 



some_dict = Dict(3 => 10, 4 => 20)

keys_from_dict = collect(keys(some_dict))
 
some_dict = Dict((1,1) => 10, (1,2) => 20)
 
some_dict = Dict((1,1) => 10, (1,2) => 20)

keys_from_dict = collect(keys(some_dict))
 



vector = [10, 20] # or tupl = (10,20)



dict = Dict(pairs(vector))
 



keys_for_dict   = [:a, :b]
values_for_dict = [10, 20]


dict = Dict(zip(keys_for_dict, values_for_dict))
 



keys_for_dict   = (:a, :b)
values_for_dict = (10, 20)


dict = Dict(zip(keys_for_dict, values_for_dict))
 



nt_for_dict = (a = 10, b = 20)



dict = Dict(pairs(nt_for_dict))
 



keys_for_dict      = (:a, :b)
values_for_dict    = (10, 20)
vector_keys_values = [(keys_for_dict[i], values_for_dict[i]) for i in eachindex(keys_for_dict)]

dict = Dict(vector_keys_values)
 



x = (a=4, b=5, c=6)
 



a = 10
b = 20


nt = (; a, b)
 



keys_for_nt   = [:a, :b]
values_for_nt = [10, 20]


nt = NamedTuple(zip(keys_for_nt, values_for_nt))
 



keys_for_nt   = (:a, :b)
values_for_nt = (10, 20)


nt = NamedTuple(zip(keys_for_nt, values_for_nt))
 



keys_for_nt   = [:a, :b]
values_for_nt = [10, 20]


nt = (; zip(keys_for_nt, values_for_nt)...)
 



keys_for_nt        = [:a, :b]
values_for_nt      = [10, 20]
vector_keys_values = [(keys_for_nt[i], values_for_nt[i]) for i in eachindex(keys_for_nt)]

nt = NamedTuple(vector_keys_values)
 
dict = Dict(:a => 10, :b => 20)



nt = NamedTuple(vector_keys_values)
 
