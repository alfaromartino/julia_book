# to execute the benchmarks
using BenchmarkTools
ref(x) = (Ref(x))[]

# Functions to print result with a specific format (only relevant for the website)
print_asis(x)    = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_compact(x) = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x) 
 
 x = 1:100

@time sum(x)         # first run -> it incorporates compilation time 
@time sum(x)         # time without compilation time -> more relevant 
 
 using BenchmarkTools

x = 1:100
@btime sum(ref($x))        # only average time 
 
 using BenchmarkTools

x = 1:100
@benchmark sum(ref($x))    # more statistics than `@btime` 
 
 using BenchmarkTools

@btime begin
   x = 1:100
   sum(ref($x))
end 
 
 using BenchmarkTools

@benchmark begin
   x = 1:100
   sum(ref($x))
end 
 
 ############################################################################
#
#                           for-loop
#
############################################################################ 
 
 x      = collect(1:10)
foo(x) = x .* 2

@btime foo(ref($x)) 
 
 x      = collect(1:10)
foo()  = x .* 2

@btime foo() 
 
 x      = collect(1:10)
foo(x) = x .* 2

function replicate(x)
   for _ in 1:100_000
      foo(x)
   end
end

@btime replicate(ref($x)) 
 
 x      = collect(1:10)
foo()  = x .* 2

function replicate()
   for _ in 1:100_000
      foo()
   end
end

@btime replicate() 
 
 