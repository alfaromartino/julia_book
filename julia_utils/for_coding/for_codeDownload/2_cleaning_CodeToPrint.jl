###################
#       BASICS
###################
# root folders
include(joinpath(homedir(), "JULIA_UTILS", "initial_folders.jl"))

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

#= order of execution
    1. copyToFolders_codeDownload.jl
    2. cleaning_CodeToPrint.jl
=#



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
# get rid of print_compact regions 
    # empty regions appear when `print_compact` is the only line
    # the code selects everything, including `###code regionxxx ((( and ###)))`
####################################################
pattern = Regex("(#*\\s*###code\\s(?:\\w+)\\s\\(\\(\\(\\s*(?:print_compact\\(.*\\)|print_asis\\(.*\\))\\s*###\\)\\)\\)\\s*#*)")
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
# We use `foo(ref($x))` for more accurate benchmarks of any function `foo(x)`
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
#               ADDING EMPTY LINES TO GET SPACE
#
############################################################################

####################################################
# `skipline` to skip when the name is skipline1, skipline01, etc
    # skiplines are useful to leave empty spaces in the code
    # note that calling it `skipline` in the code has no effect,
    # only <space_to_be_deleted> has an effect
    # but `skipline` is useful to identify them
####################################################
# pattern        = r"\n.*###code\s*(?!skipline\d+)\s*\(\(\(\s*###\)\)\)"  
# replacing_text = "\n\n\n"
# replace_text_in_00print!.(pages_names, pattern, replacing_text)


# generic function that chooses the region skipline
    # then it replaces it by empty space
    # you get one line per <space_to_be_deleted>
    # notice this deletes all the empty lines, 
        # so you need to add at least two <space_to_be_deleted> to see a difference
        # relative to not adding anything
function replace_region_skipline!(page_name)
        number_empty_lines = "\n"       # empty lines per <space_to_be_deleted>
        filejl = joinpath(_dst_path(page_name), "allCode.jl") # path for allCode
        if isfile(filejl)            
            pattern            = r"(\n*.*#\s*<space_to_be_deleted>\s*\n*)"
            replace_text!(splitdir(filejl)..., pattern, number_empty_lines)
        end    
end

replace_region_skipline!.(pages_names)



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

import Pkg
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

