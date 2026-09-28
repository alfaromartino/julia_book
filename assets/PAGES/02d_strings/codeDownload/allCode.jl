############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    It provides the same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. 
        e.g., `@ctime foo($x)` for timing `foo(x)` =#

# uncomment the following if you don't have the package for @ctime installed
    # import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
using FastBenchmark
 
############################################################################
#
#			        SECTION: "STRINGS"
#
############################################################################
 
############################################################################
#
#	CHARACTERS
#
############################################################################
 
# x equals the character 'a'
x = 'a'

# 'Char' allows for Unicode characters
x = 'β'
y = '🐒'
 



# any character is allowed to define a variable
🐒 = 2      # 🐒 represents a variable, just like if we had defined x = 2

y  = 🐒     # y equals 2, 🐒's value at that moment (not 🐒 itself)
z  = '🐒'   # z equals the character 🐒 (entirely independent of the 🐒 variable )
 
############################################################################
#
#	STRINGS
#
############################################################################
 
x = "Hello, beautiful world"

x = """Hello, beautiful world"""
 



############################################################################
#
#   STRING INTERPOLATION
#
############################################################################
 
number_students = 10


output_text     = "There are $(number_students) students in the course"
 
println(output_text)
 



number_matches  = 50
goals_per_match = 2

output_text     = "Last year, Messi scored $(number_matches * goals_per_match) goals"
 
println(output_text)
 
