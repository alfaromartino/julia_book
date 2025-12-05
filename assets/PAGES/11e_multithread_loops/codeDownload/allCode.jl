############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    Same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. E.g., `@ctime foo($x)` for timing `foo(x)`=#

# import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git") #uncomment if you don't have the package installed
using FastBenchmark
    
############################################################################
#   AUXILIARS FOR DISPLAYING RESULTS
############################################################################
# you can alternatively use "println" or "display"
print_asis(x)    = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_compact(x) = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x)


############################################################################
#
#			START OF THE CODE
#
############################################################################
 
# necessary packages for this file
using Random, Base.Threads
 
############################################################################
#
#			SHARED MEMORY
#
############################################################################
 
# writing on a shared variable
 
function foo()
    output = 0

    for i in 1:2
        sleep(1/i)
        output = i
    end

    return output
end
foo()
 
function foo()
    output = 0

    @threads for i in 1:2
        sleep(1/i)
        output = i
    end

    return output
end
foo()
 
# reading and writing a shared variable
 
function foo()
    out  = zeros(Int, 2)
    temp = 0

    for i in 1:2
        temp   = i; sleep(i)
        out[i] = temp
    end

    return out
end
foo()
 
function foo()
    out  = zeros(Int, 2)
    temp = 0

    @threads for i in 1:2
        temp   = i; sleep(i)
        out[i] = temp
    end

    return out
end
foo()
 
function foo()
    out  = zeros(Int, 2)
    

    @threads for i in 1:2
        temp   = i; sleep(i)
        out[i] = temp
    end

    return out
end
foo()
 
############################################################################
#
#      RACE CONDITIONS
#
############################################################################
 
####################################################
#	same function returns a different result every time is called
####################################################
 
Random.seed!(1234)       #setting seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.

    for i in eachindex(x)
        output += x[i]
    end

    return output
end
foo(x)
 
Random.seed!(1234)       #setting seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.

    @threads for i in eachindex(x)
        output += x[i]
    end

    return output
end
foo(x)
 
Random.seed!(1234)       #setting seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.

    @threads for i in eachindex(x)
        output += x[i]
    end

    return output
end
foo(x)
 
Random.seed!(1234)       #setting seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.

    @threads for i in eachindex(x)
        output += x[i]
    end

    return output
end
foo(x)
 
############################################################################
#
#      EMBARRASSINGLY-PARALLEL PROGRAM
#
############################################################################
 
Random.seed!(1234)       #setting seed for reproducibility
x_small  = rand(    1_000)
x_medium = rand(  100_000)
x_big    = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end
 
@ctime foo($x_small)
 
@ctime foo($x_medium)
 
@ctime foo($x_big)
 
Random.seed!(1234)       #setting seed for reproducibility
x_small  = rand(    1_000)
x_medium = rand(  100_000)
x_big    = rand(1_000_000)

function foo(x)
    output = similar(x)

    @threads for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end
 
@ctime foo($x_small)
 
@ctime foo($x_medium)
 
@ctime foo($x_big)
 
