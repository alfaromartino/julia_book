Random.seed!(1234) #hide
x = rand(1_000_000)

function foo(x)
    pieces = chunks(x, n=nthreads())
    outs   = map((chunk -> @spawn sum(log, chunk)), pieces)
    
    partial_sums = (fetch(a) for a in outs)
    
    sum(partial_sums)
end
foo(x) #hide