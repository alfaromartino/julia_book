###################
#       BASICS
###################
include(joinpath("C:/", "JULIA_UTILS", "initial_folders.jl"))

include(joinpath(folder_googleDrive, "JULIA", "main", "initial_folders.jl"))
include(joinpath(folder_googleDrive, "JULIA", "main", "user_IO_utils_v01.jl"))
include(joinpath(folder_googleDrive, "JULIA", "main", "for_websites","code_split_gather_v01.jl"))

#names of PAGES in Franklin 
include(joinpath(folderBook.julia_utils, "for_coding", "aux_identify_folders.jl"))
pages_folder = identify_folder_names(folderBook.index)

############################################################################
#
#      CREATE PACKAGE ENVIRONMENT FOR THE FIRST TIME
#
############################################################################

# execute this to create the package environment
import Pkg

# to create the files
#= 
package_folder = joinpath(@__DIR__, "environment_files")
Pkg.generate(package_folder)
Pkg.activate(package_folder)

list_packages  = ["Distributions", "StatsBase", "Pipe", "LazyArrays", "StaticArrays", "LoopVectorization"]
Pkg.add(list_packages)
=#

#to execute when we want to copy
package_folder = joinpath(@__DIR__, "environment_files")
Pkg.activate(package_folder)





############################################################################
#
#                           COPYING PKG FILES TO CODEDOWNLOAD
#
############################################################################


page_folders = identify_folder_names(folderBook.index)

pkg_folder = joinpath(@__DIR__,"environment_files")
list       = readdir(pkg_folder)
path_files = [joinpath(pkg_folder, file) for file in list if isfile(joinpath(pkg_folder, file))]


function path_download_folder(page_folder)
    asset_folder    = "$(folderBook.assets)\\$(page_folder)"
    download_folder = "$(asset_folder)\\codeDownload"
end


function copy_tomls(page_folders; force=true)
    dst_folders = path_download_folder.(page_folders)

    dst_file(dst_folder, source_file) = joinpath.(dst_folder, basename(source_file))

    for file in path_files
        destinations = dst_file.(dst_folders, file)
        cp.(file, destinations, force=force)
    end
end

# this copies all the tomls file to codeDownload
copy_tomls(page_folders)


############################################################################
#
#                       CODE FOR CODEDOWNLOAD
#
############################################################################

# file with julia code
function src_file(page_folder)
    src_folder = folderBook.calculations
    name_file  = "00_calculations_toprint.jl"

    src_file = joinpath(src_folder, page_folder, name_file)
end

# folder to store the code
function dst_path(page_folder)
    asset_folder = folderBook.assets
    dst_folder   = "codeDownload"    
        
    dst_path = joinpath(asset_folder, page_folder, dst_folder)
end


############################################################################
#
#   CODE FOR CODEDOWNLOAD
#
############################################################################


# file with julia code
function src_file(page_folder)
    src_folder = folderBook.calculations
    name_file  = "00_calculations_toprint.jl"

    src_file = joinpath(src_folder, page_folder, name_file)
end

# folder to store the code
function dst_path(page_folder)
    asset_folder = folderBook.assets
    dst_folder   = "codeDownload"    
        
    dst_path = joinpath(asset_folder, page_folder, dst_folder)
end

function code_for_download(page_folder)
    code_file  = src_file(page_folder)
    dst_folder = dst_path(page_folder)

    if isfile(code_file)
        onlyGatherCode(dst_folder, code_file; name_file="allCode")
    end
end

code_for_download.(pages_folder)



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
    filejl = joinpath(dst_path(page_folder), "allCode.jl")

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

add_beginning_text.(pages_folder, text_to_add)

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
    src_folder    = dst_path(page_folder)
    src_name_file = "allCode.jl"
    dst_file      = joinpath(dst_path(page_folder), "allCode_withPkgEnvironment.jl")

    if isfile(joinpath(src_folder, src_name_file)) 
        create_mergedtext(src_folder, src_name_file, dst_file, text_to_add; add_at_beginning=true)
    end
end

addText_PkgEnv.(pages_folder, text_to_add)

