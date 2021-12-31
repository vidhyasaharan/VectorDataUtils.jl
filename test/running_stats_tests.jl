@testset "running_mean" begin
    ndim = 20
    npts = 10000
    x = randn(Float,ndim,npts)
    m = Vector{Float}(undef,ndim)
    VectorDataUtils.running_mean!(m,x)
    @test mean(x,dims=2) ≈ m
    @test mean(x,dims=2) ≈ VectorDataUtils.running_mean(x)
end

@testset "update_running_mean!" begin
    ndim = 20
    npts = 10000
    x = randn(Float,ndim,npts)
    m = zeros(Float,ndim)
    for i ∈ axes(x,2)
        VectorDataUtils.update_running_mean!(m,x[:,i],i)
        # @test mean(x[:,1:i],dims=2) ≈ m
    end
    @test mean(x,dims=2) ≈ m
end

@testset "running_meanvar" begin
    ndim = 20
    npts = 10000
    x = randn(Float,ndim,npts)
    m̂ = Vector{Float}(undef,ndim)
    v̂ = Vector{Float}(undef,ndim)
    VectorDataUtils.running_meanvar!(m̂,v̂,x)
    m,v = VectorDataUtils.running_meanvar(x)
    @test mean(x,dims=2) ≈ m̂
    @test var(x,dims=2) ≈ v̂
    @test mean(x,dims=2) ≈ m
    @test var(x,dims=2) ≈ v
end

@testset "update_running_meanvar!" begin
    ndim = 20
    npts = 10000
    x = randn(Float,ndim,npts)
    m,v = VectorDataUtils.running_meanvar(x[:,1:2])
    # m = mean(x[:,1:2],dims=2)
    # v = var(x[:,1:2],dims=2)
    for i ∈ 3:size(x,2)
        VectorDataUtils.update_running_meanvar!(m,v,x[:,i],i)
        # @test mean(x[:,1:i],dims=2) ≈ m
        # @test var(x[:,1:i],dims=2) ≈ v
    end
    @test mean(x,dims=2) ≈ m
    @test var(x,dims=2) ≈ v
end


@testset "running_meancov" begin
    ndim = 20
    npts = 10000
    x = randn(Float,ndim,npts)
    m̃ = Vector{Float}(undef,ndim)
    C̃ = Matrix{Float}(undef,ndim,ndim)
    VectorDataUtils.running_meancov!(m̃,C̃,x)
    m,C = VectorDataUtils.running_meancov(x)
    m̂ = mean(x,dims=2)
    Ĉ = ((x.-m̂)*(x.-m̂)')/(size(x,2)-1)
    @test m̂ ≈ m̃
    @test Ĉ ≈ C̃
    @test m̂ ≈ m
    @test Ĉ ≈ C
end

@testset "update_running_meancov!" begin
    ndim = 20
    npts = 10000
    x = randn(Float,ndim,npts)
    m,C = VectorDataUtils.running_meancov(x[:,1:2])
    for i ∈ 3:size(x,2)
        VectorDataUtils.update_running_meancov!(m,C,x[:,i],i)
    end
    m̂ = mean(x,dims=2)
    Ĉ = ((x.-m̂)*(x.-m̂)')/(size(x,2)-1)
    @test m̂ ≈ m
    @test Ĉ ≈ C
end