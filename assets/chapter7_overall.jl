
using DataFrames,BenchmarkTools, FLoops, LoopVectorization, FastBroadcast, Formatting, ThreadsX, Strided, Distributions, Random, Pipe, BrowseTables
using FoldsCUDA, CUDA, FLoops
browse(x) = open_html_table(x)


# to test a complex function 
foo(x,y) = x / y * 100 + (x^2 + y^2) / y + log(x) + y * exp(x)
#using Random ; Random.seed!(123)        #Setting the seed for reproducibility

##############################################################################
#                               OVERALL
##############################################################################
println("results overall")

#x = rand(10_000)
x = rand(100)
function test(x; final_output = similar(x))
    interm(x,i) = [x[i] + 2 * log(x[j])  for j in eachindex(x)]

    for i in eachindex(x)        
        final_output[i] = exp(x[i]) + sum(interm(x,i))
    end    
    return final_output
end
@btime test(x);
#443.508 ms (20002 allocations: 763.47 MiB) 



function test(x; final_output = similar(x))    
    interm(x,i) = x[i] .+ 2 .* log.(x)

    for i in eachindex(x)
        final_output[i]  = exp(x[i]) + sum(interm(x,i))
    end

    return final_output
end
@btime test(x);
#326.680 ms (4 allocations: 156.34 KiB)


function test(x; final_output = similar(x))    
    interm(x,i) = (x[i] + 2 * log(x[j])  for j in eachindex(x))

    for i in eachindex(x)    
        final_output[i] = exp(x[i]) + sum(interm(x,i))
    end    
    return final_output
end
@btime test(x);
#339.785 ms (2 allocations: 78.17 KiB)


function test(x; final_output = similar(x))    
    auxiliar(x,y) = (2 * log(x[j])  for j in eachindex(x))
    interm(y) = y + sum(auxiliar(x,y))

    @turbo @. final_output = exp(x) + sum(interm(x))
end
@btime test($x);
# 90.473 ms (2 allocations: 78.17 KiB)
 
##############################################################################
#                               THREADS
##############################################################################
#NOTICE YOU CAN'T USE `@threads` WITH INTERMEDIATE OUTPUT WITHOUT [I]
println("results threads")

function test(x; final_output = similar(x))    
    interm(x,i) = [x[i] + 2 * log(x[i])  for i in eachindex(x)]

    Threads.@threads for i in eachindex(x)
        final_output[i] = exp(x[i]) + sum(interm(x,i))
    end    
    return final_output
end
@btime test(x);
  # 262.006 ms (40102 allocations: 1.49 GiB)
  

  function test(x; final_output = similar(x))    
    interm(x,i) = (x[i] .+ 2 .* log.(x))

    Threads.@threads for i in eachindex(x)        
        final_output[i] = exp(x[i]) + sum(interm(x,i))
    end

    return final_output
end
@btime test(x);
# 363.481 ms (69081 allocations: 764.31 MiB)
  


function test(x; final_output = similar(x))    
    interm(x,i) = (x[i] + 2 * log(x[i])  for i in eachindex(x))

    Threads.@threads for i in eachindex(x)        
        final_output[i] = exp(x[i]) + sum(interm(x,i))
    end

    return final_output
end
@btime test(x);
# 41.357 ms (59080 allocations: 1.22 MiB)



function test(x; final_output = similar(x))    
    interm(x,i) = (x[i] + 2 * log(x[i])  for i in eachindex(x))

    Threads.@threads for i in eachindex(x)        
        final_output[i] = exp(x[i]) + sum(interm(x,i))
    end

    return final_output
end
@btime test(x);
# 41.432 ms (100 allocations: 88.62 KiB)
  

function test(x; final_output = similar(x))        
    interm(x,i) = (x[i] + 2 * log(x[i])  for i in eachindex(x))

    @tturbo for i in eachindex(x)
        final_output[i] = exp(x[i]) + sum(interm(x,i))
    end

    return final_output
end
@btime test(x);
# 20.319 ms (2 allocations: 78.17 KiB)


function main(x; final_output = similar(x))    
    interm(x) = sum(2 * log(x[j])  for j in eachindex(x))

    @. final_output = exp(x) + x + interm(x)
        
    return Array(final_output)
end
test(x) = main(CuArray{Float32, 1, CUDA.Mem.DeviceBuffer}(x))
@btime test(x);

#103.776 ms (20141 allocations: 4.51 MiB)




####################
### BEST
####################
display("best")
function test(x; final_output = similar(x))    
    interm(x) = sum(2 * log(x[j])  for j in eachindex(x))
    
    @tturbo @. final_output = exp(x) + x + interm(x)
end
@btime test($x);
# 90.473 ms (2 allocations: 78.17 KiB)

