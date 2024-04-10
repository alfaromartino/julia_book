###################
#       BASICS
###################
# root folders
include(joinpath("/JULIA_UTILS", "initial_folders.jl"))

# it loads multiple auxiliar utils
location_basics = joinpath(folderBook.julia_utils, "for_coding", "auxiliars")
                  include(joinpath(location_basics, "aux_include_at_top.jl"))



############################################################################
#
#              COPYING FILES "execute_codeSplitGather.jl"
#
############################################################################
# code to copy a single file to multiple directories 
    # (in this case, we copy `execute_codeSplitGather.jl` to each element in `destination_folders`)

source_folder       = joinpath(folderBook.julia_utils, "for_coding") # "$(folderBook.julia_utils)\\for_coding"
name_file           = "execute_codeSplitGather.jl"
source_file         = joinpath(source_folder, name_file) # "$(source_folder)\\$(name_file)"

path_calculation    = folderBook.calculations
list                = readdir(path_calculation)
page_folders        = [folder for folder in list if isdir(joinpath(path_calculation, folder))]
destination_folders = [joinpath(path_calculation, folder) for folder in page_folders]
destination_files   = joinpath.(destination_folders, name_file)

# copy_file(source_file, destination_path)
cp.(source_file, destination_files, force=true)


############################################################################
#
#                           TO REPLACE TEXT WITHIN FILES
#
############################################################################
# folder   = "C:\\Users\\marti\\Google Drive\\WEBSITES\\julia_book2\\PAGES"
# pattern  = raw"""[include(joinpath(@__DIR__, "julia_utils", "basics", file) for file in readdir("julia_utils")]"""
# new_text = raw"""[include(joinpath(@__DIR__, "julia_utils", "basics", file) for file in readdir("julia_utils\\basics")]"""
# folderFiles_replace!(folder, ".md", pattern, new_text)