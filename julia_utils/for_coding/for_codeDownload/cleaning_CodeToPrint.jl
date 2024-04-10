###################
#       BASICS
###################
# root folders
include(joinpath("/JULIA_UTILS", "initial_folders.jl"))

# it loads multiple auxiliar utils
location_basics = joinpath(folderBook.julia_utils, "for_coding", "auxiliars")
                  include(joinpath(location_basics, "aux_include_at_top.jl"))


#names of PAGES in Franklin 
include(joinpath(location_basics, "aux_identify_folders.jl"))
pages_names = identify_folder_names(folderBook.index)


#= What we need to accomplish:
    1. get rid of #hide and print_asis, print_compact, etc
    2. add header with benchmark utils
    3. add packages (manually)
=#


############################################################################
#
#    create 00_calculations_toprint.jl
#
############################################################################

# this makes the file "00_calculations_toprint.jl" identical to
# "01_calculations_used.jl"

function replicate_code_source(page_name)
    source_folder    = joinpath(folderBook.calculations, page_name)
    name_file        = "01_calculations_used.jl"
    source_file      = joinpath(source_folder, name_file)

    if isfile(source_file)
        dst_folder       = joinpath(folderBook.calculations, page_name)
        name_file        = "00_calculations_toprint.jl"
        destination_file = joinpath.(dst_folder, name_file)

        cp(source_file, destination_file, force=true)
    end
end

replicate_code_source.(pages_names)


############################################################################
#
#                       CODE SOURCES FOR CODEDOWNLOAD
#
############################################################################

# we indicate the source file and where it'll be eventually stored

# file with julia code
function _src_file(page_folder)
    src_folder = folderBook.calculations
    name_file  = "00_calculations_toprint.jl"

    src_file = joinpath(src_folder, page_folder, name_file)
end

# folder to store the code
function _dst_path(page_folder)
    asset_folder = folderBook.assets
    dst_folder   = "codeDownload"    
        
    dst_path = joinpath(asset_folder, page_folder, dst_folder)
end


############################################################################
#
#                       MODIFY PARTS OF THE TEXT
#
############################################################################
# generic function to replace text in the file 00_calculations_toprint
function replace_text_in_00print!(page_name, pattern, replacing_text)
    filejl = _src_file(page_name)       # path for 00_calculations_toprint.jl
    
    if isfile(filejl) 
        replace_text!(splitdir(filejl)..., pattern, replacing_text)
    end
end



####################################################
#	get rid of #hide
####################################################
pattern        = r"\s*(#hide)"
replacing_text = ""
replace_text_in_00print!.(pages_names, pattern, replacing_text)

#for a specific page
    #aux_replace_text!("6d_application01", pattern, "")



####################################################
#	get rid of print_asis, print_compact, etc
####################################################
pattern        = r"(?:^\n*)?\s+print_(compact|asis)\((.*?)\)\s*(?:\n*$)?"
replacing_text = ""
replace_text_in_00print!.(pages_names, pattern, replacing_text)

#for a specific page
    #aux_replace_text!("6d_application01", pattern, "")

####################################################
# get rid of empty regions 
    # (they show up when print_compact, print_asis are the only line, after they were removed)
    # I also skip when the name is skipline1, skipline01, etc
    # skiplines are useful to leave empty spaces in the code
####################################################
pattern        = r"\n.*###code\s*(?!skipline\d+)\s*\(\(\(\s*###\)\)\)"  
replacing_text = ""
replace_text_in_00print!.(pages_names, pattern, replacing_text)

#for a specific page
    #aux_replace_text!("6d_application01", pattern, "")



############################################################################
#  TEXT AT BEGINNING OF CODE
# (modifies "region_bench" of file "00_calculations_toprint.jl")
############################################################################

function pattern_region_bench(filejl)    
    read_file = open(filejl, "r")
    content   = read(read_file, String)
    close(read_file)
    
    #specify regex to capture code
    start_line  = raw"###code region_bench"
    end_line    = raw"###\)\)\)"
    middle      = raw"(\w*)\s\(\(\(\s*([\s\S]*?)\s*"
        
    pattern  = Regex("$(start_line)$(middle)$(end_line)")
    
    #capture code
    code_matched  = match(pattern, content)
    code_content  = isnothing(code_matched) ? nothing : code_matched.captures[2]

    return code_content
end

function replace_region_bench(page_name, replacing_text_bench; replacing_text_nobench = "")
    filejl = _src_file(page_name)       # path for 00_calculations_toprint.jl

    if isfile(filejl) 
        pattern = pattern_region_bench(filejl)
        if pattern ≠ nothing
            replace_text!(splitdir(filejl)..., pattern, replacing_text_bench)
        else
            append_text!(splitdir(filejl)..., replacing_text_nobench)
        end        
    end
end




text_to_add = raw"""
############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# We use `foo(ref($x))` for more accurate benchmarks of the function `foo(x)`
using BenchmarkTools
ref(x) = (Ref(x))[]


############################################################################
#
#                           START OF THE CODE 
#
############################################################################
"""

replace_region_bench.(pages_names, text_to_add)

# for a particular page
    #replace_region_bench("6d_application01", text_to_add)




############################################################################
#
#               COPY CODE TO THE DOWNLOAD FOLDER
#
############################################################################


# this should be the last step
function code_for_download(page_folder)
    code_file  = _src_file(page_folder)
    dst_folder = _dst_path(page_folder)

    if isfile(code_file)
        onlyGatherCode(dst_folder, code_file; name_file="allCode")
    end
end

code_for_download.(pages_names)

#code_for_download("6d_application01")


############################################################################
#
#               ADD PACKAGE TEXT TO CODE (only for codeDownload)
#
############################################################################

#same destination-folder function as before
    # which in turn is the source-folder too now

text_to_add = """
####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used when writing this note.
# It requires having all files (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml) in the same folder.

Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


"""

function addText_PkgEnv(page_folder, text_to_add)
    src_folder    = _dst_path(page_folder)
    src_name_file = "allCode.jl"
    dst_file      = joinpath(_dst_path(page_folder), "allCode_withPkgEnvironment.jl")

    if isfile(joinpath(src_folder, src_name_file)) 
        create_mergedtext(src_folder, src_name_file, dst_file, text_to_add; add_at_beginning=true)
    end
end

addText_PkgEnv.(pages_names, text_to_add)

