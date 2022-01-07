using VectorDataUtils
using Test
using LinearAlgebra
using Statistics


@testset verbose = true "VectorDataUtils.jl" begin
    for ftype ∈ [Float32, Float64]
        global Float = ftype
        fstring = String(Symbol(Float))
        ftest = fstring*" Tests"
        @testset "$ftest" begin
            println("Running "*fstring*" Tests")
            include("quadratic_forms_tests.jl")
            include("Lp_tests.jl")
            include("running_stats_tests.jl")
            include("distances_tests.jl")
            include("kmeans_tests.jl")
        end 
    end
end
