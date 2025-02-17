Random.seed!(1234) #hide
x = rand(10_000)

function foo(x)
    @threads for i in eachindex(x)
        sum(@~ log.(x[1:i]))
    end
end
foo(x); #hide
GC.gc() #hide