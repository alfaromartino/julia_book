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
        similar(x)
    end
end
@ctime foo($x, $repetitions)
 



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
    a = similar(x); b = similar(x); c = similar(x)    
    # <some calculations using a,b,c>
end
@ctime foo($x)
 



x = [1,2,3]

function foo(x; a = similar(x), b = similar(x), c = similar(x))
    
    # <some calculations using a,b,c>
end
@ctime foo($x)
 



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
 
####################################################
#	DESCRIBING THE TECHNIQUE
####################################################
 
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
score              = rand(nr_days)

performance(score) = score .> 0.5

performance_in_a_loop(x) = [sum(foo(x)) for _ in 1:100]
@ctime performance_in_a_loop($x)
 



nr_days            = 30
score              = rand(nr_days)

performance(score) = score .> 0.5

function performance(score; output = similar(score))
    for i in eachindex(score)
        output[i] = score[i] > 0.5
    end

    return output
end

performance_in_a_loop(x) = [sum(foo(x)) for _ in 1:100]
@ctime performance_in_a_loop($x)
 
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

function repeated_call!(scores)
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

performance!(target, score) = map!(a -> a > 0.5, target, score)

function repeated_call!(target, scores)
    stats = Vector{Float64}(undef, length(scores))

    for col in eachindex(scores)
        performance!(target, scores[col])
        stats[col] = std(target) / mean(target)
    end

    return stats
end
@ctime repeated_call!(target,scores)
 



# simpler
 
Random.seed!(123)       #setting seed for reproducibility
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]


function repeated_call!(scores)
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
 
####################################################
#	APPLICATION 1 - matrices
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
nr_days    = 2
nr_workers = 1_000_000

scores     = rand(nr_days,nr_workers)




function foo(score; temp = Vector{Float64}(undef, nr_days))
    for i in eachindex(score)
        temp[i] = score[i] > 0.5
    end

    return temp
end

@views repeated_call(scores) = [sum(foo(scores[:,j])) for j in axes(scores,2)]
@ctime repeated_call($scores)
 



Random.seed!(123)       #setting seed for reproducibility
nr_days    = 2
nr_workers = 1_000_000

scores     = rand(nr_days, nr_workers)
temp       = Vector{Float64}(undef, nr_days)
output     = Vector{Float64}(undef,length(scores))

function foo!(temp, score)
    for i in eachindex(score)
        temp[i] = score[i] > 0.5
    end

    return temp
end

@views function repeated_call!(output, temp, scores) 
    for col in axes(scores,2)
        output[col] = sum(foo!(temp, scores[:,col]))
    end

    return output
end
@ctime repeated_call!($output,$temp,$scores)
 
####################################################
#	APPLICATION 2 - model simulations
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]





function foo(score)
    temp = similar(score)
    
    for i in eachindex(score)
        temp[i] = score[i] > 0.5
    end

    return std(temp) / mean(temp)
end

function repeated_call(scores) 
    output = Vector{Float64}(undef,length(scores))

    for col in eachindex(scores)
        output[col] = foo(scores[col])
    end

    return output
end
@ctime repeated_call($scores)
 
Random.seed!(123)       #setting seed for reproducibility
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]

temp    = similar(scores[1])
output  = Vector{Float64}(undef,length(scores))

function foo!(temp, score)
    for i in eachindex(score)
        temp[i] = score[i] > 0.5
    end

    return std(temp) / mean(temp)
end

function repeated_call!(output, temp, scores) 
    for col in eachindex(scores)
        output[col] = foo!(temp, scores[col])
    end

    return output
end
@ctime repeated_call!($output,$temp,$scores)
 
####################################################
#	APPLICATION 3 - lazy is slower here
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]





function foo(score)
    temp = similar(score)
    
    for i in eachindex(score)
        temp[i] = score[i] > 0.5
    end

    return temp
end

function repeated_call(scores) 
    output = Vector{Float64}(undef,length(scores))

    for col in eachindex(scores)
        score       = scores[col]
        temp        = foo(score)
        output[col] = std(temp) / mean(temp)
    end

    return output
end
@ctime repeated_call($scores)
 
Random.seed!(123)       #setting seed for reproducibility
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]

temp    = similar(scores[1])
output  = Vector{Float64}(undef,length(scores))

function foo!(temp, score)
    for i in eachindex(score)
        temp[i] = score[i] > 0.5
    end

    return temp
end

function repeated_call!(output, temp, scores) 
    for col in eachindex(scores)
        score   = scores[col]        
        foo!(temp, score)
        output[col] = std(temp) / mean(temp)
    end

    return output
end
@ctime repeated_call!($output,$temp,$scores)
 
Random.seed!(123)       #setting seed for reproducibility
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]


output  = Vector{Float64}(undef,length(scores))

function repeated_call!(output, scores) 
    for col in eachindex(scores)
        score       = scores[col]
        temp        = (score[i] > 0.5 for i in eachindex(score))    # lazy (generator)
        output[col] = std(temp) / mean(temp)
    end

    return output
end
@ctime repeated_call!($output,$scores)
 
Random.seed!(123)       #setting seed for reproducibility
nr_days = 30
scores  = [rand(nr_days), rand(nr_days), rand(nr_days)]


output  = Vector{Float64}(undef,length(scores))

function repeated_call!(output, scores) 
    for col in eachindex(scores)
        score       = scores[col]
        temp        = @~ (score .> 0.5) 
        output[col] = std(temp) / mean(temp)
    end

    return output
end
@ctime repeated_call!($output,$scores)
 
