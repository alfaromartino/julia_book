####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used on the website.
# It requires having all files in the same folder (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml).

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# For more accurate results, we benchmark code through functions.
    # We also interpolate each function argument, so that they're taken as local variables.
    # All this means that benchmarking a function `foo(x)` is done via `foo($x)`
using BenchmarkTools

# The following defines the macro `@ctime`, which is equivalent to `@btime` but faster
    # to use it, replace `@btime` with `@ctime`
using Chairmarks
macro ctime(expr)
    esc(quote
        object = @b $expr
        result = sprint(show, "text/plain", object) |>
            x -> object.allocs == 0 ?
                x * " (0 allocations: 0 bytes)" :
                replace(x, "allocs" => "allocations") |>
            x -> replace(x, r",.*$" => ")") |>
            x -> replace(x, "(without a warmup) " => "")
        println("  " * result)
    end)
end

############################################################################
#
#			START OF THE CODE
#
############################################################################
 
using Random, StatsBase, Distributions
 
############################################################################
#
#			DISABLING BOUND INDEX COULD TRIGGER SIMD
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = 2/x[i]
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @simd for i in eachindex(x)
        output[i] = 2/x[i]
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds for i in eachindex(x)
        output[i] = 2/x[i]
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] = 2/x[i]
    end

    return output
end
@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(1_000_000)
foo(x) = 2 ./ x

@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = 2/x[i]
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] = 2/x[i]
    end

    return output
end
@ctime foo($x)
 
############################################################################
#
#			BRANCHLESS NEW 
#
############################################################################
 
# `ifelse` facilitates SIMD, `if` hinders it
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        if x[i] > 0.5
            output += x[i]/2
        end
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        if x[i] > 0.5
            output += x[i]/2
        end
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        output += ifelse(x[i] > 0.5, x[i]/2, 0)
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += ifelse(x[i] > 0.5, x[i]/2, 0)
    end

    return output
end
@ctime foo($x)
 
# compiler could make bad choices
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(5_000_000)
output = similar(x)

function foo!(output,x)
    for i in eachindex(x)
        output[i] = ifelse(x[i] > 0.5, x[i]/2, 0)
    end
end
@ctime foo!($output,$x)
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(5_000_000)
output = similar(x)

function foo!(output,x)
    @inbounds for i in eachindex(x)
        output[i] = ifelse(x[i] > 0.5, x[i]/2, 0)
    end
end
@ctime foo!($output,$x)
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(5_000_000)
output = similar(x)

function foo!(output,x)
    @inbounds @simd for i in eachindex(x)
        output[i] = ifelse(x[i] > 0.5, x[i]/2, 0)
    end
end
@ctime foo!($output,$x)
 
############################################################################
#
#			TERNARY OPERATOR
#
############################################################################
 
####################################################
#	ternary operator tries selects the best among the two approaches
####################################################
 
# ternary operator selects `ifelse`
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        if x[i] > 0.5
            output += x[i]/2
        end
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += ifelse(x[i]>0.5, x[i]/2, 0)
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += x[i]>0.5 ? x[i]/2 : 0
    end

    return output
end
@ctime foo($x)
 
####################################################
#	ternary operator selects `if`
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        if x[i] > 0.99
            output += log(x[i])
        end
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += ifelse(x[i] > 0.99, log(x[i]), 0)
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += x[i]>0.99 ? log(x[i]) : 0
    end

    return output
end
@ctime foo($x)
 
####################################################
#	sometimes ternary operator makes bad choices
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(5_000_000)
output = similar(x)

function foo!(output,x)
    @inbounds @simd for i in eachindex(x)
        if x[i] > 0.5
            output[i] = log(x[i])
        end
    end
end
@ctime foo!($output,$x)
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(5_000_000)
output = similar(x)

function foo!(output,x)
    @inbounds @simd for i in eachindex(x)
        output[i] = ifelse(x[i] > 0.5, log(x[i]), 0)
    end
end
@ctime foo!($output,$x)
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(5_000_000)
output = similar(x)

function foo!(output,x)
    @inbounds @simd for i in eachindex(x)
        output[i] = x[i]>0.5 ? log(x[i]) : 0
    end
end
@ctime foo!($output,$x)
 
############################################################################
#
#			WHAT APPROACH IS OPTIMAL?
#
############################################################################
 
####################################################
#	with ternary operator, easy computations favor SIMD
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
condition(a)   = a > 0.5
computation(a) = a * 2

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        if condition(x[i])
            output += computation(x[i])
        end
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
condition(a)   = a > 0.5
computation(a) = a * 2

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += ifelse(condition(x[i]), computation(x[i]), 0)
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
condition(a)   = a > 0.5
computation(a) = a * 2

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += condition(x[i]) ? computation(x[i]) : 0
    end

    return output
end
@ctime foo($x)
 
####################################################
#	but when computations are more intensive, ternary operator chooses a lazy approach
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(2_000_000)
condition(a)   = a > 0.5
computation(a) = exp(a)/3 - log(a)/2

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        if condition(x[i])
            output += computation(x[i])
        end
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(2_000_000)
condition(a)   = a > 0.5
computation(a) = exp(a)/3 - log(a)/2

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += ifelse(condition(x[i]), computation(x[i]), 0)
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(2_000_000)
condition(a)   = a > 0.5
computation(a) = exp(a)/3 - log(a)/2

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += condition(x[i]) ? computation(x[i]) : 0
    end

    return output
end
@ctime foo($x)
 
############################################################################
#
#			BITVECTOR for CONDITIONS
#
############################################################################
 
####################################################
#	with vector of conditions
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x         = rand(1_000_000)
bitvector = x .> 0.5

function foo(x,bitvector)
    output     = similar(x)
        

    @inbounds @simd for i in eachindex(x)
        output[i] = ifelse(bitvector[i], x[i]/i, x[i]*i)
    end

    return output
end
@ctime foo($x,$bitvector)
 
Random.seed!(123)       #setting the seed for reproducibility
x         = rand(1_000_000)
bitvector = x .> 0.5

function foo(x,bitvector)
    output     = similar(x)
    boolvector = Vector(bitvector)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = ifelse(boolvector[i], x[i]/i, x[i]*i)
    end

    return output
end
@ctime foo($x,$bitvector)
 
# REMARK
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output     = similar(x)
    
    

    @inbounds @simd for i in eachindex(x)
        output[i] = ifelse(x[i]>0.5, x[i]/i, x[i]*i)
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output     = similar(x)
    bitvector  = x .> 0.5
    
    
    @inbounds @simd for i in eachindex(x)
        output[i] = ifelse(bitvector[i], x[i]/i, x[i]*i)
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output     = similar(x)
    boolvector = Vector{Bool}(undef,length(x))
        boolvector .= x .> 0.5

    @inbounds @simd for i in eachindex(x)
        output[i] = ifelse(boolvector[i], x[i]/i, x[i]*i)
    end

    return output
end
@ctime foo($x)
 
############################################################################
#
#			COMPOUND CONDITIONS AS ALGEBRAIC OPERATIONS
#
############################################################################
 
####################################################
#	BROADCASTING
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
y              = rand(1_000_000)


foo(x,y)       = @. ifelse((x>0.3) && (y<0.6) && (x>y), x,y)
@ctime foo($x,$y)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
y              = rand(1_000_000)


foo(x,y)       = @. ifelse((x>0.3) *  (y<0.6) *  (x>y), x,y)
@ctime foo($x,$y)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
y              = rand(1_000_000)
condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)

foo(x,y)       = @. ifelse(condition(x,y), x,y)
@ctime foo($x,$y)
 



Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
y              = rand(1_000_000)


foo(x,y)       = @. ifelse((x>0.3) || (y<0.6) || (x>y), x,y)
@ctime foo($x,$y)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
y              = rand(1_000_000)


foo(x,y)       = @. ifelse(Bool(1 - !(x>0.3) * !(y<0.6) * !(x>y)), x,y)
@ctime foo($x,$y)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
y              = rand(1_000_000)
condition(a,b) = (a > 0.3) || (b < 0.6) || (a > b)

foo(x,y)       = @. ifelse(condition(x,y), x,y)
@ctime foo($x,$y)
 
####################################################
#	FOR-LOOPS
####################################################
 
####################################################
#	REMARK: @simd could be applied even with `if` depending how we write conditions
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x                 = rand(1_000_000)
y                 = rand(1_000_000)


function foo(x,y)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        if (x[i] > 0.3) && (y[i] < 0.6) && (x[i] > y[i])
            output += x[i]
        end       
    end

    return output
end
@ctime foo($x,$y)
 
Random.seed!(123)       #setting the seed for reproducibility
x                 = rand(1_000_000)
y                 = rand(1_000_000)


function foo(x,y)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        if (x[i] > 0.3)  * (y[i] < 0.6)  * (x[i] > y[i])
            output += x[i]
        end       
    end

    return output
end
@ctime foo($x,$y)
 
Random.seed!(123)       #setting the seed for reproducibility
x                 = rand(1_000_000)
y                 = rand(1_000_000)
condition(a,b)    = (a > 0.3) && (b < 0.6) && (a > b)

function foo(x,y)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        if condition(x[i],y[i])
            output += x[i]
        end       
    end

    return output
end
@ctime foo($x,$y)
 



####################################################
#	REMARK: @simd could be applied even with `if` depending how we write conditions
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x                 = rand(1_000_000)
y                 = rand(1_000_000)


function foo(x,y)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        if (x[i] > 0.3) || (y[i] < 0.6) || (x[i] > y[i])
            output += x[i]
        end       
    end

    return output
end
@ctime foo($x,$y)
 
Random.seed!(123)       #setting the seed for reproducibility
x                 = rand(1_000_000)
y                 = rand(1_000_000)


function foo(x,y)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        if Bool(1 - !(x[i] > 0.3)  * !(y[i] < 0.6)  * !(x[i] > y[i]))
            output += x[i]
        end       
    end

    return output
end
@ctime foo($x,$y)
 
Random.seed!(123)       #setting the seed for reproducibility
x                 = rand(1_000_000)
y                 = rand(1_000_000)
condition(a,b)    = (a > 0.3) || (b < 0.6) || (a > b)

function foo(x,y)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        if condition(x[i],y[i])
            output += x[i]
        end       
    end

    return output
end
@ctime foo($x,$y)
 
