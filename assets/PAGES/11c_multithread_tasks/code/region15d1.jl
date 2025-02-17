function foo(x)
    pieces = index_chunks(x, n=nthreads())
    outs   = Vector{Float64}(undef, length(pieces))
    
    @sync begin
        for (i,chunk) in enumerate(pieces)        
            @spawn outs[i] = sum(log, view(x, chunk))
        end
    end
    
    sum(outs)
end
foo(x) #hide