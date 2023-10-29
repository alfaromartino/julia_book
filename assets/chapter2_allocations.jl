
#using DataFrames,BenchmarkTools, FLoops, LoopVectorization, FastBroadcast, Formatting, ThreadsX, Strided, Distributions, Random, Pipe, BrowseTables
using DataFrames, BenchmarkTools, BrowseTables, Distributions, Random, Pipe
browse(x) = open_html_table(x)


# to test a complex function 
foo(x,y) = x / y * 100 + (x^2 + y^2) / y + log(x) + y * exp(x)

# use `$ref(()Ref(x))[]` for benchmarks
ref(x) = (Ref(x))[]

#push!(allocation, minimum(a).memory) ; push!(bench, @belapsed(x = some_number))
#bb = Dict(Symbol.(names(dff)) .=> Iterators.flatten(values(eachcol(dff))))
##############################################################################
#                                  EXAMPLE 1
##############################################################################
some_number = 1
some_array  = [1,2]
some_range  = 1:1
some_tuple  = (1,2)


bench = [] 
@pipe @benchmark(x = some_number)               |> push!(bench, _) 
@pipe @benchmark(x = some_array[1])             |> push!(bench, _) 
@pipe @benchmark(x = $ref(some_range)[1])       |> push!(bench, _) 
@pipe @benchmark((x,y) = $ref(some_tuple)[1:2]) |> push!(bench, _) 

benchs = Dict(:ex1 => bench)






##############################################################################
#                                   EXAMPLE 2
##############################################################################
bench = [] 

### FIRST 
function test(x)
    for _ in 1:100_000
        a = x[1:2]          # it allocates ONE temporary vector: `x[1:2]` only

        a[1] + a[2]
    end
end

array = [1,2,3]
@pipe @benchmark(test($ref(array))) |> push!(bench, _) 
# @btime(test($ref(array)))




### SECOND 
function test(x)
    for _ in 1:100_000
        a = view(x, 1:2)

        a[1] + a[2]
    end
end
array = [1,2,3]
@pipe @benchmark(test($ref(array))) |> push!(bench, _) 
# @btime(test($ref(array)))



### THIRD
function test(x)
    for _ in 1:100_000
        a = @view x[1:2]
        b = @view x[2:3]

        a[1] + a[2]
    end
end

array = [1,2,3]
@pipe @benchmark(test($ref(array))) |> push!(bench, _) 
# @btime(test($ref(array)))


### FOURTH
@views function test(x)
    for _ in 1:100_000
        a = x[1:2]
        b = x[2:3]

        a[1] + a[2]
    end
end

array = [1,2,3]
@pipe @benchmark(test($ref(array))) |> push!(bench, _) 
# @btime(test($ref(array)))

push!(benchs, :ex2 => bench)



##############################################################################
#                               INITIALIZING VECTORS
##############################################################################

#########################
# example 1
#########################

# initializing an array with `n` elements of type `Int64`
n = 100_000
array = Vector{Int64}(undef, n)

# initializing an array with same element types and length as `x`
x = [1, 2, missing]
array = similar(x)        # array `Vector{Union{Missing, Int64}}(undef, 3)`



#########################
# comparing performance
#########################
using DataFrames, BenchmarkTools, FLoops, LoopVectorization, FastBroadcast, Formatting, ThreadsX, Strided, Distributions, Random, Pipe, BrowseTables
function test(length_vector, repetitions)
    for i in 1:repetitions
        foo(length_vector)
    end
end

bench = []

# initializing an array with `n` elements
length_vector = 10_000
repetitions   = 100_000

foo(n) = Vector{Int64}(undef, n)
@btime test($ref(length_vector), $ref(repetitions));
#@pipe @benchmark(test($ref(length_vector), $ref(repetitions))) |> push!(bench, _) 

foo(n) = zeros(Int64, n)
@btime test($ref(length_vector), $ref(repetitions));
#@pipe @benchmark(test($ref(length_vector), $ref(repetitions))) |> push!(bench, _) 

foo(n) = ones(Int64, n)
@btime test($ref(length_vector), $ref(repetitions));
#@pipe @benchmark(test($ref(length_vector), $ref(repetitions))) |> push!(bench, _) 

foo(n) = fill(2, n)
@btime test($ref(length_vector), $ref(repetitions));
#@pipe @benchmark(test($ref(length_vector), $ref(repetitions))) |> push!(bench, _) 



##############################################################################
#                                   STATIC ARRAYS 1
##############################################################################

using Random ; Random.seed!(123)        #Setting the seed for reproducibility
nr_elements   = 10
repetitions   = 100_000
random_vector = rand(nr_elements, repetitions)

function test(random_list, repetitions)
    for i in 1:repetitions
        x = random_list[i]
        foo(x)
    end    
end

bench = [] 

function foo(x)
    a = x[1:2]
    b = x[2:3]

    sum(a[1] * b[2]) * sum(x)    
end
random_list = [random_vector[:, col] for col in 1:repetitions]
@pipe @benchmark(test($ref(random_list), $ref(repetitions))) |> push!(bench, _) 



@views function foo(x)
    a = x[1:2]
    b = x[2:3]

    sum(a[1] * b[2]) * sum(x)    
end
random_list = [random_vector[:, col] for col in 1:repetitions]
@pipe @benchmark(test($ref(random_list), $ref(repetitions))) |> push!(bench, _) 


function foo(x)
    a = x[1:2]
    b = x[2:3]

    sum(a[1] * b[2]) * sum(x)    
end
random_list   = [Tuple(random_vector[:, i]) for i in 1:repetitions]
@pipe @benchmark(test($ref(random_list), $ref(repetitions))) |> push!(bench, _) 


function foo(x)
    a = x[SVector(1,2)]
    b = x[SVector(2,3)]

    sum(a[1] * b[2]) * sum(x)    
end
using StaticArrays
static_arrays(i) = SVector{nr_elements,eltype(random_vector[1,:])}(random_vector[:, i])
random_list      = [static_arrays(i) for i in 1:repetitions]
@pipe @benchmark(test($ref(random_list), $ref(repetitions))) |> push!(bench, _) 


push!(benchs, :sa1 => bench)

##############################################################################
#                                   STATIC ARRAYS 2
##############################################################################

using Random ; Random.seed!(123)        #Setting the seed for reproducibility
nr_elements   = 200
repetitions   = 10_000
random_vector = rand(nr_elements, repetitions)

function test(random_list, repetitions)
    for i in 1:repetitions
        x = random_list[i]
        foo(x)
    end    
end

bench = [] 

function foo(x)
    a = x[1:2]
    b = x[2:3]

    sum(a[1] * b[2]) * sum(x)    
end
random_list = [random_vector[:, col] for col in 1:repetitions]
@pipe @benchmark(test($ref(random_list), $ref(repetitions))) |> push!(bench, _) 



@views function foo(x)
    a = x[1:2]
    b = x[2:3]

    sum(a .* b) * sum(x)    
end
random_list = [random_vector[:, col] for col in 1:repetitions]
@pipe @benchmark(test($ref(random_list), $ref(repetitions))) |> push!(bench, _) 


function foo(x)
    a = x[1:2]
    b = x[2:3]

    sum(a .* b) * sum(x)    
end
random_list   = [Tuple(random_vector[:, i]) for i in 1:repetitions]
@pipe @benchmark(test($ref(random_list), $ref(repetitions))) |> push!(bench, _) 


function foo(x)
    a = SVector{100,eltype(x)}(x[1:2])
    b = SVector{100,eltype(x)}(x[2:3])

    sum(a .* b) * sum(x)    
end
using StaticArrays
static_arrays(i) = SVector{nr_elements,eltype(random_vector[1,:])}(random_vector[:, i])
random_list      = [static_arrays(i) for i in 1:repetitions]
@pipe @benchmark(test($ref(random_list), $ref(repetitions))) |> push!(bench, _) 

push!(benchs, :sa2 => bench)


##############################################################################
#                                   STATIC ARRAYS 3
##############################################################################

using Random ; Random.seed!(123)        #Setting the seed for reproducibility
nr_elements   = 200
repetitions   = 10_000
random_vector = rand(nr_elements, repetitions)

function test(random_list, repetitions)
    for i in 1:repetitions
        x = random_list[i]
        foo(x)
    end    
end

bench = []

function foo(x)
    a = x[1:100]
    b = x[101:200]

    sum(a .* b) * sum(x)    
end
random_list = [random_vector[:, col] for col in 1:repetitions]
@pipe @benchmark(test($ref(random_list), $ref(repetitions))) |> push!(bench, _) 



@views function foo(x)
    a = x[1:100]
    b = x[101:200]

    sum(a .* b) * sum(x)    
end
random_list = [random_vector[:, col] for col in 1:repetitions]
@pipe @benchmark(test($ref(random_list), $ref(repetitions))) |> push!(bench, _) 


function foo(x)
    a = x[1:100]
    b = x[101:200]

    sum(a .* b) * sum(x)    
end
random_list   = [Tuple(random_vector[:, i]) for i in 1:repetitions]
@pipe @benchmark(test($ref(random_list), $ref(repetitions))) |> push!(bench, _) 


function foo(x)
    a = SVector{100,eltype(x)}(x[1:100])
    b = SVector{100,eltype(x)}(x[101:200])

    sum(a .* b) * sum(x)    
end
using StaticArrays
static_arrays(i) = SVector{nr_elements,eltype(random_vector[1,:])}(random_vector[:, i])
random_list      = [static_arrays(i) for i in 1:repetitions]
@pipe @benchmark(test($ref(random_list), $ref(repetitions))) |> push!(bench, _) 


push!(benchs, :sa3 => bench)


