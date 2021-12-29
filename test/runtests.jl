using VectorDataUtils
using Test
using LinearAlgebra

const Float = Float64

@testset verbose = true "VectorDataUtils.jl" begin
    include("L2_tests.jl")
end
