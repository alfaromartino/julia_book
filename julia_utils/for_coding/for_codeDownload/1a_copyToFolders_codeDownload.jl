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



############################################################################
#
#    create 00_calculations_toprint.jl
#
############################################################################

# this makes the file "00_calculations_toprint.jl" identical to
# "01_calculations_used.jl"
    # it could be ommited if we're tweaking it manually


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
#                       CODE FOR CODEDOWNLOAD
#
############################################################################

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

function code_for_download(page_folder)
    code_file  = _src_file(page_folder)
    dst_folder = _dst_path(page_folder)

    if isfile(code_file)
        onlyGatherCode(dst_folder, code_file; name_file="allCode")
    end
end

code_for_download.(pages_names)



####################################################
#	CHANGE BENCHMARK TEXT
####################################################

function capture_content_region_benchmark(filejl)    
    read_file = open(filejl, "r")
    content   = read(read_file, String)
    close(read_file)
    
    #specify regex to capture code
    start_line  = raw"###code region_benchmark"
    end_line    = raw"###\)\)\)"
    middle      = raw"(\w*)\s\(\(\(\s*([\s\S]*?)\s*"
        
    pattern  = Regex("$(start_line)$(middle)$(end_line)")
    
    #capture code
    code_matched  = match(pattern, content)    
    code_content  = code_matched.captures[2]

    return code_content
end

function pattern_region_benchmark(filejl; just_inside_text = true)    
    read_file = open(filejl, "r")
    content   = read(read_file, String)
    close(read_file)
    
    if just_inside_text
        #specify regex to capture code
        start_line  = raw"###code region_benchmark"
        end_line    = raw"###\)\)\)"
        middle      = raw"(\w*)\s\(\(\(\s*([\s\S]*?)\s*"
            
        pattern      = Regex("$(start_line)$(middle)$(end_line)")
        code_matched = match(pattern, content)

        isnothing(code_matched) ? nothing : code_matched.captures[2]
    else
        #specify regex to capture code
        start_line  = raw"###code region_benchmark"
        end_line    = raw"###\)\)\)"
        middle      = raw"(\w*)\s\(\(\(\s*([\s\S]*?)\s*"
            
        return  Regex("$(start_line)$(middle)$(end_line)")
    end
end


function replace_benchmark_text(page_folder, replacing_text_bench, replacing_text_nobench)
    filejl = joinpath(_dst_path(page_folder), "allCode.jl")

    if isfile(filejl) 
        pattern = pattern_region_benchmark(filejl)
        if pattern ≠ nothing
            replace_text!(splitdir(filejl)..., pattern, replacing_text_bench)
        else
            append_text!(splitdir(filejl)..., replacing_text_nobench)
        end        
    end
end


####################################################
#	TEXT AT BEGINNING OF CODE
####################################################

text_to_add = """

############################################################################
#
#                           START OF THE CODE 
#
############################################################################

"""

function add_beginning_text(page_folder, text_to_add)
    bench_text             = read_content(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
    replacing_text_bench   = bench_text * text_to_add
    replacing_text_nobench = text_to_add

    replace_benchmark_text(page_folder, replacing_text_bench, replacing_text_nobench)
end

add_beginning_text.(pages_names, text_to_add)

############################################################################
#
#                           ADD PACKAGE TEXT TO CODE
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

