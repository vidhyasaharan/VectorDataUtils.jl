@testset "Distance" begin
    a = randn(Float,10)
    b = randn(Float,10)
    c1 = [a b a b]
    c2 = [a b]
    c3 = [a b b b]

    @test VectorDataUtils.sql2 <: VectorDataUtils.Distance
    @test VectorDataUtils.l2 <: VectorDataUtils.Distance
    @test VectorDataUtils.l1 <: VectorDataUtils.Distance

    @test VectorDataUtils.evaluate(VectorDataUtils.sql2(),a,b) ≈ VectorDataUtils.sql2dist(a,b)
    @test VectorDataUtils.evaluate(VectorDataUtils.l2(),a,b) ≈ VectorDataUtils.l2dist(a,b)
    @test VectorDataUtils.evaluate(VectorDataUtils.l1(),a,b) ≈ VectorDataUtils.l1dist(a,b)

    distances = (VectorDataUtils.sql2(), VectorDataUtils.l2(), VectorDataUtils.l1())
    for dm ∈ distances

        d = VectorDataUtils.colwise(dm,c1,c3)
        @test length(d) == size(c1,2)
        @test d[1] == 0.0
        @test d[2] == 0.0
        @test d[3] == VectorDataUtils.evaluate(dm,a,b)

        d = VectorDataUtils.colwise(dm,a,c1)
        @test length(d) == size(c1,2)
        @test d[1] == 0.0
        @test d[2] == VectorDataUtils.evaluate(dm,a,b)
        @test d[3] == 0.0
        @test d[4] == d[2]


        d = VectorDataUtils.pairwise(dm,a,c1)
        @test length(d) == size(c1,2)
        @test d[1] == 0.0
        @test d[2] == VectorDataUtils.evaluate(dm, a, b)

        d = VectorDataUtils.pairwise(dm,c1,a)
        @test length(d) == size(c1,2)
        @test d[3] == 0.0
        @test d[4] == VectorDataUtils.evaluate(dm, a, b)

        dd = VectorDataUtils.pairwise(dm, c2, c1)
        @test size(dd,1) == size(c2,2)
        @test size(dd,2) == size(c1,2)
        @test dd[1,1] == 0.0
        @test dd[2,2] == 0.0
        @test dd[1,2] == VectorDataUtils.evaluate(dm, a, b)
        @test dd[2,1] == VectorDataUtils.evaluate(dm, b, a)
    end
end