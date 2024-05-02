###################
#       BASICS
###################
function basics()
    drive = joinpath(homedir(),"MEGA")

    #joinpath(drive, "programming", "JULIA", "main", "initial_folders.jl") |> include
    include(joinpath(drive, "programming", "JULIA", "main", "user_IO_utils_v01.jl"))
    include(joinpath(drive, "programming", "JULIA", "main", "for_websites", "code_split_gather_v01.jl"))
end

basics()
