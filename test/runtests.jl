using VectorDataUtils
using Test
using LinearAlgebra

const Float = Float64

@testset verbose = true "VectorDataUtils.jl" begin
    include("L2_tests.jl")
    include("quadratic_forms_tests.jl")
    include("Lp_tests.jl")
end
