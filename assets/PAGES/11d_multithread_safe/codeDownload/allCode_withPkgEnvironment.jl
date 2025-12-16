####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used on the website.
# It requires having all files in the same folder (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml).

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    Same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. E.g., `@ctime foo($x)` for timing `foo(x)`=#

# import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
    # uncomment if you don't have the package installed
using FastBenchmark
    

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
println(foo())
 



function foo()
    output = 0

    @threads for i in 1:2
        sleep(1/i)
        output = i
    end

    return output
end
println(foo())
 



# reading and writing a shared variable
 
function foo()
    output = Vector{Int}(undef,2)
    temp   = 0

    for i in 1:2
        temp      = i; sleep(i)
        output[i] = temp
    end

    return output
end
println(foo())
 



function foo()
    output = Vector{Int}(undef,2)
    temp   = 0

    @threads for i in 1:2
        temp      = i; sleep(i)
        output[i] = temp
    end

    return output
end
println(foo())
 



function foo()
    output = Vector{Int}(undef,2)
    

    @threads for i in 1:2
        temp      = i; sleep(i)
        output[i] = temp
    end

    return output
end
println(foo())
 



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
    output = 0.0

    for i in eachindex(x)
        output += x[i]
    end

    return output
end
println(foo(x))
 



Random.seed!(1234)       #setting seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @threads for i in eachindex(x)
        output += x[i]
    end

    return output
end
println(foo(x))
 



Random.seed!(1234)       #setting seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @threads for i in eachindex(x)
        output += x[i]
    end

    return output
end
println(foo(x))
 



Random.seed!(1234)       #setting seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @threads for i in eachindex(x)
        output += x[i]
    end

    return output
end
println(foo(x))
 



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
 
