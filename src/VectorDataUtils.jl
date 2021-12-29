module VectorDataUtils

using LoopVectorization

export l2inner, l2norm, sql2norm, l2dist, sql2dist
export l1norm, l1dist
export xAx, mahaldist

include("L2.jl")
include("Lp.jl")
include("quadratic_forms.jl")


end
