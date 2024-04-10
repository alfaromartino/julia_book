###################
#       BASICS
###################
function basics()
    drive = BasicFolders.folder_googleDrive

    include(joinpath(drive, "programming", "JULIA", "main", "initial_folders.jl"))
    include(joinpath(drive, "programming", "JULIA", "main", "user_IO_utils_v01.jl"))
    include(joinpath(drive, "programming", "JULIA", "main", "for_websites", "code_split_gather_v01.jl"))
end

basics()