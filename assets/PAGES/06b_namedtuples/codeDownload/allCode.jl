############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# For more accurate results, we benchmark code through functions.
    # We also interpolate each function argument, so that they're taken as local variables.
    # All this means that benchmarking a function `foo(x)` is done via `foo($x)`
using BenchmarkTools

# The following defines the macro `@ctime`, which is equivalent to `@btime` but faster
    # to use it, replace `@btime` with `@ctime`
using Chairmarks
macro ctime(expr)
    esc(quote
        object = @b $expr
        result = sprint(show, "text/plain", object) |>
            x -> object.allocs == 0 ?
                x * " (0 allocations: 0 bytes)" :
                replace(x, "allocs" => "allocations") |>
            x -> replace(x, r",.*$" => ")") |>
            x -> replace(x, "(without a warmup) " => "")
        println("  " * result)
    end)
end

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
 
