using BenchmarkTools
print_asis(x)    = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_compact(x) = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x) 
 
 x = [4, 5, 6] 
 
 print_asis(keys(x)) #hide 
 
 print_asis(collect(keys(x))) #hide 
 
 print_asis(values(x)) #hide 
 
 print_asis(collect(values(x))) #hide 
 
 x = (4, 5, 6) 
 
 print_asis(keys(x)) #hide 
 
 print_asis(collect(keys(x))) #hide 
 
 print_asis(values(x)) #hide 
 
 print_asis(collect(values(x))) #hide 
 
 x = (a=4, b=5, c=6) 
 
 print_asis(keys(x)) #hide 
 
 print_asis(collect(keys(x))) #hide 
 
 print_asis(values(x)) #hide 
 
 print_asis(collect(values(x))) #hide 
 
 dict = Dict("a" => 10, "b" => 20)
print_asis(dict) #hide 
 
 print_asis(dict["a"]) #hide 
 
 dict = Dict("a" => 10, "b" => 20)

keys_from_dict = collect(keys(dict))
print_asis(keys_from_dict) #hide 
 
 dict = Dict(:a => 10, :b => 20)
print_asis(dict) #hide 
 
 print_asis(dict[:a]) #hide 
 
 dict = Dict(:a => 10, :b => 20)

keys_from_dict = collect(keys(dict))
print_asis(keys_from_dict) #hide 
 
 dict = Dict(1 => 10, 2 => 20)
print_asis(dict) #hide 
 
 print_asis(dict[1]) #hide 
 
 dict = Dict(1 => 10, 2 => 20)

keys_from_dict = collect(keys(dict))
print_asis(keys_from_dict) #hide 
 
 dict = Dict((1,1) => 10, (1,2) => 20)
print_asis(dict) #hide 
 
 print_asis(dict[(1,1)]) #hide 
 
 dict = Dict((1,1) => 10, (1,2) => 20)

keys_from_dict = collect(keys(dict))
print_asis(keys_from_dict) #hide 
 
 vector = [10, 20] # or tupl = (10,20)



dict = Dict(pairs(vector)) 
 
 print_asis(dict) #hide 
 
 keys_for_dict   = [:a, :b]
values_for_dict = [10, 20]


dict = Dict(zip(keys_for_dict, values_for_dict)) 
 
 print_asis(dict) #hide 
 
 keys_for_dict   = (:a, :b)
values_for_dict = (10, 20)


dict = Dict(zip(keys_for_dict, values_for_dict)) 
 
 print_asis(dict) #hide 
 
 nt_for_dict = (a = 10, b = 20)



dict = Dict(pairs(nt_for_dict)) 
 
 print_asis(dict) #hide 
 
 keys_for_dict      = (:a, :b)
values_for_dict    = (10, 20)
vector_keys_values = [(keys_for_dict[i], values_for_dict[i]) for i in eachindex(keys_for_dict)]

dict = Dict(vector_keys_values) 
 
 print_asis(dict) #hide 
 
 a = 10
b = 20


nt = (; a, b) 
 
 print_asis(nt) #hide 
 
 keys_for_nt   = [:a, :b]
values_for_nt = [10, 20]


nt = NamedTuple(zip(keys_for_nt, values_for_nt)) 
 
 print_asis(nt) #hide 
 
 keys_for_nt   = (:a, :b)
values_for_nt = (10, 20)


nt = NamedTuple(zip(keys_for_nt, values_for_nt)) 
 
 print_asis(nt) #hide 
 
 keys_for_nt   = [:a, :b]
values_for_nt = [10, 20]


nt = (; zip(keys_for_nt, values_for_nt)...) 
 
 print_asis(nt) #hide 
 
 keys_for_nt        = [:a, :b]
values_for_nt      = [10, 20]
vector_keys_values = [(keys_for_nt[i], values_for_nt[i]) for i in eachindex(keys_for_nt)]

nt = NamedTuple(vector_keys_values) 
 
 print_asis(nt) #hide 
 
 dict = Dict(:a => 10, :b => 20)



nt = NamedTuple(vector_keys_values) 
 
 print_asis(nt) #hide 
 
 