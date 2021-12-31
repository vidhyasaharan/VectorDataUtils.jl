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
            include("L2_tests.jl")
            include("quadratic_forms_tests.jl")
            include("Lp_tests.jl")
            include("running_stats_tests.jl")
        end 
    end

    # @testset "Float32 Tests" begin
    #     global Float = Float32
    #     println("Running "*String(Symbol(Float))*" Tests")
    #     include("L2_tests.jl")
    #     include("quadratic_forms_tests.jl")
    #     include("Lp_tests.jl")
    #     include("running_stats_tests.jl")
    # end 
    # @testset "Float64 Tests" begin
    #     global Float = Float64
    #     println("Running "*String(Symbol(Float))*" Tests")
    #     include("L2_tests.jl")
    #     include("quadratic_forms_tests.jl")
    #     include("Lp_tests.jl")
    #     include("running_stats_tests.jl")
    # end
end
