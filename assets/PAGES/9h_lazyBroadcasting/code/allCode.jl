include(joinpath(homedir(), "JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Random, LazyArrays
 
############################################################################
#
#                           BROADCASTING
#
############################################################################
 
# example 1
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(1_000)

foo(x) = 2 .* x
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(1_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = 2 * x[i]
    end

    return output
end
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(1_000)

function foo(x)
    output = similar(x)

    @inbounds for i in eachindex(x)
        output[i] = 2 * x[i]
    end

    return output
end
@btime foo($x) #hide
 
# example 2
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

function foo(x)
    output = zero(eltype(x))

    for i in eachindex(x)
        output += 2 * x[i]
    end

    return output
end
@btime foo($x) #hide
 
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
@btime foo($x) #hide
 
# example 3
 
Random.seed!(1234) # hide
x      = rand(1_000)

foo(x) = x ./ sum(x)

@btime foo($x)    # hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234) # hide
x      = rand(1_000)

function foo(x)
    output      = similar(x)
    

    for i in eachindex(x)
        output[i] = x[i] / sum(x)
    end

    return output
end
@btime foo($x)    # hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234) # hide
x      = rand(1_000)

function foo(x)
    output      = similar(x)
    denominator = sum(x)

    @inbounds for i in eachindex(x)
        output[i] = x[i] / denominator
    end

    return output
end
@btime foo($x)    # hide
 
############################################################################
#
#                           BROADCASTING - LOOP FUSION
#
############################################################################
 
# example 1
 
x        = [1, 2, 3]
y        = [4, 5, 6]

foo(a,b) = a * b

@btime foo.($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x        = [1, 2, 3]
y        = [4, 5, 6]

foo(x,y) = x .* y

@btime foo($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x        = (1, 2, 3)
y        = (4, 5, 6)

foo(a,b) = a * b

@btime foo.($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x        = (1, 2, 3)
y        = (4, 5, 6)

foo(x,y) = x .* y

@btime foo($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# example 2
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = [1, 2, 3]
β = 2

foo(x,β) = x * β

print_asis(foo(x,β)) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = [1, 2, 3]
β = 2

foo(x,β) = x .* β 

print_asis(foo(x, β)) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# example
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = exp.(2 * x) + (3 * x) * 5

@btime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x) 
    aux1  = 2 .* x
        term1 = exp.(aux1)
    aux2  = 3 .* x
        term2 = aux2 .* 5

    return term1 + term2
end

@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = exp.(2 .* x) .+ (3 .* x) .* 5

@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = @. exp(2 * x) + (3 * x) * 5

@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(a) = exp(2 * a) + (3 * a) * 5

@btime foo.($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x) 
    output = similar(x)
    
    @inbounds for i in eachindex(x)
        output[i] = exp(2 * x[i]) + (3 * x[i]) * 5
    end

    return output
end

@btime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

aux1(a) = exp(2 * a)
aux2(a) = (3 * a) * 5

foo(x)  = @. aux1(x) + aux2(x)

@btime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

aux1(a) = exp(2 * a)
aux2(a) = (3 * a) * 5

foo(a)  = aux1(a) + aux2(a)
@btime foo.($x) #hide
 
############################################################################
#
#                           LAZY BROADCASTING
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
# eager broadcasting (default)
x      = rand(100)

foo(x) = sum(2 .* x)

@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
using LazyArrays
x      = rand(100)

foo(x) = sum(@~ 2 .* x)

@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    term1(a)  = 2 * a + 1
    term2(b)  = 3 * b - 1
    temp(a,b) = term1(a) * term2(b)

    sum(temp.(x,y))   
end

@btime foo($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    term1(a)  = 2 * a + 1
    term2(b)  = 3 * b - 1
    temp(a,b) = term1(a) * term2(b)
    
    sum(Iterators.map(temp, x,y))
end

@btime foo($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    term1(a)  = 2 * a + 1
    term2(b)  = 3 * b - 1
    temp(a,b) = term1(a) * term2(b)
    
    sum(@~ temp.(x,y))
end

@btime foo($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    term1     = @~ @. 2 * x + 1
    term2     = @~ @. 3 * y - 1
    temp      = @~ @. term1 * term2
    
    sum(temp)
end

@btime foo($x, $y) #hide
 
