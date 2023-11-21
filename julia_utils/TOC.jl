using DataFrames

path_prepath = "julia_book"

#FUNCTIONS to CREATE THE TOC
assign_letter(x) = [Char((Int('a') .+ i - 1)) for i in eachindex(x)] 

function add_section!(dftoc2, section, name)
    section_name    = "PAGES\\" .* section .* ".md"
    section_title   = name
    section_letter  = assign_letter(section)
    section_number  = if nrow(dftoc2).==0
                            repeat([1], length(section))
                      else
                            dftoc2.number[nrow(dftoc2)] + 1 |> x -> repeat([x], length(section))
                      end
    [section_name section_letter section_number section_title] |>
          x -> append!(dftoc2, DataFrame(x, names(dftoc2)))
end


function dff_section(all_sec,all_names)
    dftoc2 = DataFrame(section= [], letter=[], number= [], sec_title = [])
    section = Vector{String}[]; sec_title = Vector{String}[]

    push!.(Ref(section), all_sec)
    push!.(Ref(sec_title), all_names)
    add_section!.(Ref(dftoc2), section, sec_title)
return dftoc2
end


function dff_chapters(chapter_names)
    chapter_nr  = eachindex(chapter_names)
    dftoc       = DataFrame(chapter= chapter_names, number=chapter_nr)
end


#local_page = "PAGES/1c_vscode.md"

# FUNCTIONS TO DISPLAY THE TOC IN EACH LOCAL PAGE
function create_sectionTitle(dftoc, local_page, section_name; section_byTOC=true)
    section_number = "$(first(dftoc[dftoc.section.==local_page,:number]))" 
    section_letter = "$(first(dftoc[dftoc.section.==local_page,:letter]))"
    sec_title      = "$(first(dftoc[dftoc.section.==local_page,:sec_title]))"

    section_byTOC == false ?
        (section_title  = "<i>$(section_number)$(section_letter).</i> $(section_name)") :
        (section_title  = "<i>$(section_number)$(section_letter).</i> $(sec_title)")
    
    return section_number, section_letter, section_title
end

# TO HELP CONFIGER CREATE THE CONTENT OF THE MODAL TOC
function forModalTOC(dftoc, i)
    aa = string.(dftoc[dftoc.number .== i,:section]) |> x-> replace.(x, r".md$" => "")
    bb = string.(dftoc[dftoc.number .== i,:gather])
    return collect(zip(aa,bb))
end


# TO CREATE THE NEXT AND PREVIOUS PAGE
function create_nextPrevious!(dftoc)
    next_page = [dftoc[i+1, :section] for i in 1:nrow(dftoc)-1]
    push!(next_page,"")
    
    prev_page = [vcat(dftoc.section...)[i-1] for i in 2:nrow(dftoc)]
    pushfirst!(prev_page,"")

    dftoc.next_page = replace.(next_page, r".md$" .=> "")        
    dftoc.prev_page = replace.(prev_page, r".md$" .=> "")        
end

get_prevpage(dftoc, local_page) = string(first(dftoc[dftoc.section.==local_page,:prev_page]))
get_nextpage(dftoc, local_page) = string(first(dftoc[dftoc.section.==local_page,:next_page]))
