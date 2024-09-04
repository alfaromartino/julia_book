include(joinpath(homedir(), "JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#                           GLOBAL VARIABLES
#
############################################################################
 
x = 2

function foo(x) 
    y = 2 * x 
    z = log(y)

    return z
end

@code_warntype foo(x)  # type stable
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 2

function foo() 
    y = 2 * x 
    z = log(y)

    return z
end

@code_warntype foo() # type UNSTABLE
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# all operations are type UNSTABLE (they're defined in the global scope)
x = 2

y = 2 * x 
z = log(y)
 
const a = 5
foo()   = 2 * a

@code_warntype foo()        # type stable
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
const b = [1, 2, 3]
foo()   = sum(b)

@code_warntype foo()        # type stable
 
const k1  = 2

function foo()
    for _ in 1:100_000
       2^k1
    end
end

@btime foo()    # hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
k2::Int64 = 2

function foo()
    for _ in 1:100_000
       2^k2
    end
end

@btime foo()    # hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
k2::Int64 = 2

function foo()
    for _ in 1:1_000_000
       2^k2
    end
end

@btime foo()    # hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# remark on performance
 
using Random; Random.seed!(1234) # hide
x           = rand(100_000)


function foo(x)
    y    = similar(x)
    
    for i in eachindex(x,y)
        y[i] = x[i] / sum(x)
    end

    return y
end
@btime foo($x)    # hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(1234) # hide
x           = rand(100_000)


foo(x) = x ./ sum(x)

@btime foo($x)    # hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(1234) # hide
x           = rand(100_000)
const sum_x = sum(x)

foo(x) = x ./ sum_x

@btime foo($x)    # hide
 
