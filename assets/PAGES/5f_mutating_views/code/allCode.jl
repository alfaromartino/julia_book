include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
# using StatsBase, Random
 
############################################################################
#
#           MUTATION THROUGH VECTORS
#
############################################################################
 
x         = [1, 2, 3, 4]

x[3]      = 30
x[4]      = 40
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x         = [1, 2, 3, 4]


x[3:end]  = [30, 40]
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x         = [1, 2, 3, 4]


x[3:end]  = [x[i] * 10 for i in 3:length(x)]
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x         = [1, 2, 3, 4]


x[x .≥ 3] = [x[i] * 10 for i in 3:length(x)]
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x         = [1, 2, 3, 4]


x[x .≥ 3] = x[x .≥ 3] .* 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x    = [1, 2, 3, 4]

x    = x .* 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x    = [1, 2, 3, 4]

x[:] = x .* 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#           MUTATION THROUGH .=
#
############################################################################
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [-1, -2, 3, 4]

x[x .< 0]  = zeros(length(x[x .< 0]))
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [-1, -2, 3, 4]

x[x .< 0] .= zeros(length(x[x .< 0]))           # identical output
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [-1, -2, 3, 4]

x[x .< 0] .= 0
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [-1, -2, 3, 4]

x[x .< 0] .= zeros(length(x[x .< 0]))
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [1, 2, 3, 4]

condition  = (x .≥ 1) .&& (x .≤ 2)
slice      = view(x, condition)

slice     .= slice .* 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
###############
# an explicit view
###############
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [1, 2, 3, 4]
slice  = view(x, x .≥ 3)

slice .= x[x .≥ 3] .* 10                 # same operation as 'x[x .≥ 3] = x[x .≥ 3] .* 10'
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [1, 2, 3, 4]
slice  = view(x, x .≥ 3)

slice .= [i * 10 for i in [3,4]]     # same operation as 'x[x .≥ 3] = [i * 10 for i in [3,4]]'
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [1, 2, 3, 4]
x[x .≥ 3] .= x[x .≥ 3] .* 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [1, 2, 3, 4]
x[x .≥ 3]  = x[x .≥ 3] .* 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [-1, -2, 1, 2]

x[x .< 0] .= 0
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
# SORTPERM -> indices of the sorted vector
#
############################################################################
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x  = [-1, -2, 1, 2]

y  = view(x, x .< 0)
y .= 0
 
print_asis(y) #hide
 
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x  = [-1, -2, 1, 2]

y  = x[x .< 0]              # `y` is a new object
y .= 0                      # this does NOT modify `x`
 
print_asis(y) #hide
 
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x  = [1, 2, 3, 4]

y  = view(x, x .≥ 3)
y .= x[x .≥ 3] .* 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x  = [1, 2, 3, 4]

y  = view(x, x .≥ 3)
y  = x[x .≥ 3] .* 10    # this creates a new variable 'y'
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined elements


for i in eachindex(x)
    x[i] = i
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
y = [3, 4, 5]
x = similar(y)            # `x` mimicks the type of `y`, which is Vector{Int64}(undef, 3)

for i in eachindex(x)
    x[i] = i
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = zeros(Int64,3)         # `x` is Vector{Int64} with 3 elements equal to zero


for i in eachindex(x)
    x[i] = i
end
 
x = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined Int64 elements


for i in eachindex(x)
#    x[i] = i * 2.5                
end
 
y = [3, 4, 5]
x = similar(y)            # `x` has the same type as `y`, which is Vector{Int64}(undef, 3)

for i in eachindex(x)
#    x[i] = i * 2.5
end
 
x = zeros(Int64,3)         # `x` is Vector{Int64} with 3 elements equal to zero


for i in eachindex(x)
#    x[i] = i * 2.5 
end
 
