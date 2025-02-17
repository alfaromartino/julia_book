Random.seed!(1234) #hide
x = rand(10_000)

function foo(x)
    @sync begin
        for i in eachindex(x)
            @spawn sum(@~ log.(x[1:i]))
        end
    end
end
foo(x); #hide
GC.gc() #hide