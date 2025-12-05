Random.seed!(1234) #hide
x = rand(10_000)

function foo(x)
    @sync begin
        for i in eachindex(x)
            @spawn log(x[i])
        end
    end
end
foo(x); #hide
GC.gc() #hide