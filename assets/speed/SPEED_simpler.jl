
using DataFrames,BenchmarkTools, FLoops, LoopVectorization, FastBroadcast, Formatting, ThreadsX, Strided
nr_items = 100_000
list1 = rand(nr_items) .* 100
list2 = rand(nr_items) .* 100

#OPERATION
foo(x,y) = 100 + x * y + log(x) * 2 / y


#INITIALIZE DATAFRAME FOR STORING RESULTS
dff = DataFrame(seconds = Float64[], case = String[])

function store_result!(dff, case_name)
    push!(dff.seconds, @belapsed(test(list1,list2)))
    push!(dff.case, case_name)
end


##############################################################################
#                                   STANDARD LOOPS
##############################################################################

function test(x, y)
    output = similar(x)
        for i in eachindex(x)
            output[i] = foo(x[i], y[i])
        end
    
    return output
end
store_result!(dff, "standard")


#less verbose
function test(list1,list2)
    output = similar(list1)
    for (i, x, y) in zip(eachindex(list1),list1, list2) 
            output[i] = foo(x, y)
    end

    return output
end
store_result!(dff, "standard (less verbose)")


#comprehension
test(list1,list2) = [foo(x,y) for (x,y) in zip(list1,list2)]

store_result!(dff, "comprehension")




##############################################################################
#                              THREADED LOOPS (FLOOPS)
##############################################################################
function test(list1,list2)
    output = similar(list1)
    @floop for i in eachindex(list1)
        output[i] = foo(list1[i], list2[i])
        end

    return output
end
store_result!(dff, "@floop (threaded)")


##############################################################################
#                                   BROADCASTED
##############################################################################
function test(list1,list2)    
    output = foo.(list1,list2)  # equivalent to `output .= foo.(list1,list2)`
        
    return output
end
store_result!(dff, "broadcast no-inline")



function test(list1,list2)
    output = similar(list1)
    @. output = foo(list1,list2)  # equivalent to `output .= foo.(list1,list2)`
        
    return output
end
store_result!(dff, "broadcast inline")



function test(list1,list2)
    output = similar(list1)         # `@turbo`` requires to be inlined
    @turbo @. output = foo(list1,list2)

    return output
end
store_result!(dff, "@turbo (broadcast)")



function test(list1,list2)
    output = similar(list1)
    @.. output = foo.(list1,list2)

    return output
end
store_result!(dff, "@.. (FastBroadcast)")



##############################################################################
#                        BROADCASTED + THREADED (TTURBO)
##############################################################################
function test(list1,list2)
    output = similar(list1)
    @tturbo @. output = foo.(list1,list2)

    return output
end
store_result!(dff, "@tturbo (broadcasted + threaded)")

function test(list1,list2)
    output = similar(list1)
    @strided @. output = foo(list1,list2)

    return output
end
store_result!(dff, "@strided (broadcasted + threaded)")



##############################################################################
#                        VECTORIZED MAPS
##############################################################################
function test(list1,list2) 
    output = vmap(foo, list1, list2)
end
store_result!(dff, "vmap (LoopVectorization)")

function test(list1,list2) 
    output = vmapnt(foo, list1, list2)
end
store_result!(dff, "vmapnt (LoopVectorization)")


output = similar(list1)
test(list1,list2) = vmap!(foo, output, list1, list2)
store_result!(dff, "vmap! (LoopVectorization)")

output = similar(list1)
test(list1,list2) = vmapnt!(foo, output, list1, list2)
store_result!(dff, "vmapnt! (LoopVectorization)")

##############################################################################
#                        THREADED MAPS
##############################################################################

function test(list1,list2) 
    output = vmap(foo, list1, list2)
end
store_result!(dff, "vmapntt (LoopVectorization)")


output = similar(list1)
test(list1,list2) = vmapntt!(foo, output, list1, list2)
store_result!(dff, "vmapntt! (LoopVectorization)")


output = similar(list1)
test(list1,list2) = ThreadsX.map!(foo, output, list1, list2)
store_result!(dff, "ThreadsX.map!")





###RESULT IN MILISECONDS
function miliseconds(benchmark_result, digits; format=false) 
#    printx(x,N) = sprintf1("%.$(N)f",x)
    a = benchmark_result * 1e3  # to translate time into miliseconds (ms)
    a = round(a, digits=digits)
    (format == true) && (a = format(a))    

    return a
end


dff.ms .= miliseconds.(dff.seconds, 1)
sorted2  = sort(dff, :seconds)
