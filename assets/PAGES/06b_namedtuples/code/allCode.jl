include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
# using Statistics, Distributions, Random, Pipe
 
############################################################################
#
#			NAMED TUPLES AND DICTIONARIES
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
 
print_asis(x_keys) #hide
 
print_asis(x_values) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x        = (4, 5, 6)

x_keys   = collect(keys(x))
x_values = collect(values(x))
 
print_asis(x_keys) #hide
 
print_asis(x_values) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	THE TYPE PAIR
####################################################
 
some_pair = ("a" => 1)      # or simply 'some_pair = "a" => 1'

some_pair = Pair("a", 1)    # equivalent
 
print_asis(some_pair) #hide
 
print_asis(some_pair[1]) #hide
 
print_asis(some_pair.first) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
some_pair = ("a" => 1)      # or simply 'some_pair = "a" => 1'

some_pair = Pair("a", 1)    # equivalent
 
print_asis(some_pair) #hide
 
print_asis(some_pair[2]) #hide
 
print_asis(some_pair.second) #hide
 
############################################################################
#
#       TYPE SYMBOL
#
############################################################################
 
vector_symbols = [:x, :y]
 
print_asis(vector_symbols) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
vector_symbols = [Symbol("x"), Symbol("y")]
 
print_asis(vector_symbols) #hide
 
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
 
print_asis(nt)  #hide
 
print_asis(nt.a)  #hide
 
print_asis(nt[:a])  #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# all 'nt' are equivalent
nt = (  a=10,)
nt = (; a=10 )
nt = (  :a => 10,)
nt = (; :a => 10 )

#not 'nt =  (a = 10)'  -> this is interpreted as 'nt = a = 10'
#not 'nt = (:a => 10)' -> this is interpreted as a pair
 
print_asis(nt)  #hide
 
print_asis(nt.a)  #hide
 
print_asis(nt[:a])  #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	remark
####################################################
 
nt        = (a=10, b=20)

nt_keys   = collect(keys(nt))
nt_values = collect(values(nt))
 
print_asis(nt_keys)        #hide
 
print_asis(nt_values)        #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	Distinction Between The Creation Of Tuples and Named Tuples
####################################################
 
x   = 10
y   = 20

nt  = (; x, y)
tup = (x, y)
 
print_asis(nt)        #hide
 
print_asis(tup)        #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x   = 10


nt  = (; x)
tup = (x, )
 
print_asis(nt)        #hide
 
print_asis(tup)        #hide
 
############################################################################
#
#       DICTIONARIES
#
############################################################################
 
some_dict = Dict(3 => 10, 4 => 20)
 
print_asis(some_dict) #hide
 
print_asis(some_dict[3]) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
some_dict = Dict("a" => 10, "b" => 20)
 
print_asis(some_dict) #hide
 
print_asis(some_dict["a"]) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
some_dict = Dict(:a => 10, :b => 20)
 
print_asis(some_dict) #hide
 
print_asis(some_dict[:a]) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
some_dict = Dict((1,1) => 10, (1,2) => 20)
print_asis(some_dict) #hide
 
print_asis(some_dict[(1,1)]) #hide
 
print_asis(some_dict[(1,1)]) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	dictionaries are unordered
####################################################
 
some_dict      = Dict(3 => 10, 4 => 20)

keys_from_dict = collect(keys(some_dict))
print_asis(keys_from_dict) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
some_dict      = Dict("a" => 10, "b" => 20)

keys_from_dict = collect(keys(some_dict))
print_asis(keys_from_dict) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
some_dict      = Dict(:a => 10, :b => 20)

keys_from_dict = collect(keys(some_dict))
print_asis(keys_from_dict) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
some_dict      = Dict((1,1) => 10, (1,2) => 20)

keys_from_dict = collect(keys(some_dict))
print_asis(keys_from_dict) #hide
 
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
# <space_to_be_deleted>
 
####################################################
#	CREATING TUPLES
####################################################
 
a              = 10
b              = 20

tup            = (a, b)
 
print_asis(tup) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
values_for_tup = [10, 20]

tup            = Tuple(values_for_tup)
 
print_asis(tup) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
values_for_tup = [10, 20]

tup            = (values_for_tup... ,)
 
print_asis(tup) #hide
 
####################################################
#	CREATING NAMED TUPLES
####################################################
 
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
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
dict = Dict(:a => 10, :b => 20)



nt = NamedTuple(vector_keys_values)
 
print_asis(nt) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
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
 
print_asis(x)       #hide
 
print_asis(y)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
list = 3:4

x,y  = list
 
print_asis(x)       #hide
 
print_asis(y)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
list = (3,4)

x,y  = list
 
print_asis(x)       #hide
 
print_asis(y)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
list = (a = 3, b = 4)

x,y  = list
 
print_asis(x)       #hide
 
print_asis(y)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	not possible to skip values
####################################################
 
list  = [3,4,5]

(x,)  = list
 
print_asis(x)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
list  = [3,4,5]

x,y   = list
 
print_asis(x)       #hide
 
print_asis(y)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
list  = [3,4,5]

_,_,z = list        # _ or any symbol (it just signals we don't care about that value)
 
print_asis(z)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
list  = [3,4,5]

x,_,z = list        # _ or any symbol (it just signals we don't care about that value)
 
print_asis(x)       #hide
 
print_asis(z)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	Destructuring with Named Tuples on Both Sides 
####################################################
 
nt             = (; key1 = 10, key2 = 20, key3 = 30)

(; key3, key1) = nt            # keys in any order
 
print_asis(key1)       #hide
 
print_asis(key3)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
nt             = (; key1 = 10, key2 = 20, key3 = 30)

(; key2)       = nt            # only one key
 
print_asis(key2)       #hide
 
####################################################
#	remark
####################################################
 
nt = (; key1 = 10, key2 = 20, key3 = 30)

 key2, key1    = nt     # variables defined according to POSITION
(key2, key1)   = nt     # alternative notation
 
print_asis(key2)       #hide
 
print_asis(key1)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
nt = (; key1 = 10, key2 = 20, key3 = 30)

(; key2, key1) = nt     # variables defined according to KEY
 ; key2, key1  = nt     # alternative notation
 
print_asis(key1)       #hide
 
print_asis(key2)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# same caveat for single variables
 
nt       = (; key1 = 10, key2 = 20)

(key2,)  = nt            # variable defined according to POSITION
 
print_asis(key2)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
nt       = (; key1 = 10, key2 = 20)

(; key2) = nt            # variable defined according to KEY
 
print_asis(key2)       #hide
 
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
 
print_compact(output)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
parameters_list = (; β = 3, δ = 4, ϵ = 5)



# function 'foo' uses β and δ, but not ϵ
function foo(x, parameters_list) 
    x * parameters_list.δ + exp(parameters_list.β) / parameters_list.β
end

output = foo(2, parameters_list.β, parameters_list.δ)
 
print_compact(output)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
parameters_list = (; β = 3, δ = 4, ϵ = 5)



# function 'foo' uses β and δ, but not ϵ
function foo(x, parameters_list) 
    x * parameters_list.δ + exp(parameters_list.β) / parameters_list.β
end

output = foo(2, parameters_list)
 
print_compact(output)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
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
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo()
    out1 = 2
    out2 = 3
    out3 = 4

    [out1, out2, out3]
end

x, y, z = foo()
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo()
    out1 = 2
    out2 = 3
    out3 = 4

    out1, out2, out3
end

x, _, z = foo()
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo()
    out1 = 2
    out2 = 3
    out3 = 4

    [out1, out2, out3]
end

x, _, z = foo()
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo()
    out1 = 2
    out2 = 3
    out3 = 4

    (; out1, out2, out3)
end

(; out1, out3) = foo()
 
