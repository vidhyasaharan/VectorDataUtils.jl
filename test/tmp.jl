using Revise
using VectorDataUtils
using Statistics
using BenchmarkTools


ndim = 4
npts = 10
x = randn(Float64,ndim,npts)
m̂,Ĉ = VectorDataUtils.running_meancov(x[:,1:3])

m,C = VectorDataUtils.running_meancov(x[:,1:2])

@benchmark VectorDataUtils.update_running_meancov!(m,C,x[:,3],3)