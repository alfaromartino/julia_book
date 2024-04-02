"""
genplain(s)

Small helper function to run some code and redirect the output (stdout) to a file.
"""
function genplain(dir,s::String)
    open(joinpath(dir, "output", "$(splitext(s)[1]).out"), "w") do outf
        redirect_stdout(outf) do
            include(joinpath(dir, s))
        end
    end
end
# run `script1.jl` and redirect what it prints to `output/script1.out`

dir = joinpath("$(homedir())\\Google Drive\\COURSES\\functions_julia\\course_alberta\\_assets\\scripts\\0x_functions")
readdir(dir)
genplain(dir,"performance-C.jl")

#[genplain(dir,file) for file in readdir(dir)]
# run `script2.jl` which has a savefig(joinpath(@__DIR__, "output", "script2.png"))
#include("script2.jl")