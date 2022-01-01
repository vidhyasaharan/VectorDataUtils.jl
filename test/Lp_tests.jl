@testset "l2inner" begin
    ndim = 10
    a = rand(Float,ndim)
    b = rand(Float,ndim)
    ca = rand(Complex{Float},ndim)
    cb = rand(Complex{Float},ndim)
    @test a⋅b ≈ VectorDataUtils.l2inner(a,b)
    @test a⋅cb ≈ VectorDataUtils.l2inner(a,cb)
    @test ca⋅b ≈ VectorDataUtils.l2inner(ca,b)
    @test ca⋅cb ≈ VectorDataUtils.l2inner(ca,cb)
    @test a⋅a ≈ VectorDataUtils.l2inner(a)
    @test a⋅a ≈ VectorDataUtils.sql2norm(a)
    @test sqrt(a⋅a) ≈ VectorDataUtils.l2norm(a)
end

@testset "l2dist" begin
    ndim = 10
    a = rand(Float,ndim)
    b = rand(Float,ndim)
    @test (a-b)⋅(a-b) ≈ VectorDataUtils.sql2dist(a,b)
    @test sqrt(sum(abs2,a-b)) ≈ VectorDataUtils.l2dist(a,b)
end

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