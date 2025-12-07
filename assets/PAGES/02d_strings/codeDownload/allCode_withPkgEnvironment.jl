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
 
############################################################################
#
#			STRINGS
#
############################################################################
 
####################################################
#	characters
####################################################
 
# x equals the character 'a'
x = 'a'

# 'Char' allows for Unicode characters
x = 'β'
y = '🐒'
 



# any character is allowed for defining a variable
🐒 = 2          # 🐒 represents a variable, just like if we had defined x = 2

y  = 🐒         # y equals 2
z  = '🐒'       # z equals the character 🐒
 
####################################################
#	string notation
####################################################
 
x = "Hello, beautiful world"

x = """Hello, beautiful world"""
 
############################################################################
#
#			STRING INTERPOLATION
#
############################################################################
 
number_students = 10


output_text     = "There are $(number_students) students in the course"
 
println(output_text)
 



number_matches  = 50
goals_per_match = 2

output_text     = "Last year, Messi scored $(number_matches * goals_per_match) goals"
 
println(output_text)
 
