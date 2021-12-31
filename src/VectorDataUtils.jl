module VectorDataUtils

using LoopVectorization

export l2inner, l2norm, sql2norm, l2dist, sql2dist
export l1norm, l1dist
export xAx, mahaldist
export running_mean, running_mean!, update_running_mean!
export running_meanvar, running_meanvar!, update_running_meanvar!
export running_meancov, running_meancov!, update_running_meancov!

include("L2.jl")
include("Lp.jl")
include("quadratic_forms.jl")
include("running_stats.jl")

end
