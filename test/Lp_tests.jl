@testset "lpnorms" begin
    ndim = 10
    a = rand(Float,ndim)
    @test sum(abs.(a)) ≈ VectorDataUtils.l1norm(a)
end