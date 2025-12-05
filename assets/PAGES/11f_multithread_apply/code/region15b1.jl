Random.seed!(1234) #hide
x = rand(10_000_000)

function foo(x)
    chunk_ranges    = chunks(x, n=nthreads())
    partial_outputs = map((chunk -> @spawn sum(chunk)), chunk_ranges)
    
    partial_sums    = (fetch(a) for a in partial_outputs)
    
    sum(partial_sums)
end
print_asis(foo(x)) #hide