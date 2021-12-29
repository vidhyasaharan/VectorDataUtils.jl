module VectorDataUtils

using LoopVectorization

export l2inner, l2norm, sql2norm, l2dist, sql2dist
export xAx, mahaldist

include("L2.jl")
include("quadratic_forms.jl")

end
