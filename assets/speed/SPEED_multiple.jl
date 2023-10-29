
using DataFrames,BenchmarkTools, FLoops, LoopVectorization, FastBroadcast, Formatting, Pipe
list1 = randn(50_000_000)
list2 = randn(50_000_000)

function miliseconds(benchmark_result, digits) 
    printx(x,N) = sprintf1("%.$(N)f",x)

    a = benchmark_result * 1e3  # to translate into miliseconds (ms)    
    a = parse(Float64,printx(a, digits))  # round to 3 digits
end


#INITIALIZE DATAFRAME FOR STORING RESULTS
dff = DataFrame(time = Float64[], case = String[])


##############################################################################
#                                   STANDARD LOOPS
##############################################################################
function foo(x,y)
    h,z = (similar(x) for _ = 1:2)
       for i in eachindex(x)
           h[i] = x[i] + y[i]
           z[i] = x[i] * y[i] + 1 - y[i] 
       end
    return h,z
end
push!(dff.time, @belapsed(foo(list1,list2)))
push!(dff.case, "standard")


#less verbose
function foo(array1,array2)
    h,z = (similar(array1) for _ = 1:2)
       for (i, x, y) in zip(eachindex(array1),array1, array2) 
           h[i] = x + y
           z[i] = x * y + 1 - y 
       end
    return h,z
end
push!(dff.time, @belapsed(foo(list1,list2)))
push!(dff.case, "less verbose")




##############################################################################
#                              THREADED LOOPS (FLOOPS)
##############################################################################
function foo(array1,array2)
    h,z = (similar(array1) for _ = 1:2)
    @floop for (i, x, y) in zip(eachindex(array1),array1, array2) 
        h[i] = x + y
        z[i] = x * y + 1 - y 
           end
    return h,z
end
push!(dff.time, @belapsed(foo(list1,list2)))
push!(dff.case, "floop (threaded)")



##############################################################################
#                                   BROADCASTED
##############################################################################
function foo(x,y)
    h,z = (similar(x) for _ = 1:2)    
        @. h = x + y
        @. z = x * y + 1 - y
    return h,z
end
push!(dff.time, @belapsed(foo(list1,list2)))
push!(dff.case, "broadcast standard")



function foo(x,y)
    h,z = (similar(x) for _ = 1:2)    
        @turbo @. h = x + y
        @turbo @. z = x * y + 1 - y
    return h,z
end
push!(dff.time, @belapsed(foo(list1,list2)))
push!(dff.case, "broadcast @turbo")



function foo(x,y)
    h,z = (similar(x) for _ = 1:2)    
        @.. h = x + y
        @.. z = x * y + 1 - y
end
push!(dff.time, @belapsed(foo(list1,list2)))
push!(dff.case, "broadcast FastBroadcast")


##############################################################################
#                        BROADCASTED + THREADED (TTURBO)
##############################################################################
function foo(x,y)
    h,z = (similar(x) for _ = 1:2)    
        @tturbo @. h = x + y
        @tturbo @. z = x * y + 1 - y
end
push!(dff.time, @belapsed(foo(list1,list2)))
push!(dff.case, "broadcast + threaded (tturbo)")