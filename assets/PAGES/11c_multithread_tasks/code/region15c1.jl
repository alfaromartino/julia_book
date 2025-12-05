function foo(x)
    pieces = index_chunks(x, n=nthreads())
    outs   = Vector{Float64}(undef, length(pieces))
    
    @threads for (i,chunk) in enumerate(pieces)        
        outs[i] = sum(log, view(x, chunk))
    end
    
    sum(outs)
end
foo(x) #hide