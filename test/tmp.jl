using Revise
using VectorDataUtils
using Statistics
using BenchmarkTools
using Distances


npts_per_cluster = 4
r = 0.25
x = VectorDataUtils.generate_4_circle_clusters(npts_per_cluster; r)    
cntrs = VectorDataUtils.kmeans(x, 4)
cntrs = VectorDataUtils.kmeans(x, 4)
@time cntrs = VectorDataUtils.kmeans(x, 4);





ndim = 20
npts = 1000
x = randn(Float64,ndim,npts)
y = randn(Float64,ndim,npts)

@time VectorDataUtils.max_centre_shift(x,y)
@time VectorDataUtils.max_centre_shift2(x,y)


@benchmark m = VectorDataUtils.mindist2cntrs(x,y)


d1 = Matrix{Float64}(undef,npts,npts)
d2 = Matrix{Float64}(undef,npts,npts)

@benchmark VectorDataUtils.pairwise!(d1,sql2(),x,y)
@benchmark Distances.pairwise!(d2,SqEuclidean(),x,y)


@benchmark d1 = euclidean(x[:,1],y[:,1])
@benchmark d2 = l2dist(x[:,1],y[:,1])

d3 = evaluate(Euclidean(),x[:,1],y[:,1])

tt = pairwise(Euclidean(), x, y, dims=2)