
using DataFrames, BenchmarkTools, LoopVectorization, FastBroadcast, Formatting, LazyArrays, Distributions, Random, Pipe, BrowseTables
#using FoldsCUDA, CUDA, FLoops, ThreadsX,
browse(x) = open_html_table(x)

# for benchmarking
ref(x) = (Ref(x))[]

# to test a complex function 
foo(x, y) = x / y * 100 + (x^2 + y^2) / y + log(x) + y * exp(x)

# some testing data for `x` and `y`
using Random ; Random.seed!(123)        #Setting the seed for reproducibility
x = rand(100); y = rand(100)

##############################################################################
# PRE-ALLOCATING INTERMEDIATE OUTPUT
##############################################################################

println("no preallocation")

# NO PREALLOCATING INTERMEDIATES

baseline(x, y) = [sum(x .* y) for i in eachindex(x)]
@btime baseline(x,y);
#6.150 μs (101 allocations: 88.38 KiB)
  

function baseline(x, y)
    output = similar(x)

    for i in eachindex(x)
        temp      = x .* y
        output[i] = x[i] + sum(temp)
    end
    return output
end
@btime baseline($ref(x), $ref(y));
#6.420 μs (101 allocations: 88.38 KiB)


println("preallocating")
# PRE-ALLOCATING INTERMEDIATE OUTPUTS
function prealloc_temp(x, y)
    output = similar(x)
    temp   = similar(x)

    for i in eachindex(x)
        temp     .= x .* y
        output[i] = x[i] + sum(temp)
    end
    return output
end
@btime prealloc_temp($ref(x), $ref(y));
#1.510 μs (2 allocations: 1.75 KiB)




function prealloc_temp(x, y; output=similar(x), temp=similar(x))
    for i in eachindex(x)
        @. temp      = x * y
           output[i] = x[i] + sum(temp)
    end
    return output
end
@btime prealloc_temp($ref(x), $ref(y));
#1.530 μs (2 allocations: 1.75 KiB)


##############################################################################
#                           GENERATORS
##############################################################################
println("generators")
println("baselines")

case_studied(x, y) = [x[i] + sum(x .* y) for i in eachindex(x)]
@btime case_studied($ref(x), $ref(y));


function new_baseline(x,y)
    vector = x .* y                            # 1 allocation
    temp   = sum(vector)

    [x[i] + temp for i in eachindex(x)]        # 1 allocation
end
@btime new_baseline($ref(x), $ref(y));
#6.625 μs (101 allocations: 88.38 KiB)


function new_baseline(x)
    temp = sum(x .* y)                          # 1 allocation, from `x .* y`

    [x[i] + sum(temp) for i in eachindex(x)]    # 1 allocation
end
#149.747 ns (2 allocations: 1.75 KiB)


function new_baseline(x, y; output=similar(x))
    temp = x .* y

    for i in eachindex(x)        
        output[i] = x[i] + sum(temp)
    end

    return output
end



function repeat(x, y)    
    for _ in 1:1_000_000
        new_baseline(x,y)
    end
end
@btime repeat($ref(x), $ref(y));
# 894.909 ms (2_000_000 allocations: 1.67 GiB)


#### GENERATOR
println("using_gen")
function using_gen(x,y)
    generator = (x[i] * y[i] for i in eachindex(x))
    temp      = sum(generator)

    [x[i] + temp for i in eachindex(x)]
end
@btime using_gen($ref(x), $ref(y));
#103.284 ns (1 allocation: 896 bytes)


function using_gen(x,y)
    temp = sum(x[i] * y[i] for i in eachindex(x))
    [x[i] + temp for i in eachindex(x)]
end
@btime using_gen($ref(x), $ref(y));
#100.646 ns (1 allocation: 896 bytes)

#=
repeat(x) = [baseline(x) for _ in 1:1_000_000]
@benchmark repeat(x)
repeat(x) = [using_gen(x) for _ in 1:1_000_000]
@benchmark repeat(x)
=#


##############################################################################
#                               COMPARISONS
##############################################################################
function lazy(x,y)
    tempo = sum(@~ x .* y)
    tempo .- x 
end
@btime lazy($ref(x), $ref(y));

function lazy(x,y)
    tempo = sum(@~ x .* y)
    LazyArray(@~ tempo .- x)    
end
@btime lazy($ref(x), $ref(y));



##############################################################################
#                               COMPARISONS
##############################################################################

foo(x) = sum(x^2) / x + log(x^2) + x * sum(x * exp(x))

function baseline(x)
    tempo = sum(foo.(x))                     # 1 allocation, from `foo.(x)`
    [tempo - x[i] for i in eachindex(x)]     # 1 allocation, from [...]`
end


function using_gen(x)
    gen = sum(foo(x[i]) for i in eachindex(x))
    [gen - x[i] for i in eachindex(x)]
end

function lazy(x)
    tempo = sum(@~ foo.(x))
    tempo .- x 
end

function lazy2(x)
    tempo = sum(@~ foo.(x))
    LazyArray(@~ tempo .- x)    
end

function lazy3(x)
    tempo = sum(@turbo @. foo(x))
    LazyArray(@~ tempo .- x)    
end


function repeat(foo,x)
    g = foo
    [g(x) for _ in 1:1_000_000]
end

println("comparison with lazy")
@btime repeat($baseline,$ref(x));
@btime repeat($using_gen,$ref(x));
@btime repeat($lazy,$ref(x));
@btime repeat($lazy2,$ref(x));
@btime repeat($lazy3,$ref(x));


# 895.790 ms (2_000_000 allocations: 1.67 GiB)
# 741.926 ms (1_000_000 allocations: 854.49 MiB)
# 753.931 ms (1_000_000 allocations: 854.49 MiB)
# 603.761 ms (1_000_000 allocations: 30.52 MiB)
# 393.649 ms (2_000_000 allocations: 885.01 MiB)




################ WITH THREADS

function repeat(foo,x)
    g = foo
   Threads.@threads for _ in 1:1_000_000
        g(x)    
    end
end


@btime repeat($baseline,$ref(x));
@btime repeat($using_gen,$ref(x));
@btime repeat($lazy,$ref(x));
@btime repeat($lazy2,$ref(x));
@btime repeat($lazy3,$ref(x));

1.099 s (2000098 allocations: 1.67 GiB)
  190.153 ms (1000097 allocations: 854.50 MiB)
  192.911 ms (1000099 allocations: 854.50 MiB)
  64.028 ms (97 allocations: 10.42 KiB)







#=
##############################################################################
# PRE-ALLOCATING INTERMEDIATE OUTPUT                        ANNEX
##############################################################################


foo(x_i, y) = x_i / y

x = rand(100_000)
y = rand(100)

# NO ALLOCATING INTERMEDIATES
function baseline(x, y)
    output = similar(x)

    for i in eachindex(x)
        temp      = foo.(x[i], y)
        output[i] = sum(temp)
    end
    return output
end
@btime baseline(x, y);


baseline(x, y) = [sum(foo.(x[i], y)) for i in eachindex(x)]
@btime baseline(x, y);


# PRE-ALLOCATING INTERMEDIATE OUTPUTS
function pre_alloc_temp(x, y)
    output = similar(x)
    temp = similar(y)

    for i in eachindex(x)
        temp .= foo.(x[i], y)
        output[i] = sum(temp)
    end
    return output
end
@btime pre_alloc_temp(x, y);



function pre_alloc_temp(x, y; output=similar(x), temp=similar(y))
    for i in eachindex(x)
        @. temp = foo(x[i], y)
        output[i] = sum(temp)
    end
    return output
end
@btime pre_alloc_temp(x, y);



temp(var_x, y, temp_vector) = (temp_vector .= foo.(var_x, y))
baseline(x, y; temp_vector) = [sum(temp(x[i], y, temp_vector)) for i in eachindex(x)]

@btime baseline(x, y, temp_vector=similar(y));


##############################################################################
# GENERATORS                        ANNEX
##############################################################################


############# fixing the previous code
temp(var_x, y, temp_vector) = (temp_vector .= foo.(var_x, y))
baseline(x, y; temp_vector) = [sum(temp(x[i], y, temp_vector)) for i in eachindex(x)]

@btime baseline(x, y, temp_vector=similar(y));


temp(var_x, y) = (foo(var_x, y[j]) for j in eachindex(y))
baseline(x, y) = [sum(temp(x[i], y)) for i in eachindex(x)]
@btime baseline(x, y);
=#