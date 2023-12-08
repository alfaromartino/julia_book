
###################
#       BASICS
###################
include(joinpath("C:/", "JULIA_UTILS", "initial_folders.jl"))

include(joinpath(folder_googleDrive, "JULIA", "main", "initial_folders.jl"))
include(joinpath(folder_googleDrive, "JULIA", "main", "for_websites","code_split_gather_v01.jl"))



#######################################################################################################################
#                                                   PAGE-SPECIFIC INFORMATION
########################################################################################################################

#name of PAGE in Franklin 
page_folder = basename(@__DIR__)

#location of julia file
filejl = "$(folderBook.calculations)\\$(page_folder)\\01_calculations_used.jl"


###################
#       CREATE FOLDERS (if they don't already exist)
###################

function create_folder(x) 
    isdir(x) || (mkdir(x))
    x
end

asset_folder = joinpath(folderBook.assets, page_folder)
code_folder  = joinpath(asset_folder, "code")


###################
#       SPLIT AND GATHER CHODE
###################
# this splits and gathers, and then returns a vector with each chunk of code
code_names, code_content = splitAndGatherCode(code_folder, filejl)


###################
#       STORE RESULTS
###################
store_outputs(code_folder, code_names)