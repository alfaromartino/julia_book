include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
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
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(x) = 2 .* x
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = 2 * x[i]
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

function foo(x)
    output = similar(x)

    @inbounds for i in eachindex(x)
        output[i] = 2 * x[i]
    end

    return output
end
@ctime foo($x) #hide
 
####################################################
#	remark: @inbounds may be automatically applied to for-loops
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

function foo(x)
    output = zero(eltype(x))

    for i in eachindex(x)
        output += 2 * x[i]
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

function foo(x)
    output = zero(eltype(x))

    for i in eachindex(x)
        output += 2 * x[i]
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

function foo(x)
    output = zero(eltype(x))

    @inbounds for i in eachindex(x)
        output += 2 * x[i]
    end

    return output
end
@ctime foo($x) #hide
 
####################################################
#	remark: there can be other optimization differences between for-loops and broadcasting
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(x) = x ./ sum(x)

@ctime foo($x)    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

function foo(x)
    output      = similar(x)
    

    for i in eachindex(x)
        output[i] = x[i] / sum(x)
    end

    return output
end
@ctime foo($x)    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

function foo(x)
    output      = similar(x)
    denominator = sum(x)

    @inbounds for i in eachindex(x)
        output[i] = x[i] / denominator
    end

    return output
end
@ctime foo($x)    #hide
 
############################################################################
#
#                           BROADCASTING - LOOP FUSION
#
############################################################################
 
####################################################
# intuition
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x        = rand(100)

function foo(x)
    a      = x .* 2
    b      = x .* 3
    
    output = a .+ b
end
@ctime foo($x)    #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x        = rand(100)

foo(x)   = x .* 2 .+ x .* 3     # or @. x * 2 + x * 3
@ctime foo($x)    #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x        = rand(100)

foo(x)   = @. x * 2 + x * 3

@ctime foo($x)    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x        = rand(100)

term1(a) = a * 2
term2(a) = a * 3

foo(a)   = term1(a) + term2(a)
@ctime foo.($x)    #hide
 
####################################################
#	vector operations can provide same results as broadcasting
####################################################
 
# example 1
 
x        = [1, 2, 3]
y        = [4, 5, 6]

foo(x,y) = x + y
print_asis(foo(x, y))   #hide
 
x        = [1, 2, 3]
y        = [4, 5, 6]

foo(x,y) = x .+ y
print_asis(foo(x, y))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# example 2
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x        = [1, 2, 3]
β        = 2

foo(x,β) = x * β
print_asis(foo(x,β))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x        = [1, 2, 3]
β        = 2

foo(x,β) = x .* β
print_asis(foo(x, β))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	no or partial loop fusion
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x)  = x * 2 + x * 3
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x) 
    term1  = x * 2        
    term2  = x * 3
    
    output = term1 + term2
end

@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x) 
    term1  = x .* 2        
    term2  = x .* 3
    
    output = term1 .+ term2
end

@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(x) = x * 2 .+ x .* 3
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

function foo(x)
    term1  = x * 2
    
    output = term1 .+ x .*3
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	loop fusion
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(x) = x .* 2 .+ x .* 3
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(x) = @. x * 2 + x * 3
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(a) = a * 2 + a * 3
@ctime foo.($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x        = rand(100)

term1(a) = a * 2
term2(a) = a * 3

foo(a)   = term1(a) + term2(a)
@ctime foo.($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x        = rand(100)

term1(a) = a * 2
term2(a) = a * 3

foo(x)   = @. term1(x) + term2(x)
@ctime foo($x) #hide
 
############################################################################
#
#                           LAZY BROADCASTING
#
############################################################################
 
####################################################
#	comparison with functions
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x         = rand(100)

function foo(x) 
    term1  = x .* 2
    term2  = x .* 3
    
    output = term1 .+ term2
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x         = rand(100)

function foo(x) 
    term1  = @~ x .* 2
    term2  = @~ x .* 3
    
    output = term1 .+ term2
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x         = rand(100)

term1(a)  = a * 2
term2(a)  = a * 3

foo(a)    = term1(a) + term2(a)
@ctime foo.($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x         = rand(100)

term_1    = @~ x .* 2
term_2    = @~ x .* 3

foo(term1, term2) = term1 .+ term2
@ctime foo($term_1, $term_2) #hide
 
####################################################
#	reductions
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
# eager broadcasting (default)
x      = rand(100)

foo(x) = sum(2 .* x)
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
using LazyArrays
x      = rand(100)

foo(x) = sum(@~ 2 .* x)
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# comparison with Iterators
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

term1(a) = a * 2
term2(a) = a * 3
temp(a)  = term1(a) + term2(a)

foo(x)   = sum(temp.(x))
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

term1(a) = a * 2
term2(a) = a * 3
temp(a)  = term1(a) + term2(a)

foo(x)   = sum(Iterators.map(temp, x))
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

term1(a) = a * 2
term2(a) = a * 3
temp(a)  = term1(a) + term2(a)

foo(x)   = sum(@~ temp.(x))
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x) 
    term1  = @~ x .* 2
    term2  = @~ x .* 3
    temp   = @~ term1 .+ term2
    
    output = sum(temp)
end

@ctime foo($x) #hide
 
