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
using Random
 
############################################################################
#
#			SIMD: INDEPENDENCE OF ITERATIONS
#
############################################################################
 
############################################################################
#
#			INDEPENDENCE OF ITERATIONS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = x[i] / 2 + x[i]^2 / 3
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] = x[i] / 2 + x[i]^2 / 3
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)

foo(x) = @. x / 2 + x^2 / 3
    
@ctime foo($x)
 
############################################################################
#
#			A SPECIAL CASE OF DEPENDENCE: REDUCTIONS
#
############################################################################
 
####################################################
#	automatic application of SIMD for Int in reductions
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1:10, 10_000_000)   # random integers between 1 and 10

function foo(x)
    output = 0

    for a in x
        output += a
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(1:10, 10_000_000)   # random integers between 1 and 10

function foo(x)
    output = 0

    @simd for a in x
        output += a
    end

    return output
end
@ctime foo($x)
 



####################################################
#	no automatic application of SIMD for Float in reductions
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(10_000_000)

function foo(x)
    output = 0.0

    for a in x
        output += a
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(10_000_000)

function foo(x)
    output = 0.0

    @simd for a in x
        output += a
    end

    return output
end
@ctime foo($x)
 



####################################################
#	Why Floating Points Are Treated Differently
####################################################
 
x = 0.1 + (0.2 + 0.3)
println(x)
 



x = (0.1 + 0.2) + 0.3
println(x)
 
