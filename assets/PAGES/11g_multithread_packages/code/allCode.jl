include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Random, Base.Threads, ChunkSplitters, OhMyThreads, Polyester, LoopVectorization, FLoops
 
############################################################################
#
#			        SECTION: "MULTITHREADING PACKAGES"
#
############################################################################
 
############################################################################
#
#   PACKAGE `OHMYTHREADS`
#
############################################################################
 
####################################################
#	parallel mapping
####################################################
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x                       = rand(1_000_000)


foo(x)                  =  map(log, x)
foo_parallel1(x)        = tmap(log, x)
foo_parallel2(x)        = tmap(log, eltype(x), x)
 
@ctime foo($x)
 
@ctime foo_parallel1($x)
 
@ctime foo_parallel2($x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x                       = rand(1_000_000)
output                  = similar(x)

foo!(output,x)          =  map!(log, output, x)
foo_parallel!(output,x) = tmap!(log, output, x)
 
@ctime foo!($output, $x)
 
@ctime foo_parallel!($output, $x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# defining chunk size or number of chunks
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x      = rand(1_000_000)

foo(x) = tmap(log, eltype(x), x; nchunks = nthreads())
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x      = rand(1_000_000)

foo(x) = tmap(log, eltype(x), x; chunksize = length(x) ÷ nthreads())
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# REMARK: do-block syntax
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    
    output = tmap(a -> 2 * log(a), x)



    return output
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)    
    
    output = tmap(x) do a
                2 * log(a)
             end

    return output
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	array comprehensions
####################################################
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x                = rand(1_000_000)
output           = similar(x)

foo(x)           = [log(a) for a in x]
foo_parallel1(x) = tcollect(log(a) for a in x)
foo_parallel2(x) = tcollect(eltype(x), log(a) for a in x)
 
@ctime foo($x)
 
@ctime foo_parallel1($x)
 
@ctime foo_parallel2($x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	reductions and mapreduce
####################################################
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x               = rand(1_000_000)

foo(x)          =  reduce(+, x)
foo_parallel(x) = treduce(+, x)
 
@ctime foo($x)
 
@ctime foo_parallel($x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x               = rand(1_000_000)

foo(x)          =  mapreduce(log, +, x)
foo_parallel(x) = tmapreduce(log, +, x)
 
@ctime foo($x)
 
@ctime foo_parallel($x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	`foreach` as a faster option for mappings 
####################################################
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    foreach(i -> output[i] = log(x[i]), eachindex(x))
        
    

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    foreach(eachindex(x)) do i
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# comparing tmap and tforeach
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    tmap(eachindex(x)) do i
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    tmap(eltype(x), eachindex(x)) do i
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    tforeach(eachindex(x)) do i
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# chunks: control over work distribution
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    tforeach(eachindex(x); nchunks = nthreads()) do i
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    tforeach(eachindex(x); chunksize = length(x) ÷ nthreads()) do i
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# parallel for-loops (mutation)
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    @tasks for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    @tasks for i in eachindex(x)
        @set nchunks = nthreads()                   # number of tasks spawned equal to the number of threads
            output[i] = log(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    @tasks for i in eachindex(x)
        @set chunksize = length(x) ÷ nthreads()     # size that evenly distributes work
            output[i] = log(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
# parallel for-loops (reductions)
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0
    
    for i in eachindex(x)        
        output += log(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)    
    output = @tasks for i in eachindex(x)
                @set reducer = +
                    log(x[i])
             end
             

    return output
end
@ctime foo($x) #hide
 
############################################################################
#
#   POLYESTER: LIGHTER THREADS (FOR SMALL OBJECTS)
#
############################################################################
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(500)

function foo(x)
    output = similar(x)
    
    for i in eachindex(x)
        output[i] = log(x[i])
    end
    
    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(500)

function foo(x)
    output = similar(x)
    
    @threads for i in eachindex(x)
        output[i] = log(x[i])
    end
    
    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(500)

function foo(x)
    output = similar(x)
    
    @batch for i in eachindex(x)
        output[i] = log(x[i])
    end
    
    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	reductions
####################################################
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(250)

function foo(x)
    output = 0.0
    
    for i in eachindex(x)
        output += log(x[i])
    end
    
    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(250)

function foo(x)
    output = 0.0
    
    @batch reduction=( (+, output) ) for i in eachindex(x)
        output += log(x[i])
    end
    
    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# more than one reduction
 
Random.seed!(1234)       #setting seed for reproducibility #hide
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
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
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
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
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
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	local variables
####################################################
 
# it handles local variables correctly
 
function foo()
    out  = zeros(Int, 2)
    temp = 0

    for i in 1:2
        temp   = i; sleep(i)
        out[i] = temp
    end

    return out
end
print_asis(foo()) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo()
    out  = zeros(Int, 2)
    

    @threads for i in 1:2
        temp   = i; sleep(i)
        out[i] = temp
    end

    return out
end
print_asis(foo()) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo()
    out  = zeros(Int, 2)
    temp = 0

    @threads for i in 1:2
        temp   = i; sleep(i)
        out[i] = temp
    end

    return out
end
print_asis(foo()) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo()
    out  = zeros(Int, 2)
    temp = 0

    @batch for i in 1:2
        temp   = i; sleep(i)
        out[i] = temp
    end

    return out
end
print_asis(foo()) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#   SIMD + MULTITHREADING
#
############################################################################
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = BitVector(rand(Bool, 100_000))
y = rand(100_000)

function foo(x,y)
    output = similar(y)

    for i in eachindex(x)
        output[i] = ifelse(x[i], log(y[i]), y[i] * 2)
    end

    output
end
@ctime foo($x,$y)  #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = BitVector(rand(Bool, 100_000))
y = rand(100_000)

function foo(x,y)
    output = similar(y)

    @threads for i in eachindex(x)
        output[i] = ifelse(x[i], log(y[i]), y[i] * 2)
    end

    output
end
@ctime foo($x,$y)  #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = BitVector(rand(Bool, 100_000))
y = rand(100_000)

function foo(x,y)
    output = similar(y)

    @tturbo for i in eachindex(x)
        output[i] = ifelse(x[i], log(y[i]), y[i] * 2)
    end

    output
end
@ctime foo($x,$y)  #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# @tturbo for broadcasting
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x      = rand(1_000_000)

function foo(x)
    output = similar(x)

    @tturbo for i in eachindex(x)
        output[i] = log(x[i]) / x[i]
    end

    return output
end
@ctime foo($x)  #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x      = rand(1_000_000)

foo(x) = @tturbo log.(x) ./ x
@ctime foo($x)  #hide
 
############################################################################
#
#   FLOOPS
#
############################################################################
 
# independent for-loops
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    @floop for i in eachindex(x)
        output[i] = log(x[i])
    end
    
    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# reductions
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        output += log(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
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
@ctime foo($x)  #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0
    
    @floop for i in eachindex(x)
        @reduce output += log(x[i])
    end
    
    return output
end
@ctime foo($x) #hide
 
