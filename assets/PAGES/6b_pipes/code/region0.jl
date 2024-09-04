# necessary packages for this file
using Pipe

# to execute the benchmarks
using BenchmarkTools
ref(x) = (Ref(x))[]

# To print results with a specific format (only relevant for the website construction)
print_asis(x)             = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_asis(x,nr_lines)    = show(IOContext(stdout, :limit => true, :displaysize =>(nr_lines,100)), MIME("text/plain"), x)
print_compact(x)          = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x)
print_compact(x,nr_lines) = show(IOContext(stdout, :limit => true, :displaysize =>(nr_lines,6), :compact => true), MIME("text/plain"), x)

################################################################################################################################  ###code region1a (((
using Pipe