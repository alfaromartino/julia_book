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
using Random, Base.Threads, OhMyThreads, Folds, FLoops, LoopVectorization, Polyester, ChunkSplitters, ThreadsX
 
############################################################################
#
#      OH MY THREADS
#
############################################################################
 
####################################################
#	basic functions
####################################################
 
Random.seed!(1234)
x                       = rand(1_000_000)


foo(x)                  =  map(log, x)
foo_parallel1(x)        = tmap(log, x)
foo_parallel2(x)        = tmap(log, eltype(x), x)
 
@ctime foo($x)
 
@ctime foo_parallel1($x)
 
@ctime foo_parallel2($x)
 


Random.seed!(1234)
x                       = rand(1_000_000)
output                  = similar(x)

foo!(output,x)          =  map!(log, output, x)
foo_parallel!(output,x) = tmap!(log, output, x)
 
@ctime foo!($output, $x)
 
@ctime foo_parallel!($output, $x)
 


# do-syntax
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)    
    
    output = tmap(x) do a
                2 * log(a)
             end

    return output
end
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    
    output = tmap(a -> 2 * log(a), x)



    return output
end
 


# defining chunk size or number of chunks
 
Random.seed!(1234)
x      = rand(1_000_000)

foo(x) = tmap(log, eltype(x), x; nchunks = nthreads())
@ctime foo($x)
 
Random.seed!(1234)
x      = rand(1_000_000)

foo(x) = tmap(log, eltype(x), x; chunksize = length(x) ÷ nthreads())
@ctime foo($x)
 


# array comprehensions
 
Random.seed!(1234)
x                = rand(1_000_000)
output           = similar(x)

foo(x)           = [log(a) for a in x]
foo_parallel1(x) = tcollect(log(a) for a in x)
foo_parallel2(x) = tcollect(eltype(x), log(a) for a in x)
 
@ctime foo($x)
 
@ctime foo_parallel1($x)
 
@ctime foo_parallel2($x)
 
####################################################
#	reductions and mapreduce
####################################################
 


Random.seed!(1234)
x               = rand(1_000_000)

foo(x)          =  reduce(+, x)
foo_parallel(x) = treduce(+, x)
 
@ctime foo($x)
 
@ctime foo_parallel($x)
 


Random.seed!(1234)
x               = rand(1_000_000)

foo(x)          =  mapreduce(log, +, x)
foo_parallel(x) = tmapreduce(log, +, x)
 
@ctime foo($x)
 
@ctime foo_parallel($x)
 
####################################################
#	alternative to for-loops
####################################################
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    foreach(i -> output[i] = log(x[i]), eachindex(x))
        
    

    return output
end
@ctime foo($x)
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    foreach(eachindex(x)) do i
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x)
 
# multithreaded
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    tmap(eachindex(x)) do i
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    tmap(eltype(x), eachindex(x)) do i
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    tforeach(eachindex(x)) do i
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x)
 


# control over work distribution
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    tforeach(eachindex(x); nchunks = nthreads()) do i
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    tforeach(eachindex(x); chunksize = length(x) ÷ nthreads()) do i
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x)
 
# independent for-loops
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    @floop for i in eachindex(x)
        output[i] = log(x[i])
    end
    
    return output
end
@ctime foo($x)
 


# reductions
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        output += log(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(1234) # hide
x = rand(1_000_000)

function foo(x)
    chunk_ranges    = index_chunks(x, n=nthreads())
    partial_outputs = zeros(length(chunk_ranges))
    
    @threads for (i,chunk) in enumerate(chunk_ranges)
        for j in chunk
            partial_outputs[i] += log(x[j])
        end
    end
    
    return sum(partial_outputs)
end
@ctime foo($x)  # hide
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    output = 0.0
    
    @floop for i in eachindex(x)
        @reduce output += log(x[i])
    end
    
    return output
end
@ctime foo($x)
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    output = 0.0        # any value, to initialize `output`
    
    @floop for i in eachindex(x)
        @reduce output  = +(0.0, log(x[i]))     # 0.0 is the initial value of `output`
    end
    
    return output
end
@ctime foo($x)
 


# multiple reductions
 
Random.seed!(1234)
x = rand(1_000_000)

function foo(x)
    output1 = 1.0
    output2 = 0.0
    
    for i in eachindex(x)
        output1 *= log(x[i])
        output2 += exp(x[i])
    end
    
    return output1, output2
end
@ctime foo($x)
 
Random.seed!(1234) # hide
x = rand(1_000_000)

function foo(x)
    output1 = 1.0
    output2 = 0.0
    
    @floop for i in eachindex(x)
        @reduce output1 *= log(x[i])
        @reduce output2 += exp(x[i])
    end
    
    return output1, output2
end
@ctime foo($x)  # hide
 
# multiple reductions
 
Random.seed!(1234)
x = rand(1_000)

function foo(x)
    output1 = 1.0
    output2 = 0.0
    
    for i in eachindex(x)
        output1 *= log(x[i])
        output2 += log(x[i])
    end
    
    return output1, output2
end
@ctime foo($x)
 
Random.seed!(1234) # hide
x = rand(1_000)

function foo(x)
    output1 = 1.0
    output2 = 0.0
    
    @floop for i in eachindex(x)
        @reduce output1 *= log(x[i])
        @reduce output2 += log(x[i])
    end
    
    return output1, output2
end
@ctime foo($x)  # hide
 
Random.seed!(1234) # hide
x = rand(1_000)

function foo(x)
    output1 = 0.0
    output2 = 0.0

    @floop for a in eachindex(x)

        @reduce() do (output1; a)
            output1 *= log(a)
        end

        @reduce() do (output2; a)
            output2 += log(a)
        end

    end        
    
    return output1, output2
end
@ctime foo($x)  # hide
 
############################################################################
#
#			LIGHTER THREADS (FOR SMALL OBJECTS)
#
############################################################################
 
Random.seed!(1234)
x = rand(500)

function foo(x)
    output = similar(x)
    
    for i in eachindex(x)
        output[i] = log(x[i])
    end
    
    return output
end
@ctime foo($x)
 
Random.seed!(1234)
x = rand(500)

function foo(x)
    output = similar(x)
    
    @threads for i in eachindex(x)
        output[i] = log(x[i])
    end
    
    return output
end
@ctime foo($x)
 
Random.seed!(1234)
x = rand(500)

function foo(x)
    output = similar(x)
    
    @batch for i in eachindex(x)
        output[i] = log(x[i])
    end
    
    return output
end
@ctime foo($x)
 


# for reductions
 
Random.seed!(1234)
x = rand(250)

function foo(x)
    output = 0.0
    
    for i in eachindex(x)
        output += log(x[i])
    end
    
    return output
end
@ctime foo($x)
 
Random.seed!(1234)
x = rand(250)

function foo(x)
    output = 0.0
    
    @batch reduction=( (+, output) ) for i in eachindex(x)
        output += log(x[i])
    end
    
    return output
end
@ctime foo($x)
 


Random.seed!(1234)
x = rand(250)

function foo(x)
    output1 = 1.0
    output2 = 0.0
    
    for i in eachindex(x)
        output1 *= log(x[i])
        output2 += exp(x[i])
    end
    
    return output1, output2
end
@ctime foo($x)
 
Random.seed!(1234)
x = rand(250)

function foo(x)
    output1 = 1.0
    output2 = 0.0
    
    @batch reduction=( (*, output1), (+, output2) ) for i in eachindex(x)
        output1 *= log(x[i])
        output2 += exp(x[i])
    end
    
    return output1, output2
end
@ctime foo($x)
 
Random.seed!(1234)
x = rand(250)

function foo(x)
    output1 = 1.0
    output2 = 0.0
    
    @batch reduction=( (*, output1), (+, output2) ) for i in eachindex(x)
        output1  = output1 * log(x[i])
        output2  = output2 + exp(x[i])
    end
    
    return output1, output2
end
@ctime foo($x)
 
# it handles correctly local variables
 
function foo()
    out  = zeros(Int, 2)
    temp = 0

    for i in 1:2
        temp   = i; sleep(i)
        out[i] = temp
    end

    return out
end
foo()
 
function foo()
    out  = zeros(Int, 2)
    

    @threads for i in 1:2
        temp   = i; sleep(i)
        out[i] = temp
    end

    return out
end
foo()
 
function foo()
    out  = zeros(Int, 2)
    temp = 0

    @threads for i in 1:2
        temp   = i; sleep(i)
        out[i] = temp
    end

    return out
end
foo()
 
function foo()
    out  = zeros(Int, 2)
    temp = 0

    @batch for i in 1:2
        temp   = i; sleep(i)
        out[i] = temp
    end

    return out
end
foo()
 


############################################################################
#
#			SIMD + THREADS
#
############################################################################
 
Random.seed!(1234) # hide
x = BitVector(rand(Bool, 100_000))

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = !(x[i])
    end

    output
end
@ctime foo($x)  # hide
 
Random.seed!(1234) # hide
x = BitVector(rand(Bool, 100_000))

function foo(x)
    output = similar(x)

    @threads for i in eachindex(x)
        output[i] = !(x[i])
    end

    output
end
@ctime foo($x)  # hide
 
Random.seed!(1234) # hide
x = BitVector(rand(Bool, 100_000))

function foo(x)
    output = similar(x)

    @tturbo for i in eachindex(x)
        output[i] = !(x[i])
    end

    output
end
@ctime foo($x)  # hide
 


Random.seed!(1234) # hide
x = BitVector(rand(Bool, 100_000))
y = rand(100_000)

function foo(x,y)
    output = similar(y)

    for i in eachindex(x)
        output[i] = ifelse(x[i], log(y[i]), y[i] * 2)
    end

    output
end
@ctime foo($x,$y)  # hide
 
Random.seed!(1234) # hide
x = BitVector(rand(Bool, 100_000))
y = rand(100_000)

function foo(x,y)
    output = similar(y)

    @threads for i in eachindex(x)
        output[i] = ifelse(x[i], log(y[i]), y[i] * 2)
    end

    output
end
@ctime foo($x,$y)  # hide
 
Random.seed!(1234) # hide
x = BitVector(rand(Bool, 100_000))
y = rand(100_000)

function foo(x,y)
    output = similar(y)

    @tturbo for i in eachindex(x)
        output[i] = ifelse(x[i], log(y[i]), y[i] * 2)
    end

    output
end
@ctime foo($x,$y)  # hide
 


Random.seed!(1234) # hide
x      = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = log(x[i]) / x[i]
    end

    return output
end
@ctime foo($x)  # hide
 
Random.seed!(1234) # hide
x      = rand(1_000_000)

function foo(x)
    output = similar(x)

    @tturbo for i in eachindex(x)
        output[i] = log(x[i]) / x[i]
    end

    return output
end
@ctime foo($x)  # hide
 
Random.seed!(1234) # hide
x      = rand(1_000_000)

foo(x) = @tturbo log.(x) ./ x
@ctime foo($x)  # hide
 
