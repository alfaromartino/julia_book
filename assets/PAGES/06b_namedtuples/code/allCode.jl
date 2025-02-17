include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
# using Statistics, Distributions, Random, Pipe
 
############################################################################
#
#       KEY-VALUES
#
############################################################################
 
x = [4, 5, 6]
 
print_asis(collect(keys(x))) #hide
 
print_asis(collect(values(x))) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = (4, 5, 6)
 
print_asis(collect(keys(x))) #hide
 
print_asis(collect(values(x))) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#       TYPE SYMBOL
#
############################################################################
 
some_symbol = :x
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
some_symbol = Symbol("x")
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
some_symbol = Symbol(1)
 
print_asis(some_symbol) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
vector_symbols = [:x, :y]
 
print_asis(vector_symbols) #hide
 
print_asis(vector_symbols[1]) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
vector_symbols = [Symbol("x"), Symbol("y")]
 
print_asis(vector_symbols) #hide
 
print_asis(vector_symbols[1]) #hide
 
############################################################################
#
#       TYPE PAIRS
#
############################################################################
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
some_pair = ("a" => 1)      # or simply 'some_pair = "a" => 1'
 
print_asis(some_pair) #hide
 
print_asis(some_pair[1]) #hide
 
print_asis(some_pair.first) #hide
 
print_asis(some_pair[2]) #hide
 
print_asis(some_pair.second) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
some_pair = Pair("a", 1)            # equivalent
 
print_asis(some_pair) #hide
 
print_asis(some_pair[1]) #hide
 
print_asis(some_pair.second) #hide
 
############################################################################
#
#       DICTIONARIES
#
############################################################################
 
some_dict = Dict("a" => 10, "b" => 20)
print_asis(some_dict) #hide
 
print_asis(some_dict["a"]) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
some_dict = Dict("a" => 10, "b" => 20)

keys_from_dict = collect(keys(some_dict))
print_asis(keys_from_dict) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
some_dict = Dict(:a => 10, :b => 20)
print_asis(some_dict) #hide
 
print_asis(some_dict[:a]) #hide
 
some_dict = Dict(:a => 10, :b => 20)

keys_from_dict = collect(keys(some_dict))
print_asis(keys_from_dict) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
some_dict = Dict(3 => 10, 4 => 20)
print_asis(some_dict) #hide
 
print_asis(some_dict[3]) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
some_dict = Dict(3 => 10, 4 => 20)

keys_from_dict = collect(keys(some_dict))
print_asis(keys_from_dict) #hide
 
some_dict = Dict((1,1) => 10, (1,2) => 20)
print_asis(some_dict) #hide
 
print_asis(some_dict[(1,1)]) #hide
 
some_dict = Dict((1,1) => 10, (1,2) => 20)

keys_from_dict = collect(keys(some_dict))
print_asis(keys_from_dict) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
vector = [10, 20] # or tupl = (10,20)



dict = Dict(pairs(vector))
 
print_asis(dict) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
keys_for_dict   = [:a, :b]
values_for_dict = [10, 20]


dict = Dict(zip(keys_for_dict, values_for_dict))
 
print_asis(dict) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
keys_for_dict   = (:a, :b)
values_for_dict = (10, 20)


dict = Dict(zip(keys_for_dict, values_for_dict))
 
print_asis(dict) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
nt_for_dict = (a = 10, b = 20)



dict = Dict(pairs(nt_for_dict))
 
print_asis(dict) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
keys_for_dict      = (:a, :b)
values_for_dict    = (10, 20)
vector_keys_values = [(keys_for_dict[i], values_for_dict[i]) for i in eachindex(keys_for_dict)]

dict = Dict(vector_keys_values)
 
print_asis(dict) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = (a=4, b=5, c=6)
 
print_asis(collect(keys(x))) #hide
 
print_asis(values(x)) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
a = 10
b = 20


nt = (; a, b)
 
print_asis(nt) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
keys_for_nt   = [:a, :b]
values_for_nt = [10, 20]


nt = NamedTuple(zip(keys_for_nt, values_for_nt))
 
print_asis(nt) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
keys_for_nt   = (:a, :b)
values_for_nt = (10, 20)


nt = NamedTuple(zip(keys_for_nt, values_for_nt))
 
print_asis(nt) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
keys_for_nt   = [:a, :b]
values_for_nt = [10, 20]


nt = (; zip(keys_for_nt, values_for_nt)...)
 
print_asis(nt) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
keys_for_nt        = [:a, :b]
values_for_nt      = [10, 20]
vector_keys_values = [(keys_for_nt[i], values_for_nt[i]) for i in eachindex(keys_for_nt)]

nt = NamedTuple(vector_keys_values)
 
print_asis(nt) #hide
 
dict = Dict(:a => 10, :b => 20)



nt = NamedTuple(vector_keys_values)
 
print_asis(nt) #hide
 
############################################################################
#
#                           CREATING TUPLES
#
############################################################################
 
a = 10
b = 20

tup = (a, b)
 
print_asis(tup) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
values_for_tup = [10, 20]


tup = Tuple(values_for_tup)
 
print_asis(tup) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
values_for_tup = [10, 20]


tup = (values_for_tup... ,)
 
print_asis(tup) #hide
 
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
 
