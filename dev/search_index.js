var documenterSearchIndex = {"docs":
[{"location":"distances/#Distances","page":"Distances","title":"Distances","text":"","category":"section"},{"location":"distances/","page":"Distances","title":"Distances","text":"The following distances measures are provided:","category":"page"},{"location":"distances/#Distances-induced-in-l_p-Spaces","page":"Distances","title":"Distances induced in l_p Spaces","text":"","category":"section"},{"location":"distances/","page":"Distances","title":"Distances","text":"l2dist\nsql2dist","category":"page"},{"location":"distances/#VectorDataUtils.l2dist","page":"Distances","title":"VectorDataUtils.l2dist","text":"l2dist(a,b)\n\nCompute the l2 distance between two real vectors a and b. The lengths of a and b must match.\n\n\n\n\n\n","category":"function"},{"location":"distances/#VectorDataUtils.sql2dist","page":"Distances","title":"VectorDataUtils.sql2dist","text":"sql2dist(a,b)\n\nCompute the square of the l2 distance between two real vectors a and b. The lengths of a and b must match.\n\n\n\n\n\n","category":"function"},{"location":"distances/#Mahalanobis-Distance","page":"Distances","title":"Mahalanobis Distance","text":"","category":"section"},{"location":"distances/","page":"Distances","title":"Distances","text":"mahaldist","category":"page"},{"location":"distances/#VectorDataUtils.mahaldist","page":"Distances","title":"VectorDataUtils.mahaldist","text":"mahaldist(x,y,A)\n\nCompute the Mahalanobis distance between two real vectors x and y given a square matrix A. Dimensions of x, y and A must match. Mahalanobis distance is given by (x-y)A(x-y).\n\n\n\n\n\n","category":"function"},{"location":"utilities/#Utility-Functions","page":"Utility Functions","title":"Utility Functions","text":"","category":"section"},{"location":"utilities/","page":"Utility Functions","title":"Utility Functions","text":"Some potentially useful utility functions are provided:","category":"page"},{"location":"utilities/#Vector-Quadratic-Form","page":"Utility Functions","title":"Vector Quadratic Form","text":"","category":"section"},{"location":"utilities/","page":"Utility Functions","title":"Utility Functions","text":"xAx","category":"page"},{"location":"utilities/#VectorDataUtils.xAx","page":"Utility Functions","title":"VectorDataUtils.xAx","text":"xAx(x,A)\n\nCompute the scalar quadratic term x'Ax given a real vector x and a square matrix A. The dimensions of x and A must match.\n\n\n\n\n\n","category":"function"},{"location":"norms/#Norms-and-Inner-Products","page":"Norms and Inner Products","title":"Norms and Inner Products","text":"","category":"section"},{"location":"norms/","page":"Norms and Inner Products","title":"Norms and Inner Products","text":"The following elementary vector norms and inner products are provided:","category":"page"},{"location":"norms/#l_2-Spaces","page":"Norms and Inner Products","title":"l_2 Spaces","text":"","category":"section"},{"location":"norms/","page":"Norms and Inner Products","title":"Norms and Inner Products","text":"l2inner\nsql2norm\nl2norm","category":"page"},{"location":"norms/#VectorDataUtils.l2inner","page":"Norms and Inner Products","title":"VectorDataUtils.l2inner","text":"l2inner(a,b)\n\nComputes the inner product in the l2 vector space (dot product) between Real or Complex vectors a and b. The lenghts of a and b must match.\n\nSee also l2norm, l2dist, sql2norm, sql2dist.\n\nExample\n\na = [1,2,3]\nb = [2,0,4]\nl2inner(a,b)\n\n# output\n\n14\n\n\n\n\n\nl2inner(a)\n\nComputes the inner product in the l2 vector space (dot product) of the Real or Complex vectors a with itself. i.e., the Squared l2 norm of a. This is identical to calling sql2norm(a).\n\n\n\n\n\n","category":"function"},{"location":"norms/#VectorDataUtils.sql2norm","page":"Norms and Inner Products","title":"VectorDataUtils.sql2norm","text":"sql2norm(a)\n\nCompute the square of the l2 norm of a real or complex vector a. This is identical to calling l2inner(a).\n\n\n\n\n\n","category":"function"},{"location":"norms/#VectorDataUtils.l2norm","page":"Norms and Inner Products","title":"VectorDataUtils.l2norm","text":"l2norm(a)\n\nCompute the l2 norm of a real valued vector a.\n\n\n\n\n\n","category":"function"},{"location":"norms/#Other-l_p-Spaces","page":"Norms and Inner Products","title":"Other l_p Spaces","text":"","category":"section"},{"location":"#VectorDataUtils-Documentation","page":"Home","title":"VectorDataUtils Documentation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"VectorDataUtils.jl provides a number of basic vector operation and data processing routines in Julia. It is intended as a support library for other Julia toolboxes and not as a standalone toolbox. Many of the included routines make use of the excellent LoopVectorization.jl to improve their runtime performance.","category":"page"},{"location":"#Note","page":"Home","title":"Note","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Most of the routines implemented in VectorDataUtils.jl do not include any form of checks on the inputs. It is the users responsibility to ensure that array sizes and element types are appropriate.","category":"page"},{"location":"#Outline","page":"Home","title":"Outline","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Currently VectorDataUtils.jl implements routines for:","category":"page"},{"location":"","page":"Home","title":"Home","text":"Norms and Inner Products\nDistances\nUtilities","category":"page"}]
}
