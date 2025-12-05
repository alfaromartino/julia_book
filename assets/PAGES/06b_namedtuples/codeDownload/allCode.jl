############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    Same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. E.g., `@ctime foo($x)` for timing `foo(x)`=#

# import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git") #uncomment if you don't have the package installed
using FastBenchmark
    
############################################################################
#   AUXILIARS FOR DISPLAYING RESULTS
############################################################################
# you can alternatively use "println" or "display"
print_asis(x)    = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_compact(x) = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x)


############################################################################
#
#			START OF THE CODE
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
some_dict
 



some_dict      = Dict("a" => 10, "b" => 20)

keys_from_dict = collect(keys(some_dict))
keys_from_dict
 



some_dict = Dict(:a => 10, :b => 20)
some_dict
 
some_dict      = Dict(:a => 10, :b => 20)

keys_from_dict = collect(keys(some_dict))
keys_from_dict
 



some_dict = Dict(3 => 10, 4 => 20)
some_dict
 



some_dict      = Dict(3 => 10, 4 => 20)

keys_from_dict = collect(keys(some_dict))
keys_from_dict
 
some_dict = Dict((1,1) => 10, (1,2) => 20)
some_dict
 
some_dict      = Dict((1,1) => 10, (1,2) => 20)

keys_from_dict = collect(keys(some_dict))
keys_from_dict
 



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
 
############################################################################
#
#                           CREATING TUPLES
#
############################################################################
 
a              = 10
b              = 20

tup            = (a, b)
 



values_for_tup = [10, 20]

tup            = Tuple(values_for_tup)
 



values_for_tup = [10, 20]

tup            = (values_for_tup... ,)
 
############################################################################
#
#                           APPLICATION 2: STORING OUTPUTS OF FUNCTIONS
#
############################################################################
 
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
 
