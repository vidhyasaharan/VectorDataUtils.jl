@testset "Quadratic Forms" begin
    ndim = 10
    A = randn(Float,ndim,ndim)
    x = randn(Float,ndim)
    y = randn(Float,ndim)
    q = x'*A*x
    d = (x-y)'*A*(x-y)
    @test VectorDataUtils.xAx(x,A) ≈ q
    @test VectorDataUtils.mahaldist(x,y,A) ≈ d
end