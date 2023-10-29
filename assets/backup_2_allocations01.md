
+++
sections = Pair{String,String}[]
title = "<i>4b. </i> Variable Scope in a Function"
hascode = false
hasmath = true
+++

<!-- =====================================================================================================
                                                    SECTION
========================================================================================================== -->
\begin{section}{title= "Introduction"}

* we split the discussions into memory allocations and approaches to speed up computations.
* the discussions highlight that we need to be careful about improving performance. It usually requires a lot of work, and it's not always worth it. There's a trade-off between speed and readable code.
* we focus on performance recommendations that are easy to implement and that have a significant impact on performance. It's the type of recommendations that change your approach to writing code, rather than rewriting the whole code. For instance, accessing the two first elements of a vector through `x[1:2]` is faster than `x[[1,2]]`, and so you should the former when possible. 

Why focusing on loops? The most immediate reason is loops itself. However, timing issues in this respect are easily spotted. Rather, the main reason is that we usually break down tasks into functions. 
If the main function ultimately contains a loop, then you compound timing problems of other functions. So, assessing just an evaluation in isolation would make us believe that the timing differences are negligible.
However, this is misleading, as the issue is that maybe your main operation will end up incurring that problem multiple times. 

For example, working with DataFrames requires working with groups. So, let's say you have information about sales of firms in several years and industries. 

The focus will be exclusively on real numbers (i.e., types `Int64` and `Float64`). Furthermore, we keep the presentation simple by only considering one-dimensional arrays (i.e., vectors). This is less important, and the same principes apply to higher-dimensional arrays.


* Since absolute numbers regarding performance vary across computers, the examples provide information mainly regarding relative timing.
\end{section}
<!-- =====================================================================================================
                                                    SECTION
========================================================================================================== -->
\begin{section}{title= "Memory Allocation"}

Reducing memory allocation is neither necessary nor sufficient for increasing speed. The correct way to interpret recommendations in this respect is that a disproportionate memory allocation tends to be a red flag.But just reducing allocations in a non-significant way is not necessarily improving performance. We'll see that it's not uncommon to have a function that allocates more memory, but it's nonetheless faster.

\hideOutput{open}{}{
<!-- #region -->
<!-- ================================ HORIZONTAL CODE ==============================  -->
\html{
<div class="tab_wrapper">
 <div class="tab_code_links">
    <button class="tablink active" data-id="tab_1" style="padding-left:62px;"> Number </button>
    <button class="tablink" data-id="tab_2"> Vector </button>
    <button class="tablink" data-id="tab_3"> Range </button>
</div><div data-id="tab_1" class="tabcontent active">}
\outputBelowModal{open}{~~~\juliarepl~~~ @btime(a = 1)

}

\html{</div><div data-id="tab_2" class="tabcontent">}
\outputBelowModal{open}{~~~\juliarepl~~~ x = [1,2]
<br>~~~\juliarepl~~~ @btime(a = x[1])

#copied
}

\html{</div><div data-id="tab_3" class="tabcontent">}
\outputBelowModal{open}{<br>~~~\juliarepl~~~ @btime(a = 1:1)

#copied  
}

\html{</div></div>}
<!-- end HORIZONTAL CODE ==============================  -->
<!-- #endregion -->
}

\end{section}

<!-- =====================================================================================================
                                                    SECTION
========================================================================================================== -->
\begin{section}{title= "Numbers Don't Allocate"}

Creating new variables or referring to a vector does not necessarily allocate memory. There are three types worth mentioning in this respect:
* numbers (e.g., `a = 1`).
* accessing \textit{one} element of an array (e.g., `a = x[1]`).
* ranges (e.g., `a = 1:4`).

It's worth emphasizing that we're focusing on performance issues due to memory allocation. This does not mean that all the cases mentioned are equivalent regarding performance. For instance, consider `x = [1,2]`. Referring to `a=1` or `a=1:1` is faster than `a = x[1]`, even when `a` ultimately points to the same number.





\end{section}


<!-- =====================================================================================================
                                                    SECTION
========================================================================================================== -->
\begin{section}{title= "Arrays Allocate"}

Accessing more than one item of an array allocates memory. It allocates memory to create a temporary copy of the vector.

\end{section}


<!-- =====================================================================================================
                                                    SECTION
========================================================================================================== -->
\begin{section}{title= "But I Need to Work With Arrays"}



\end{section}


<!-- =====================================================================================================
                                                    SECTION
========================================================================================================== -->
\begin{section}{title= "Views of Slices"}


\end{section}

<!-- =====================================================================================================
                                                    SECTION
========================================================================================================== -->
\begin{section}{title= "For Small Vectors: Tuples and Static Vectors "}

Accessing more than one item of an array allocates memory. The creation of arrays could be explicit, for example if you define a new variable pointing to a vector's slice. But you could also inadvertently create a vector by writing it within an expression. An example of this is `sum(x .* y)`, where `x .* y` creates a temporary vector. For cases like this, views play no role since they only alleviate the problem of working with slices. Here, the problem is that you're creating a new vector.

While there are different ways to tackle this problem, the most straightforward is to use tuples. Tuples are immutable, so they don't allocate memory.



\end{section}


<!-- =====================================================================================================
                                                    SECTION
========================================================================================================== -->
\begin{section}{title= "Generators"}
Generators are useful in calculations to avoid allocations of \textbf{intermediate steps}. It basically bypasses the creation of intermediate vectors, delaying its  computation until it's needed.



\end{section}

<!-- =====================================================================================================
                                                    SECTION
========================================================================================================== -->
\begin{section}{title= "Pre-Allocating Outputs"}

You can use the argument as a variable in another argument, such that `foo(x; pre_alloc = similar(x))`.

\end{section}

<!-- =====================================================================================================
                                                    SECTION
========================================================================================================== -->
\begin{section}{title= "Keyword Arguments can Create Type Instabilities"}
use keyword arguments for optional arguments, not for initializing values with some parameter. Otherwise, the parameter will be interpreted as a global variable. Or unless you specify the type.

\end{section}




<!-- =====================================================================================================
                                                    SECTION
========================================================================================================== -->
\begin{section}{title= "Example"}

The following is an example of adding a part of the file
\code_julia{options..., include_results=false}{#CODE1}

And this is another example. 
\code_julia{options..., include_results=true}{#CODE2}


\end{section}


