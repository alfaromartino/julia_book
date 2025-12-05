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