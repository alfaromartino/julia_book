include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#			        SECTION: "OBJECTS ALLOCATING MEMORY"
#
############################################################################
 
############################################################################
#
#   OBJECTS NOT ALLOCATING MEMORY
#
############################################################################
 
####################################################
#	SINGLE NUMBERS (SCALARS) DON'T CREATE ALLOCATIONS	
####################################################
 
function foo()
    x = 1; y = 2; z = 3
    
    x + y + z
end

@ctime foo() #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	ACCESSING or CREATING TUPLES DON'T CREATE ALLOCATIONS
####################################################
 
function foo()
    tup = (1,2,3)

    sum(tup[1:2]) + tup[3]
end

@ctime foo() #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	ACCESSING or CREATING NAMED TUPLES DON'T CREATE ALLOCATIONS
####################################################
 
function foo()
    nt = (a=1, b=2, c=3)

    sum((nt.a, nt.b)) + nt.c
end

@ctime foo() #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	RANGES DON'T ALLOCATE
####################################################
 
function foo()
    rang = 1:3

    sum(rang[1:2]) + rang[3]
end

@ctime foo() #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#   OBJECTS ALLOCATING MEMORY
#
############################################################################
 
####################################################
#	CREATION OF ARRAYS ALLOCATES
####################################################
 
foo() = [1,2,3]

@ctime foo() #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
foo() = sum([1,2,3])


@ctime foo() #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	ACCESS TO SLICES ALLOCATES
####################################################
 
x      = [1,2,3]

foo(x) = x[1:2]                 # allocations only from 'x[1:2]' itself (ranges don't allocate)

@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [1,2,3]

foo(x) = x[[1,2]]               # allocations from both '[1,2]' and 'x[[1,2]]' itself

@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	ACCESS TO THE WHOLE VECTOR OR SINGLE-ELEMENTS DOESN'T ALLOCATE
####################################################
 
x      = [1,2,3]

foo(x) = 2 * sum(x)             

@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [1,2,3]

foo(x) = x[1] * x[2] + x[3]

@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	ARRAY COMPREHENSIONS ALLOCATE
####################################################
 
foo()  = [a for a in 1:3]


@ctime foo() #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	BROADCASTING ALLOCATES
####################################################
 
x      = [1,2,3]
foo(x) = x .* x

@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [1,2,3]
foo(x) = sum(x .* x)                # allocations from temporary vector 'x .* x' 

@ctime foo($x) #hide
 
