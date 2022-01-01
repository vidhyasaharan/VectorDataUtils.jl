using Revise
using VectorDataUtils
using Statistics
using BenchmarkTools
using Distances


ndim = 20
npts = 10000
x = randn(Float64,ndim,npts)
y = randn(Float64,ndim,npts)

d1 = Matrix{Float64}(undef,npts,npts)
d2 = Matrix{Float64}(undef,npts,npts)


@benchmark VectorDataUtils.pairwise!(d1,sql2(),x,y)
@benchmark Distances.pairwise!(d2,SqEuclidean(),x,y)


@benchmark d1 = euclidean(x[:,1],y[:,1])
@benchmark d2 = l2dist(x[:,1],y[:,1])

d3 = evaluate(Euclidean(),x[:,1],y[:,1])

tt = pairwise(Euclidean(), x, y, dims=2)