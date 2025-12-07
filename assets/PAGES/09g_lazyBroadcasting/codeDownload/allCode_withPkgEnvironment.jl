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
using Random, LazyArrays
 
############################################################################
#
#           BROADCASTING - INTERNAL EXECUTION
#
############################################################################
 
####################################################
# example
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = 2 .* x
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = 2 * x[i]
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

function foo(x)
    output = similar(x)

    @inbounds for i in eachindex(x)
        output[i] = 2 * x[i]
    end

    return output
end
@ctime foo($x)
 
####################################################
#	remark: @inbounds may be automatically applied to for-loops
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

function foo(x)
    output = zero(eltype(x))

    for i in eachindex(x)
        output += 2 * x[i]
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

function foo(x)
    output = zero(eltype(x))

    for i in eachindex(x)
        output += 2 * x[i]
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

function foo(x)
    output = zero(eltype(x))

    @inbounds for i in eachindex(x)
        output += 2 * x[i]
    end

    return output
end
@ctime foo($x)
 
####################################################
#	remark: there can be other optimization differences between for-loops and broadcasting
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = x ./ sum(x)
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

function foo(x)
    output      = similar(x)
    

    for i in eachindex(x)
        output[i] = x[i] / sum(x)
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

function foo(x)
    output      = similar(x)
    denominator = sum(x)

    @inbounds for i in eachindex(x)
        output[i] = x[i] / denominator
    end

    return output
end
@ctime foo($x)
 
############################################################################
#
#                           BROADCASTING - LOOP FUSION
#
############################################################################
 
####################################################
# intuition
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x        = rand(100)

function foo(x)
    a      = x .* 2
    b      = x .* 3
    
    output = a .+ b
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x        = rand(100)

foo(x)   = x .* 2 .+ x .* 3     # or @. x * 2 + x * 3
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x        = rand(100)

foo(x)   = @. x * 2 + x * 3
@ctime foo($x)
 



####################################################
# using functions to split operation while ensuring loop fusion
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x        = rand(100)

term1(a) = a * 2
term2(a) = a * 3

foo(a)   = term1(a) + term2(a)
@ctime foo.($x)
 
####################################################
#	vector operations can provide identical results to broadcasting
####################################################
 
# addition
 
x        = [1, 2, 3]
y        = [4, 5, 6]

foo(x,y) = x + y
println(foo(x, y))
 



x        = [1, 2, 3]
y        = [4, 5, 6]

foo(x,y) = x .+ y
println(foo(x, y))
 



# product
 
Random.seed!(123)       #setting seed for reproducibility
x        = [1, 2, 3]
β        = 2

foo(x,β) = x * β
println(foo(x,β))
 



Random.seed!(123)       #setting seed for reproducibility
x        = [1, 2, 3]
β        = 2

foo(x,β) = x .* β
println(foo(x, β))
 



####################################################
#	no or partial loop fusion
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

foo(x)  = x * 2 + x * 3
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

function foo(x) 
    term1  = x * 2        
    term2  = x * 3
    
    output = term1 + term2
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

function foo(x) 
    term1  = x .* 2        
    term2  = x .* 3
    
    output = term1 .+ term2
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = x * 2 .+ x .* 3
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

function foo(x)
    term1  = x * 2
    
    output = term1 .+ x .*3
end
@ctime foo($x)
 



####################################################
#	loop fusion
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = x .* 2 .+ x .* 3
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = @. x * 2 + x * 3
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(a) = a * 2 + a * 3
@ctime foo.($x)
 



Random.seed!(123)       #setting seed for reproducibility
x        = rand(100)

term1(a) = a * 2
term2(a) = a * 3

foo(a)   = term1(a) + term2(a)
@ctime foo.($x)
 



Random.seed!(123)       #setting seed for reproducibility
x        = rand(100)

term1(a) = a * 2
term2(a) = a * 3

foo(x)   = @. term1(x) + term2(x)
@ctime foo($x)
 
############################################################################
#
#                           LAZY BROADCASTING
#
############################################################################
 
####################################################
#	comparison with function approach to split operations
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x         = rand(100)

function foo(x) 
    term1  = x .* 2
    term2  = x .* 3
    
    output = term1 .+ term2
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x         = rand(100)

function foo(x) 
    term1  = @~ x .* 2
    term2  = @~ x .* 3
    
    output = term1 .+ term2
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x         = rand(100)

term1(a)  = a * 2
term2(a)  = a * 3

foo(a)    = term1(a) + term2(a)
@ctime foo.($x)
 



Random.seed!(123)       #setting seed for reproducibility
x         = rand(100)

term_1    = @~ x .* 2
term_2    = @~ x .* 3

foo(term1, term2) = term1 .+ term2
@ctime foo($term_1, $term_2)
 
####################################################
#	reductions
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
# eager broadcasting (default)
x      = rand(100)

foo(x) = sum(2 .* x)
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
using LazyArrays
x      = rand(100)

foo(x) = sum(@~ 2 .* x)
@ctime foo($x)
 



# comparison with lazy map
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

term1(a) = a * 2
term2(a) = a * 3
temp(a)  = term1(a) + term2(a)

foo(x)   = sum(temp.(x))
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

term1(a) = a * 2
term2(a) = a * 3
temp(a)  = term1(a) + term2(a)

foo(x)   = sum(Iterators.map(temp, x))
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

term1(a) = a * 2
term2(a) = a * 3
temp(a)  = term1(a) + term2(a)

foo(x)   = sum(@~ temp.(x))
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

function foo(x) 
    term1  = @~ x .* 2
    term2  = @~ x .* 3
    temp   = @~ term1 .+ term2
    
    output = sum(temp)
end
@ctime foo($x)
 
