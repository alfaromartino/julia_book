###################
#       BASICS 
###################
include(joinpath("/JULIA_UTILS", "initial_folders.jl"))

# it loads multiple auxiliar utils
location_basics = joinpath(folderBook.julia_utils, "for_coding", "auxiliars")
                  include(joinpath(location_basics, "aux_include_at_top.jl"))


#######################################################################################################################
#                                                   PAGE-SPECIFIC INFORMATION
########################################################################################################################
#name of PAGE in Franklin 
page_folder = basename(@__DIR__)

#location of julia file
filejl = joinpath(folderBook.calculations, page_folder, "01_calculations_used.jl")



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