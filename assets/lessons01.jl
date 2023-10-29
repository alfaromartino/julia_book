
using DataFrames,BenchmarkTools, FLoops, LoopVectorization, FastBroadcast, Formatting, ThreadsX, Strided, Distributions, Random, Pipe, BrowseTables
#using DataFrames, BenchmarkTools, BrowseTables, Distributions, Random, Pipe
browse(x) = open_html_table(x)



##############################################################################
#                                   AUXILIARS
##############################################################################

function pre_allocate(x)
    eltype(x) isa Union ?
    (c = Vector{Union{Float64,Missing}}(undef,length(x))) :
    (c = Vector{Float64}(undef,length(x)))
    return c
end


# to test a complex function 
foo(x,y) = x / y * 100 + (x^2 + y^2) / y + log(x) + y * exp(x)
avoid allocation of intermediate temporary arrays


##############################################################################
#                                   NUMBERS DON'T ALLOCATE
##############################################################################

function test(a)    
    for _ in 1:100
        a = 1
    end
end
a =0
@btime test($a)

function test(a,x)
    a = 0    
    for _ in 1:100
    a = x[1]
    end
end

array = [1,2,3]
@btime test(a, $array)


function test()
    for _ in 1:100
    a = 1:1
    a[1] + a[1]
    end
end

array = [1,2,3]
@btime test(array)

#this is important for the next, not itself


##############################################################################
#                                   ARRAYS ALLOCATE
##############################################################################
function test()
    for _ in 1:100
        a = 1
        b = 2

        a + b
    end
end
@benchmark test()

function test(x)
    for _ in 1:100
        a = x[[1,2]]        # it allocates TWO temporary vectors: `x[[1,2]]` and `[1,2]`

        a[1] + a[2]
    end
end

array = [1,2,3]
@benchmark test($array)

##############################################################################
#                                  be careful with keyword arguments
##############################################################################

parameter     = 3
array         = rand(1_000_000)#[1.0,2.0,3.0]

test(x, β = parameter) = x .* β
@code_warntype foo(array)                   # type unstable
@code_warntype foo(array; parameter = β)    # type stable



# fix 1 - not flexible
parameter     = 3.0
array         = [1, 2]
foo1(x; β::Float64 = parameter) =  sum(x .* β)

@code_warntype foo1(array)                   # type stable

# fix 2 - flexible
array         = [1, 2]
foo(x, β = foo_parameter()) = sum(x .* β)   # type stable

foo_parameter() = 3                         # this acts as a `const` value
foo(array)
#9 
foo_parameter() = 3.0
foo(array) 
#9.0

# fix 3 - nt
foo(x, nt) = sum(x .+ nt.β)                 # type stable
param = 3
nt = (; β = param)
foo([1,2],nt) 
#9


##############################################################################
#                       be careful with closures
##############################################################################

function foo(x)
    β = 1
    β = 2
    baz(x) =  x * β 

    return baz(x)    
end

@code_warntype foo(1)

function foo(x)
    β = 1
    β = 2
    baz(x,β) =  x * β 

    return baz(x,β)
end

@code_warntype foo(1)




##############################################################################
#                                   INITIALIZING ALLOCATES
##############################################################################

function test(x)
    output = zeros(length(x))
    for i in eachindex(x)
        output[i] = x[i]         
    end
end

array = [1,2,3]
@benchmark test($array)

#number_iterations = 10
function main_test(x, repetitions = 10)
    for i in 1:repetitions
        intermediate_output = test(x,y)
        pre_alloc_output[i] = sum(intermediate_output)
    end
    return pre_alloc_output
end

#varargs also allocate if they reference a global variable
some_variable = 3.0
function main_test(x; repetitions = 100, β = some_variable)
    for _ in 1:repetitions
         x .* β
    end
end

@code_warntype main_test(rand(500), repetitions = 100, β = some_variable)
xx = rand(1000)
ff(x) =  [x .* some_variable for _ in 1:1000]

ff(x; β = some_variable) =  [x .* β for _ in 1:1000]

function gg(x; β = some_variable)
    z = 0.0
    for _ in 1:1000
    z =    x .* β 
    end
    return z
end

@code_warntype gg(x)


##############################################################################
#                                   VIEWS
##############################################################################
### first we can reduce allocation with ranges
function test(x)
    for _ in 1:100
        a = x[1:2]          # it allocates ONE temporary vector: `x[1:2]` only

        a[1] + a[2]
    end
end

array = [1,2,3]
@benchmark test($array)


# Now, let's focus on the allocation `x[1:2]`. The solution that applies to every case is using views of slices.
# Notice that `view` doesn't solve the allocation of `[1,2]`. It only creates views of slices.
# A `view` actually minimizes allocations, and sometimes has to allocate memory. 
function test(x)
    for _ in 1:100
        a = view(x, 1:2)

        a[1] + a[2]
    end
end
array = [1,2,3]
@benchmark test($array)

# you also have available the macros `@view` and `@views` to create views of slices. They perform completely different operations.
# `@view` is equivalent to `view(x, 1:2)`, while `@views` identifies slices in some code and replaces with views of them.

# I'm not a big fan of macros, although their use is inevitable. Sometimes, they lead to unexpected behaviors. See XXXXXX in particular for particular bugs you could introduce by using `@views`.
function test(x)
    for _ in 1:100        
        a = @view x[1:2]
        b = @view x[2:3]

        a[1] + a[2]
    end
end
array = [1,2,3]
@benchmark test($array)

@views function test(x)
    for _ in 1:100
        a = x[1:2]
        b = x[2:3]

        a[1] + a[2]
    end
end
array = [1,2,3]
@benchmark test($array)
#`@views` is more general since it'd apply to \textit{any} slice that appears in the code.


# Using Slices of Arguments allocate, and `@views` take care of that
# Recall that the goal is to think that these functions will be used in main loops 
@views function test(x)
    for _ in 1:100
        a = x[1:2]
        b = x[2:3]

        a[1] + a[2]
    end
end
array = [1,2,3,4,5]
@benchmark test($array[1:3])


##############################################################################
#                                   Static Arrays
##############################################################################

function foo(x)
    a = x[1:200]
    b = x[2:3]

    sum(a[1] * b[2]) * sum(x)    
end
                                                    #hide
using Random, BenchmarkTools; Random.seed!(123)     #hide
nr_elements   = 200                                 #hide
repetitions   = 10_000                              #hide
random_vector = rand(nr_elements, repetitions)      #hide
                                                    #hide
function test(random_list, repetitions;             #hide
              output=Vector{Float64}(undef, repetitions))    #hide                   
    for i in 1:repetitions                          #hide
        x = random_list[i]                          #hide
        output[i] = foo(x)                          #hide
    end                                             #hide
return output                                       #hide
end                                                 #hide

random_list = [random_vector[:, col] for col in 1:repetitions]
#hide 
@btime test($random_list, $repetitions);


@views function foo(x)
    a = x[1:200]
    b = x[2:3]

    sum(a[1] * b[2]) * sum(x)    
end


random_list = [random_vector[:, col] for col in 1:repetitions]
@btime test($random_list, $repetitions);


function foo(x)
    a = x[1:200]
    b = x[2:3]

    sum(a[1] * b[2]) * sum(x)    
end


random_list   = [Tuple(random_vector[:, i]) for i in 1:repetitions]
@btime test($random_list, $repetitions);


function foo(x)
    a = x[SVector(1,200)]
    b = x[SVector(2,3)]

    sum(a[1] * b[2]) * sum(x)    
end
using StaticArrays
static_arrays(i) = SVector{nr_elements,eltype(random_vector[1,:])}(random_vector[:, i])
random_list      = [static_arrays(i) for i in 1:repetitions]

@btime test($random_list, $repetitions);


  1.7040 ms (20002 allocations: 18.08 MiB)
  0.2731 μs (2 allocations: 78.17 KiB)
  33.356 ms (2020002 allocations: 46.31 MiB)
  0.5755 μs (2 allocations: 78.17 KiB)


##############################################################################
#                                   GENERATORS
##############################################################################
function main_test(test, x, y; repetitions=100, pre_alloc_output = Vector{Float64}(undef,repetitions))    
    for i in 1:repetitions
        intermediate_output = test(x,y)
        pre_alloc_output[i] = sum(intermediate_output)
    end
    return pre_alloc_output
end

#main_test(test, vector1, vector2, repetitions=10)


vector1 = rand(20)
vector2 = rand(20)
number_iterations = 10

test(x,y) = [foo(x[i],y[i]) for i in eachindex(x,y)]
display("test1")
#display(@benchmark test($vector1, $vector2))
display(@benchmark main_test(test, $vector1, $vector2, repetitions=$number_iterations))


test(x,y) = (foo(x[j],y[j]) for j in eachindex(x,y))
display("test2")
display(@benchmark main_test($test, $vector1, $vector2, repetitions=$number_iterations))


test(x,y) = foo(x,y)
#display(@benchmark test($vector1, $vector2))
display(@benchmark main_test($test, $vector1, $vector2, repetitions=$number_iterations))


function test(x,y; pre_alloc_input  = similar(x)) 
    pre_alloc_input    .= foo.(x,y)
    intermediate_output = sum(pre_alloc_input)
    
    return intermediate_output
end
#display(@benchmark test($vector1, $vector2))
display(@benchmark main_test($test, $vector1, $vector2, repetitions=$100))

function main_test(test, x, y; repetitions=100, 
                   pre_alloc_input  = Vector{Float64}(undef,repetitions),
                   pre_alloc_output = Vector{Float64}(undef,repetitions))
    for i in 1:repetitions
        pre_alloc_input[i]  = test(x,y) .+ i 
        pre_alloc_output[i] = sum(pre_alloc_input)
    end
    return pre_alloc_output
end


function test3(x,y,repetitions; pre_alloc = Vector{Float64}(undef,repetitions), pre_alloc2 = similar(x))
    for i in 1:repetitions
       @turbo pre_alloc2 .= foo.(x,y)
       pre_alloc[i] = sum(pre_alloc2)
    end    
    return pre_alloc
end
display("test3")
display(@benchmark test3($vector1, $vector2, $repetitions))

vector1 = rand(500)
vector2 = rand(500)


#= with these values wont matter
vector1 = rand(1_000_000)
vector2 = rand(1_000_000)
repetitions = 2

while here could matter, which makes a difference relative to static arrays
vector1 = rand(500)
vector2 = rand(500)
repetitions = 100_000
=#

#remark: always add generators inside a function or a new scope (they act like `const`)
nums = [1, 3, 5, 7, 9];
gen = (n for n in nums);
collect(gen)

nums = [1, 2, 3, 4];
collect(gen)

##
nums = [1, 2, 3];
generat = (n for n in nums);
collect(generat)

nums = [4,5,6];
collect(generat) # [1,2,3]

#but
nums = [1, 2, 3];
generat = (nums[i] for i in nums);
collect(generat)

nums = [4,5,6];
collect(generat) # [4,5,6]

#but
nums = [1, 2, 3];
generat = (nums[i] for i in nums);
collect(generat)

nums = [4,5];
collect(generat) # error


#USE THIS
test3(vector1) = (vector1[j] for j in vector1)





############# fixing the previous code
temp(var_x,y,temp_vector)   = (temp_vector .= foo.(var_x,y))
baseline(x,y; temp_vector)  = [sum(temp(x[i],y,temp_vector)) for i in eachindex(x)]

@btime baseline(x,y, temp_vector = similar(y));


temp(var_x,y)  = (foo(var_x,y[j]) for j in eachindex(y))
baseline(x,y)  = [sum(temp(x[i],y)) for i in eachindex(x)]
@btime baseline(x,y)



##############################################################################
#                                   CUDA
##############################################################################
using FoldsCUDA, CUDA, FLoops, LoopVectorization, Folds, Strided, FastBroadcast
using Random, BenchmarkTools

nr_elements   = 1_000_000
repetitions   = 100

Random.seed!(123)        #Setting the seed for reproducibility
x_base = rand(Float64, nr_elements)
y_base = rand(Float64, nr_elements)

x_gpu  = CuArray(convert.(Float64, x_base))
y_gpu  = CuArray(convert.(Float64, y_base))

foo(x,y) = x / y * 100 + (x^2 + y^2) / y + log(x) + y * exp(x)

function foo_threads(x, y ; output = similar(x))  
    @.. thread=true output = foo(x,y)    
    #@strided for i in eachindex(x)
    #   output[i] = foo(x[i],y[i])
    #end

    return output
end


function foo_gpu(x, y ; output = similar(x)) 
    @. output = foo(x,y)        
end

aa = foo_threads(x_base, y_base)

@btime foo_gpu($x_base, $y_base);
@btime foo_threads($x_base, $y_base);
@btime foo_gpu($x_gpu, $y_gpu);

@benchmark foo_threads(x_base, y_base)
#@time foo_gpu(x_gpu, y_gpu);
@benchmark CUDA.@sync foo_gpu(x_gpu, y_gpu)



function foo_gpu(x, y ; output = similar(x)) 
    @. output = foo(x,y)    
end

function conv(x,y)
    x_gpu  = CuArray{Float32, 1, CUDA.Mem.DeviceBuffer}(x)
    y_gpu  = CuArray{Float32, 1, CUDA.Mem.DeviceBuffer}(y)    
    #return x_gpu,y_gpu,output
    Array(foo_gpu(x_gpu,y_gpu, similar(x_gpu)))
end

conv(x_base, y_base)

@benchmark CUDA.@sync conv($x_base, $y_base)


foo1(x,y,repetitions) = [foo_threads(x, y) for _ in 1:repetitions]
foo2(x,y,repetitions) = [foo_gpu(x, y)     for _ in 1:repetitions]



# @btime foo1($x_base, $y_base, $repetitions);
# @btime foo2($x_gpu, $y_gpu, $repetitions);



@views function test3a(random_list)    
    out = Vector{Vector{Any}}(undef,2)

    numba  = Int(length(random_list)/2)
    firstit  = random_list[1: numba]
    secondit = random_list[numba + 1 : length(random_list)]
    
    output = similar(firstit)
    @async out[2] = Threads.@spawn test2.(secondit)

    Threads.@spawn for i in eachindex(firstit)
         x = firstit[i]
         y = firstit[i]
         output[i] = foo_threads(x,y)
     end     
     out[1] = output              
     return out
 end
 test3a(random_list)

 function test3b(random_list; output = similar(random_list))
    @Threads.threads for i in eachindex(random_list)
         x = random_list[i]
         y = random_list[i]
         output[i] = foo_threads(x,y)
     end     
     return output
 end

@btime test3a($random_list);
test3a(random_list)
@btime test3b($random_list);
#a = test1(random_list, repetitions)
#b = testit2.(random_list)


##############################################################################
#                                   DISPLAYING RESULTS
##############################################################################
#=
function rescale_time(result, digits; format=false) 
#    printx(x,N) = sprintf1("%.$(N)f",x)
    a = result * 1e3  # to translate time into miliseconds (ms) use 1e3
    a = round(a, digits=digits)
    (format == true) && (a = format(a))    

    return a
end

output = copy(dfr)

output.ms = rescale_time.(output.seconds, 1)
output.rate = round.(output[:, :ms] ./ output[output.case.=="standard",:ms] .* 100, digits=2)
sorted3  = sort(output, :seconds)

browse(sorted3)
=#


##############################################################################
#                               PRE-ALLOCATING OUTPUTS
##############################################################################
x = rand(100)
function test(x)    
    output = 2 .* log.(x)    
end
@btime test(x);


function test(x; output = similar(x))    
    output .= 2 .* log.(x)    
end
@btime test(x);