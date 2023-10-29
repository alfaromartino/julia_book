
using DataFrames,BenchmarkTools, FLoops, LoopVectorization, FastBroadcast, Formatting, ThreadsX, Strided, Distributions, Random

nr_items = 1_000

Random.seed!(234) # Setting the seed
list = rand(Pareto(log(4,5)), nr_items) #80-20 rule
list = list ./ sum(list)
sort!(list)



#OPERATION
const σ = 3.5
#elast(x) = σ + x - σ * x
elast(x) = σ + x - σ * x + log(x) * 0.1 - exp(x*σ) + 3 * σ * x / (x + 1)



#INITIALIZE DATAFRAME FOR STORING RESULTS
dff = DataFrame(seconds = Float64[], case = String[])

function store_result!(dff, case_name)
    push!(dff.seconds, @belapsed(test($list)))
    push!(dff.case, case_name)
end


##############################################################################
#                                   STANDARD LOOPS
##############################################################################

function test(x)
    output = similar(x)
        for i in eachindex(x)
            output[i] = elast(x[i])
        end
    
    return output
end
store_result!(dff, "standard")


#comprehension
test(list) = [elast(x) for x in list]

store_result!(dff, "comprehension")




##############################################################################
#                              THREADED LOOPS (FLOOPS)
##############################################################################
function test(x)
    output = similar(x)
    Threads.@threads for i in eachindex(x)
        output[i] = elast(x[i])
           end

    return output
end
store_result!(dff, "Threads.@threads")


function test(x)
    output = similar(x)
    @floop for i in eachindex(x)
        output[i] = elast(x[i])
           end

    return output
end
store_result!(dff, "@floop (threaded)")



##############################################################################
#                                   BROADCASTED
##############################################################################
function test(list)    
    output = elast.(list)  # equivalent to `output .= elast.(list)`
            
    return output
end
store_result!(dff, "broadcast no-inline")



function test(list)
    output = similar(list)
    @. output = elast(list)  # equivalent to `output .= elast.(list)`
        
    return output
end
store_result!(dff, "broadcast inline")



function test(list)
    output = similar(list)         # `@turbo`` requires to be inlined
    @turbo @. output = elast(list)

    return output
end
store_result!(dff, "@turbo (broadcast)")



function test(x)
    output = similar(x)
    @turbo for i in eachindex(x)
        output[i] = elast(x[i])
           end

    return output
end
store_result!(dff, "@turbo (loop)")


function test(list)
    output = similar(list)
    @.. output = elast.(list)

    return output
end
store_result!(dff, "@.. (FastBroadcast)")



##############################################################################
#                        BROADCASTED + THREADED (TTURBO)
##############################################################################
function test(list)
    output = similar(list)
    @tturbo @. output = elast.(list)

    return output
end
store_result!(dff, "@tturbo (broadcasted + threaded)")

function test(x)
    output = similar(x)
    @tturbo for i in eachindex(x)
        output[i] = elast(x[i])
           end

    return output
end
store_result!(dff, "@tturbo (loop)")


function test(list)
    output = similar(list)
    @strided @. output = elast(list)

    return output
end
store_result!(dff, "@strided (broadcasted + threaded)")



##############################################################################
#                        VECTORIZED MAPS
##############################################################################
function test(list) 
    output = vmap(elast, list)
end
store_result!(dff, "vmap (LoopVectorization)")

function test(list) 
    output = vmapnt(elast, list)
end
store_result!(dff, "vmapnt (LoopVectorization)")


output = similar(list)
test(list) = vmap!(elast, output, list)
store_result!(dff, "vmap! (LoopVectorization)")

output = similar(list)
test(list) = vmapnt!(elast, output, list)
store_result!(dff, "vmapnt! (LoopVectorization)")

##############################################################################
#                        THREADED MAPS
##############################################################################

function test(list) 
    output = vmap(elast, list)
end
store_result!(dff, "vmapntt (LoopVectorization)")


output = similar(list)
test(list) = vmapntt!(elast, output, list)
store_result!(dff, "vmapntt! (LoopVectorization)")


#=output = similar(list)
test(list) = ThreadsX.map!(elast, output, list)
store_result!(dff, "ThreadsX.map!")=#





###RESULT IN MILISECONDS
function rescale_time(benchmark_result, digits; format=false) 
#    printx(x,N) = sprintf1("%.$(N)f",x)
    a = benchmark_result * 1e8  # to translate time into miliseconds (ms) use 1e3
    a = round(a, digits=digits)
    (format == true) && (a = format(a))    

    return a
end


dff.ms = rescale_time.(dff.seconds, 1)
dff.rate = round.(dff[:, :ms] ./ dff[dff.case.=="standard",:ms] .* 100, digits=2)
sorted3  = sort(dff, :seconds)

browse(sorted3)