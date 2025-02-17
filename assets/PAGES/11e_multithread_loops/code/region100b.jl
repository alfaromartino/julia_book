function compute(output, x, chunk)
    for j in chunk
        output[j] = log(x[j])
    end    
end

function foo(x, nrchunks)
    pieces = index_chunks(x, n=nrchunks)
    output = similar(x)
        
    @sync for chunk in pieces
        @spawn compute(output, x, chunk)        
    end
    
    return output
end
@ctime foo($x,nthreads())  # hide