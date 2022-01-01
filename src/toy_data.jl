#Generate 2D data from 4 spherical (σ=0.25) gaussian clusters centered at [-1,1], [1,-1], [-1,1] and [1,1]
"""
    generate_4_clusters(npts_per_cluster; σ=0.25)
    generate_4_clusters(::DataType, npts_per_cluster; σ=0.25)

Generate 2D data from 4 spherical gaussian clusters, with standard deviation `σ`, centered at [-1,1], [1,-1], [-1,1] and [1,1]. `DataType` can be `Float32` or `Float64`, default is `Float64`.
"""
function generate_4_clusters(T::DataType, npts_per_cluster; σ = 0.25)
    c = convert(Matrix{T},[1 1 -1 -1; 1 -1 1 -1])
    data = Matrix{T}(undef,2,4*npts_per_cluster)
    for i ∈ axes(c,2)
        rpts = randn(T,(2,npts_per_cluster))
        sindx = (i-1)*npts_per_cluster+1
        eindx = i*npts_per_cluster
        data[:,sindx:eindx] = σ*rpts .+ c[:,i]
    end
    return data
end

generate_4_clusters(npts_per_cluster; σ = 0.25) = generate_4_clusters(Float64, npts_per_cluster; σ)


#Generate 2D data arranged in a circle (default radius, r =0.5) around centres at [-1,1], [1,-1], [-1,1] and [1,1]
"""
    generate_4_circle_clusters(npts_per_cluster = 8; r = 0.5)
    generate_4_circle_clusters(::DataType, npts_per_cluster = 8; r = 0.5)

Generate 2D data arranged in a circle (default radius, r =0.5) around centres at [-1,1], [1,-1], [-1,1] and [1,1]. `DataType` can be `Float32` or `Float64`, default is `Float64`.
"""
function generate_4_circle_clusters(T::DataType, npts_per_cluster::Int = 8; r = 0.5)
    c = convert(Matrix{T},[1 1 -1 -1; 1 -1 1 -1])
    data = Matrix{T}(undef,2,4*npts_per_cluster)
    for i ∈ axes(c,2)
        sindx = (i-1)*npts_per_cluster+1
        eindx = i*npts_per_cluster
        pts = generate_circle_cluster(npts_per_cluster)
        data[:,sindx:eindx] = r*pts .+ c[:,i]
    end
    return data
end

generate_4_circle_clusters(npts_per_cluster::Int = 8; r = 0.5) = generate_4_circle_clusters(Float64, npts_per_cluster; r)


#Generate 2D data arranged in a circle of radius one around [0,0]
"""
    generate_circle_cluster(npts = 8)
    generate_circle_cluster(::DataType, npts = 8)

Generate 2D data arranged in a circle of radius one around [0,0]. `DataType` can be `Float32` or `Float64`, default is `Float64`.
"""
function generate_circle_cluster(T::DataType, npts::Int = 8)
    Δθ = 2π/npts
    θ = 0:Δθ:2π-Δθ
    x = Matrix{T}(undef,2,npts)
    for i ∈ eachindex(θ)
        x[1,i] = cos(θ[i])
        x[2,i] = sin(θ[i])
    end
    return x
end

generate_circle_cluster(npts::Int = 8) = generate_circle_cluster(Float64, npts)