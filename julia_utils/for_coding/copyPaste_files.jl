###################
#       BASICS
###################
include(joinpath("C:/", "JULIA_UTILS", "initial_folders.jl"))

include(joinpath(folder_googleDrive, "JULIA", "main", "initial_folders.jl"))
include(joinpath(folder_googleDrive, "JULIA", "main", "user_IO_utils_v01.jl"))
include(joinpath(folder_googleDrive, "JULIA", "main", "for_websites","code_split_gather_v01.jl"))


############################################################################
#
#              COPYING FILES "execute_codeSplitGather.jl"
#
############################################################################

source_folder = "$(folderBook.julia_utils)\\for_coding"
name_file     = "execute_codeSplitGather.jl"
source_file   = "$(source_folder)\\$(name_file)"

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
# pattern  = raw"""[include("$(@__DIR__)\\julia_utils\\basics\\$(file)") for file in readdir("julia_utils")]"""
# new_text = raw"""[include("$(@__DIR__)\\julia_utils\\basics\\$(file)") for file in readdir("julia_utils\\basics")]"""
# folderFiles_replace!(folder, ".md", pattern, new_text)


