include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Random, Base.Threads, ChunkSplitters, OhMyThreads, LoopVectorization, Polyester, Folds, FLoops, LazyArrays, StrideArrays
 
############################################################################
#
#      EMBARRASSINGLY-PARALLEL PROBLEM
#
############################################################################
 
Random.seed!(1234) #hide
x_small  = rand(    1_000)
x_medium = rand(  100_000)
x_big    = rand(10_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end
 
@ctime foo($x_small)
 
@ctime foo($x_medium)
 
@ctime foo($x_big)
 
Random.seed!(1234) #hide
x_small  = rand(    1_000)
x_medium = rand(  100_000)
x_big    = rand(10_000_000)

function foo(x)
    output = similar(x)

    @threads for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end
 
@ctime foo($x_small)
 
@ctime foo($x_medium)
 
@ctime foo($x_big)
 
############################################################################
#
#      BETTER PARALLELIZING AT THE TOP
#
############################################################################
 
step1(a) = a ^ 2
step2(a) = sqrt(a)
step3(a) = log(a + 1)

function all_steps(a) 
   y      = step1(a)
   z      = step2(y)
   output = step3(z)

   return output
end

function foo(x)
   output = similar(x)

   for i in eachindex(output)
      output[i] = all_steps(x[i])
   end

   return output
end

Random.seed!(1234) #hide
x_small  = rand(  1_000)
x_large  = rand(100_000)
 
@ctime foo($x_small) #hide
 
@ctime foo($x_large) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
step1(a) = a ^ 2
step2(a) = sqrt(a)
step3(a) = log(a + 1)

function all_steps(a) 
   y      = step1(a)
   z      = step2(y)
   output = step3(z)

   return output
end

function foo(x)
   output = similar(x)

   @threads for i in eachindex(output)
      output[i] = all_steps(x[i])
   end

   return output
end

Random.seed!(1234) #hide
x_small  = rand(  1_000)
x_large  = rand(100_000)
 
@ctime foo($x_small) #hide
 
@ctime foo($x_large) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
step1(a) = a ^ 2
step2(a) = sqrt(a)
step3(a) = log(a + 1)

function parallel_step(f, x)
   output = similar(x)

   @threads for i in eachindex(output)      
      output[i] = f(x[i])
   end

   return output
end

function foo(x)
   y      = parallel_step(step1, x)
   z      = parallel_step(step2, y)
   output = parallel_step(step3, z)
   
   return output
end

Random.seed!(1234) #hide
x_small  = rand(  1_000)
x_large  = rand(100_000)
 
@ctime foo($x_small) #hide
 
@ctime foo($x_large) #hide
 
############################################################################
#
#			@spawn vs @threads
#
############################################################################
 
####################################################
#	example with real operations
####################################################
 
# same time per iteration
 
Random.seed!(1234) #hide
x = rand(10_000)

function foo(x)
    output = similar(x)

    @threads for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end
foo(x); #hide
 
@ctime foo($x) #hide
 
Random.seed!(1234) #hide
x = rand(10_000)

function foo(x)
    output = similar(x)    
    
    @sync for i in eachindex(x)
        @spawn output[i] = log(x[i])
    end
    
    return output
end
foo(x); #hide
 
@ctime foo($x) #hide
 
# increasing time per iteration
 
Random.seed!(1234) #hide
x = rand(10_000)

function foo(x)
    output = similar(x)

    @threads for i in eachindex(x)
        output[i] = sum(@~ log.(x[1:i]))
    end

    return output
end
foo(x); #hide
 
@ctime foo($x) #hide
 
Random.seed!(1234) #hide
x = rand(10_000)

function foo(x)
    output = similar(x)

    @sync for i in eachindex(x)
        @spawn output[i] = sum(@~ log.(x[1:i]))
    end

    return output
end
foo(x); #hide
 
@ctime foo($x) #hide
 
############################################################################
#
#			CHUNK SPLITTERS
#
############################################################################
 
# chunks creation -> by setting the number of subsets
 
x             = string.('a':'z')            # all letters from "a" to "z"

nr_chunks     = 5

chunk_indices = index_chunks(x, n = nr_chunks)
chunk_values  = chunks(x, n = nr_chunks)
 
print_asis(collect(chunk_indices))
 
print_asis(collect(chunk_values))
 
# chunks creation -> by setting the size of the subsets
 
x             = string.('a':'z')            # all letters from "a" to "z"

chunk_length  = 10

chunk_indices = index_chunks(x, size = chunk_length)
chunk_values  = chunks(x, size = chunk_length)
 
print_asis(collect(chunk_indices))
 
print_asis(collect(chunk_values))
 
####################################################
#	common way to split chunks for multithreading
####################################################
 
x             = string.('a':'z')            # all letters from "a" to "z"

nr_chunks     = nthreads()

chunk_indices = index_chunks(x, n = nr_chunks)
chunk_values  = chunks(x, n = nr_chunks)

chunk_iter    = enumerate(chunk_indices)    # pairs (i_chunk, chunk_index)
 
print_asis(collect(chunk_indices))
 
print_asis(collect(chunk_values))
 
print_asis(collect(chunk_iter))
 
############################################################################
#
#			CHUNKS
#
############################################################################
 
####################################################
#	implementation of @threads by using @spawn + chunks
####################################################
 
Random.seed!(1234) #hide
x = rand(10_000_000)

function foo(x)
    output = similar(x)
    
    @threads for i in eachindex(x)
        output[i] = log(x[i])
    end
    
    return output
end
@ctime foo($x) #hide
 
Random.seed!(1234) #hide
x = rand(10_000_000)

function foo(x)
    output = similar(x)
    
    @sync for i in eachindex(x)
        @spawn output[i] = log(x[i])
    end
    
    return output
end
@ctime foo($x) #hide
 
Random.seed!(1234) #hide
x = rand(10_000_000)

function foo(x, nr_chunks)
    chunk_ranges = index_chunks(x, n=nr_chunks)
    output       = similar(x)

    @sync for chunk in chunk_ranges
        @spawn (@views @. output[chunk] = log(x[chunk]))
    end

    return output
end
@ctime foo($x, nthreads())  # hide
 
Random.seed!(1234) #hide
x = rand(10_000_000)

function foo(x)
    output = similar(x)
    
    @threads for i in eachindex(x)
        output[i] = log(x[i])
    end
    
    return output
end
@ctime foo($x) #hide
 
Random.seed!(1234) #hide
x = rand(10_000_000)

function foo(x, nr_chunks)
    chunk_ranges = index_chunks(x, n=nr_chunks)
    output       = similar(x)
    task_indices = Vector{Task}(undef, nr_chunks)

    for (i, chunk) in enumerate(chunk_ranges)
        task_indices[i] = @spawn (@views @. output[chunk] = log(x[chunk]))
    end

    return wait.(task_indices)
end
@ctime foo($x, nthreads())  # hide
 
Random.seed!(1234) #hide
x = rand(10_000_000)

function foo(x, nr_chunks)
    chunk_ranges = index_chunks(x, n=nr_chunks)
    output       = similar(x)

    @sync for chunk in chunk_ranges
        @spawn (@views @. output[chunk] = log(x[chunk]))
    end

    return output
end
 
@ctime foo($x, nthreads() * 1)  # hide
 
@ctime foo($x, nthreads() * 2)  # hide
 
@ctime foo($x, nthreads() * 4)  # hide
 
Random.seed!(1234) #hide
x = rand(10_000_000)

function compute!(output, x, chunk)
     @turbo for j in chunk 
        output[j] = log(x[j])
     end
end

function foo(x, nr_chunks)
    chunk_ranges = index_chunks(x, n=nr_chunks)
    output       = similar(x)

    @sync for chunk in chunk_ranges
        @spawn compute!(output, x, chunk)
    end

    return output
end
 
@ctime foo($x, nthreads() * 1)  # hide
 
@ctime foo($x, nthreads() * 2)  # hide
 
@ctime foo($x, nthreads() * 4)  # hide
 
####################################################
#	REDUCTIONS
####################################################
 
Random.seed!(1234) #hide
x = rand(10_000_000)

function foo(x)
    output = 0.

    for i in eachindex(x)
        output += x[i]
    end

    output
end
print_asis(foo(x)) #hide
 
@ctime foo($x)
 
Random.seed!(1234) #hide
x = rand(10_000_000)

function foo(x)
    chunk_ranges    = index_chunks(x, n=nthreads())
    partial_outputs = Vector{Float64}(undef, length(chunk_ranges))
    
    @threads for (i,chunk) in enumerate(chunk_ranges)
        partial_outputs[i] = sum(@view(x[chunk]))
    end
    
    return sum(partial_outputs)
end
print_asis(foo(x)) #hide
 
@ctime foo($x)
 
Random.seed!(1234) #hide
x = rand(10_000_000)

function foo(x)
    chunk_ranges    = index_chunks(x, n=nthreads())
    partial_outputs = Vector{Float64}(undef, length(chunk_ranges))
         
    @sync for (i, chunk) in enumerate(chunk_ranges)
        @spawn partial_outputs[i] = sum(@view(x[chunk]))
    end
        
    return sum(partial_outputs)
end
print_asis(foo(x)) #hide
 
@ctime foo($x)
 
############################################################################
#
#			FALSE SHARING
#
############################################################################
 
Random.seed!(1234) # hide
x = rand(10_000_000)

function foo(x)
    output = 0.

    for i in eachindex(x)
        output += log(x[i])
    end

    output
end
@ctime foo($x)  # hide
 
Random.seed!(1234) # hide
x = rand(10_000_000)

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
 
Random.seed!(1234) # hide
x = rand(10_000_000)

function foo(x)
    chunk_ranges    = index_chunks(x, n=nthreads())
    partial_outputs = zeros(length(chunk_ranges))
    
    @threads for (i,chunk) in enumerate(chunk_ranges)
        temp = 0.0
        for j in chunk
            temp += log(x[j])
        end
        partial_outputs[i] = temp
    end
    
    return sum(partial_outputs)
end
@ctime foo($x)  # hide
 
Random.seed!(1234) # hide
x = rand(10_000_000)

function foo(x)
    chunk_ranges    = index_chunks(x, n=nthreads())
    partial_outputs = zeros(length(chunk_ranges))    
    
    @sync for (i,chunk) in enumerate(chunk_ranges)
        @spawn begin
            temp = 0.0
            for j in chunk
                temp += log(x[j])
            end
            partial_outputs[i] = temp
        end
    end
    
    return sum(partial_outputs)
end
@ctime foo($x)  # hide
 
Random.seed!(1234) # hide
x = rand(10_000_000)

function compute(x, chunk)
    temp = 0.0

    for j in chunk
        temp += log(x[j])
    end
    
    return temp
end

function foo(x)
    chunk_ranges    = index_chunks(x, n=nthreads())
    partial_outputs = zeros(length(chunk_ranges))    
    
    @threads for (i,chunk) in enumerate(chunk_ranges)
        partial_outputs[i] = compute(x, chunk)
    end
    
    return sum(partial_outputs)
end
@ctime foo($x)  # hide
 
Random.seed!(1234) # hide
x = rand(10_000_000)

function foo(x)
    chunk_ranges     = index_chunks(x, n=nthreads())    
    partial_outputs  = zeros(7, length(chunk_ranges))    
        
    @threads for (i,chunk) in enumerate(chunk_ranges)
        for j in chunk 
            partial_outputs[1,i] += log(x[j])
        end
    end
    
    return sum(@view(partial_outputs[:,1]))
end
@ctime foo($x)  # hide
 
