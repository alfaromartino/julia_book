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
using Random, Statistics, LazyArrays
 
############################################################################
#
#                           PRE-ALLOCATIONS
#
############################################################################
 
####################################################
#	INITIALIZING VECTORS
####################################################
 
####################################################
#	approaches
####################################################
 
x           = collect(1:100)
repetitions = 100_000                       # repetitions in a for-loop

function foo(x, repetitions)
    for _ in 1:repetitions
        Vector{Int64}(undef, length(x))
    end
end
@ctime foo($x, $repetitions)
 



x           = collect(1:100)
repetitions = 100_000                       # repetitions in a for-loop

function foo(x, repetitions)
    for _ in 1:repetitions
        similar(x)
    end
end
@ctime foo($x, $repetitions)
 



x           = collect(1:100)
repetitions = 100_000                       # repetitions in a for-loop

function foo(x, repetitions)
    for _ in 1:repetitions
        zeros(Int64, length(x))
    end
end
@ctime foo($x, $repetitions)
 



x           = collect(1:100)
repetitions = 100_000                       # repetitions in a for-loop

function foo(x, repetitions)
    for _ in 1:repetitions
        ones(Int64, length(x))
    end
end
@ctime foo($x, $repetitions)
 



x           = collect(1:100)
repetitions = 100_000                       # repetitions in a for-loop

function foo(x, repetitions)
    for _ in 1:repetitions
        fill(2, length(x))                  # vector filled with integer 2
    end
end
@ctime foo($x, $repetitions)
 



####################################################
#	initializing vectors in functions
####################################################
 
x = [1,2,3]

function foo(x)
    a,b,c = [similar(x) for _ in 1:3]
    # <some calculations using a,b,c>
end
@ctime foo($x)
 



x = [1,2,3]

function foo(x)
    a,b,c = (similar(x) for _ in 1:3)
    # <some calculations using a,b,c>
end
@ctime foo($x)
 
############################################################################
#
#			DESCRIBING THE TECHNIQUE
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
nr_days            = 30
score              = rand(nr_days)

performance(score) = score .> 0.5
@ctime performance($score)
 



Random.seed!(123)       #setting seed for reproducibility
nr_days            = 30
score              = rand(nr_days)

function performance(score)
    target = similar(score)

    for i in eachindex(score)
        target[i] = score[i] > 0.5
    end

    return target
end
@ctime performance($score)
 



Random.seed!(123)       #setting seed for reproducibility
nr_days            = 30
score              = rand(nr_days)

function performance(score; target=similar(score))
    

    for i in eachindex(score)
        target[i] = score[i] > 0.5
    end

    return target
end
@ctime performance($score)
 



Random.seed!(123)       #setting seed for reproducibility
nr_days            = 30
scores             = [rand(nr_days), rand(nr_days), rand(nr_days)]  # 3 workers



function repeated_call(scores)
    stats = Vector{Float64}(undef, length(scores))

    for col in eachindex(scores)

      stats[col] = std(@~ scores[col] .> 0.5) / mean(@~ scores[col] .> 0.5)
    end

    return stats
end
@ctime repeated_call($scores)
 
Random.seed!(123)       #setting seed for reproducibility
nr_days            = 30
scores             = [rand(nr_days), rand(nr_days), rand(nr_days)]  # 3 workers

performance(score) = score .> 0.5

function repeated_call(scores)
    stats = Vector{Float64}(undef, length(scores))

    for col in eachindex(scores)
      target     = performance(scores[col])
      stats[col] = std(target) / mean(target)
    end

    return stats
end
@ctime repeated_call($scores)
 



Random.seed!(123)       #setting seed for reproducibility
nr_days            = 30
scores             = [rand(nr_days), rand(nr_days), rand(nr_days)]   # 3 workers

function performance(score)
    target = similar(score)

    for i in eachindex(score)
        target[i] = score[i] > 0.5
    end

    return target
end

function repeated_call(scores)
    stats = Vector{Float64}(undef, length(scores))

    for col in eachindex(scores)
      target     = performance(scores[col])
      stats[col] = std(target) / mean(target)
    end

    return stats
end
@ctime repeated_call($scores)
 



Random.seed!(123)       #setting seed for reproducibility
nr_days            = 30
scores             = [rand(nr_days), rand(nr_days), rand(nr_days)]   # 3 workers

function performance(score; target = similar(score))
    
    
    for i in eachindex(score)
        target[i] = score[i] > 0.5
    end

    return target
end

function repeated_call(scores)
    stats = Vector{Float64}(undef, length(scores))

    for col in eachindex(scores)
      target     = performance(scores[col])
      stats[col] = std(target) / mean(target)
    end

    return stats
end
@ctime repeated_call($scores)
 



####################################################
#	PRE-ALLOCATION AS A SOLUTION
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]


performance(score) = score .> 0.5

function repeated_call(scores)
    stats = Vector{Float64}(undef, length(scores))

    for col in eachindex(scores)
        target     = performance(scores[col])
        stats[col] = std(target) / mean(target)
    end

    return stats
end
@ctime repeated_call(scores)
 



Random.seed!(123)       #setting seed for reproducibility
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]
target  = similar(scores[1])

performance!(target, score) = (@. target = score > 0.5)

function repeated_call!(target, scores)
    stats = Vector{Float64}(undef, length(scores))

    for col in eachindex(scores)
        performance!(target, scores[col])
        stats[col] = std(target) / mean(target)
    end

    return stats
end
@ctime repeated_call!(target,scores)
 



Random.seed!(123)       #setting seed for reproducibility
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]
target  = similar(scores[1])

function performance!(target, score)
    for i in eachindex(score)
        target[i] = score[i] > 0.5
    end
end

function repeated_call!(target, scores)
    stats = Vector{Float64}(undef, length(scores))

    for col in eachindex(scores)
        performance!(target, scores[col])
        stats[col] = std(target) / mean(target)
    end

    return stats
end
@ctime repeated_call!(target, scores)
 



# WARNING
 
Random.seed!(123)       #setting seed for reproducibility
x          = rand(10)
output     = 2 .* x

# the following are equivalent and define a new variable `output`
   output  = @. 2  * x
   output  =    2 .* x
 



Random.seed!(123)       #setting seed for reproducibility
x          = rand(10)
output     = 2 .* x

# the following are equivalent and update 'output'
@. output  = 2  * x
   output .= 2 .* x
 
####################################################
#	SIMPLER APPROACHES
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]


function repeated_call(scores)
    stats = Vector{Float64}(undef, length(scores))

    for col in eachindex(scores)
        target     = @. score > 0.5
        stats[col] = std(target) / mean(target)
    end

    return stats
end
@ctime repeated_call(scores)
 



Random.seed!(123)       #setting seed for reproducibility
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]
target  = similar(scores[1])

function repeated_call!(target, scores)
    stats = Vector{Float64}(undef, length(scores))

    for col in eachindex(scores)
        @. target  = scores[col] > 0.5
        stats[col] = std(target) / mean(target)
    end

    return stats
end
@ctime repeated_call!(target,scores)
 



Random.seed!(123)       #setting seed for reproducibility
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]
target  = similar(scores[1])

function repeated_call!(target, scores)
    stats = Vector{Float64}(undef, length(scores))

    for col in eachindex(scores)
        map!(a -> a > 0.5, target, scores[col])
        stats[col] = std(target) / mean(target)
    end

    return stats
end
@ctime repeated_call!(target,scores)
 
