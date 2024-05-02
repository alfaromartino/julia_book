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

list_packages  = ["Distributions", "StatsBase", "Pipe", "LazyArrays", "StaticArrays", "LoopVectorization", "BenchmarkTools"]
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

pkg_folder = joinpath(@__DIR__,"environment_files")
list       = readdir(pkg_folder)
path_files = [joinpath(pkg_folder, file) for file in list if isfile(joinpath(pkg_folder, file))]


function path_download_folder(page_name)
    asset_folder    = joinpath(folderBook.assets, page_name)
    download_folder = joinpath(asset_folder, "codeDownload")
end


function copy_tomls(pages_names, path_files; force=true)
    dst_folders = path_download_folder.(pages_names)

    dst_file(dst_folder, source_file) = joinpath(dst_folder, basename(source_file))

    for file in path_files
        destinations = dst_file.(dst_folders, file)
        cp.(file, destinations, force=force)
    end
end

# this copies all the tomls file to codeDownload 
    #(`page_folders` defined at the beginning of this code)
copy_tomls(pages_names, path_files)