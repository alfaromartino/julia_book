include(joinpath("C:/", "JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Statistics
 
############################################################################
#
#                           GLOBAL VARIABLES
#
############################################################################
 
x      = rand(10)
foo(x) = sum(x)

@btime foo(ref($x))
#@code_warntype foo() # hide
 
x     = rand(10)
foo() = sum(x)

@btime foo()
#@code_warntype foo() # hide
 
x     = rand(10)

@btime begin
    sum(x)
end
#@code_warntype foo() # hide
 
using Statistics

x      = rand(10)
foo(x) = sum(x) * prod(x) * mean(x) * std(x)

@btime foo(ref($x))
 
using Statistics

x      = rand(10)
foo()  = sum(x) * prod(x) * mean(x) * std(x)

@btime foo()
 
x  = [1, 2, "hello"]            # `x` has type Vector{Any}, due to the combination of numbers and strings


sum(x[1:2])     # hide
@code_warntype sum(x[1:2])      # type unstable -> sum considering the possibility of `Any`
 
x  = Vector{Any}(undef, 2)      # `x` defined with type Vector{Any}
x .= 1

sum(x)          # hide
@code_warntype sum(x)           # type unstable -> sum considering the possibility of `Any`
 
x  = Vector{Number}(undef, 2)   # `x` defined with type Vector{Number}
x .= [1, 1.0]                   # `x` is type promoted to [1.0, 1.0] but still Vector{Number}

sum(x)          # hide 
@code_warntype sum(x)           # type unstable -> sum considering the possibility of all numeric types
 
x  = Vector{Int64}(undef, 10)   # `x` is defined as Vector{Int64}
x .= 1.0                        # `x` is converted to `Int64` to respect type's definition

sum(x)          # hide
@code_warntype sum(x)           # type stable
 
x  = Vector{Float64}(undef, 10)
x .= 1                          # 1 is converted to 1.0 to respect x's type defined above

sum(x)          # hide
@code_warntype sum(x)           # type stable
 
x  = [1, 2, 2.5]                # x has type Vector{Float64} (converted by the so-called 'type promotion')


sum(x)          # hide
@code_warntype sum(x)           # type stable
 
