
############################################################################
#
#                           TO CREATE ASSETS LOCATION
#
############################################################################



# TO REFER TO ASSETS (for images)
function add_assets!(dftoc)
    x                 = [replace(x, r".md$" => "", r"\\\\" => "/") for x in dftoc.section]
    add_asset(a)      = "/assets/" * a

    return [add_asset(a) for a in x]
end

dftoc.path_assets       = add_assets!(dftoc)
dftoc.path_pics         = dftoc.path_assets .* "/pics"
dftoc.path_tikz         = dftoc.path_assets .* "/tikz"



getPath_assets(dftoc, local_page)       = string(first(dftoc[dftoc.section.==local_page,:path_assets]))
getPath_pics(dftoc, local_page)         = string(first(dftoc[dftoc.section.==local_page,:path_pics]))
getPath_tikz(dftoc, local_page)         = string(first(dftoc[dftoc.section.==local_page,:path_tikz]))


############################################################################
#
#                           FOR DOWNLOADING FILES IN ASSETS
#
############################################################################
# TO REFER TO ASSETS (for images and the link to codeDownload)
#assets_folder(PAGEfile) = "/assets/$(subfolder)/$(PAGEfile)"
#dftoc.path_assets       = assets_folder.(dftoc.name)

let dftoc = dftoc
    assets_folder(PAGEfile) = "/assets/$(subfolder)/$(PAGEfile)"
    html_tree               = "https://github.com/alfaromartino/$(path_prepath)/tree/main/"
    dftoc.path_codeDownload = string.(html_tree, dftoc.path_assets, "/codeDownload")
end

getPath_codeDownload(dftoc, local_page) = string(first(dftoc[dftoc.section.==local_page,:path_codeDownload]))



#=

# FOR GOOGLE ROBOTS
url    = "https://alfaromartino.github.io/blog/PAGES/"
robots = string.(url, dftoc.name, "/")
robots = join(robots, "\n")

function create_textfile(dir, namefile, included_text)
    path = joinpath("$(dir)","$(namefile)") #use "" instead of `dir` for using current folder
    open(path, "w") do file
        write(file, included_text) 
    end
end

dftoc1 = dff_chapters(all_chapters)
dftoc  = dff_section(all_sec, all_names)
=#