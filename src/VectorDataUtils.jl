module VectorDataUtils

using LoopVectorization
using LinearAlgebra
using Distances

export l2inner, l2norm, sql2norm, l2dist, sql2dist
export l1norm, l1dist
export xAx, mahaldist, sqmahaldist
export running_mean, running_mean!, update_running_mean!
export running_meanvar, running_meanvar!, update_running_meanvar!
export running_meancov, running_meancov!, update_running_meancov!
export sql2, l2, l1
export generate_4_clusters, generate_circle_cluster, generate_4_circle_clusters

include("Lp.jl")
include("quadratic_forms.jl")
include("running_stats.jl")
include("distances.jl")
include("toy_data.jl")
include("kmeans.jl")
include("helper_functions.jl")

end
