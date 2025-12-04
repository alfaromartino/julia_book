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
 
# necessary packages for this file
using Random, LazyArrays
 
############################################################################
#
#                           BROADCASTING - INTERNAL EXECUTION
#
############################################################################
 
####################################################
#	example 1
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = 2 .* x
@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = 2 * x[i]
    end

    return output
end
@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
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
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

function foo(x)
    output = zero(eltype(x))

    for i in eachindex(x)
        output += 2 * x[i]
    end

    return output
end
@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

function foo(x)
    output = zero(eltype(x))

    for i in eachindex(x)
        output += 2 * x[i]
    end

    return output
end
@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
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
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = x ./ sum(x)

@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

function foo(x)
    output      = similar(x)
    

    for i in eachindex(x)
        output[i] = x[i] / sum(x)
    end

    return output
end
@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
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
 
Random.seed!(123)       #setting the seed for reproducibility
x        = rand(100)

function foo(x)
    a      = x .* 2
    b      = x .* 3
    
    output = a .+ b
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x        = rand(100)

foo(x)   = x .* 2 .+ x .* 3     # or @. x * 2 + x * 3
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x        = rand(100)

foo(x)   = @. x * 2 + x * 3

@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x        = rand(100)

term1(a) = a * 2
term2(a) = a * 3

foo(a)   = term1(a) + term2(a)
@ctime foo.($x)
 
####################################################
#	vector operations can provide same results as broadcasting
####################################################
 
# example 1
 
x        = [1, 2, 3]
y        = [4, 5, 6]

foo(x,y) = x + y
foo(x, y)
 
x        = [1, 2, 3]
y        = [4, 5, 6]

foo(x,y) = x .+ y
foo(x, y)
 


# example 2
 
Random.seed!(123)       #setting the seed for reproducibility
x        = [1, 2, 3]
β        = 2

foo(x,β) = x * β
foo(x,β)
 


Random.seed!(123)       #setting the seed for reproducibility
x        = [1, 2, 3]
β        = 2

foo(x,β) = x .* β
foo(x, β)
 


####################################################
#	no or partial loop fusion
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x)  = x * 2 + x * 3
@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x) 
    term1  = x * 2        
    term2  = x * 3
    
    output = term1 + term2
end

@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x) 
    term1  = x .* 2        
    term2  = x .* 3
    
    output = term1 .+ term2
end

@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = x * 2 .+ x .* 3
@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

function foo(x)
    term1  = x * 2
    
    output = term1 .+ x .*3
end
@ctime foo($x)
 


####################################################
#	loop fusion
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = x .* 2 .+ x .* 3
@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = @. x * 2 + x * 3
@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(a) = a * 2 + a * 3
@ctime foo.($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x        = rand(100)

term1(a) = a * 2
term2(a) = a * 3

foo(a)   = term1(a) + term2(a)
@ctime foo.($x)
 
Random.seed!(123)       #setting the seed for reproducibility
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
#	comparison with functions
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x         = rand(100)

function foo(x) 
    term1  = x .* 2
    term2  = x .* 3
    
    output = term1 .+ term2
end
@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x         = rand(100)

function foo(x) 
    term1  = @~ x .* 2
    term2  = @~ x .* 3
    
    output = term1 .+ term2
end
@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x         = rand(100)

term1(a)  = a * 2
term2(a)  = a * 3

foo(a)    = term1(a) + term2(a)
@ctime foo.($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x         = rand(100)

term_1    = @~ x .* 2
term_2    = @~ x .* 3

foo(term1, term2) = term1 .+ term2
@ctime foo($term_1, $term_2)
 
####################################################
#	reductions
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
# eager broadcasting (default)
x      = rand(100)

foo(x) = sum(2 .* x)
@ctime foo($x)
 



Random.seed!(123)       #setting the seed for reproducibility
using LazyArrays
x      = rand(100)

foo(x) = sum(@~ 2 .* x)
@ctime foo($x)
 



# comparison with Iterators
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

term1(a) = a * 2
term2(a) = a * 3
temp(a)  = term1(a) + term2(a)

foo(x)   = sum(temp.(x))
@ctime foo($x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

term1(a) = a * 2
term2(a) = a * 3
temp(a)  = term1(a) + term2(a)

foo(x)   = sum(Iterators.map(temp, x))
@ctime foo($x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

term1(a) = a * 2
term2(a) = a * 3
temp(a)  = term1(a) + term2(a)

foo(x)   = sum(@~ temp.(x))
@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x) 
    term1  = @~ x .* 2
    term2  = @~ x .* 3
    temp   = @~ term1 .+ term2
    
    output = sum(temp)
end

@ctime foo($x)
 
