####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used when writing this note.
# It requires having all files (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml) in the same folder.

Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


# to execute the benchmarks
using BenchmarkTools
ref(x) = (Ref(x))[]

# Functions to print result with a specific format (only relevant for the website)= show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)= show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x)
 
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
 
