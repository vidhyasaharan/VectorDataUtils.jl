@testset "lpnorms" begin
    ndim = 10
    a = rand(Float,ndim)
    @test sum(abs.(a)) ≈ VectorDataUtils.l1norm(a)
end

@testset "lpdist" begin
    ndim = 10
    a = rand(Float,ndim)
    b = rand(Float,ndim)
    @test sum(abs.(a-b)) ≈ VectorDataUtils.l1dist(a,b)
end