#Running mean
"""
    running_mean!(m, x)

Compute (in-place) the mean, `m`, of a set of vectors, `x`.
* `x` must be a matrix of Floats, with each column of `x` corresponding to a vector.
* `m` must be a vector of Floats of appropriate length (equal to the number of rows in `x`).
"""
function running_mean!(m::AbstractVector{T}, x::AbstractMatrix{T}) where T<:AbstractFloat
    k = zero(T)
    fill!(m,zero(T))
    @inbounds for j ∈ axes(x,2)
        k = 1/j
        @turbo for i ∈ axes(x,1)
            temp = (x[i,j] - m[i])
            m[i] += temp*k
        end
    end
end

"""
    running_mean(x)

Compute the mean of a set of vectors `x`.
* `x` must be a matrix of Floats, with each column of `x` corresponding to a vector.
"""
function running_mean(x::AbstractMatrix{T}) where T<:AbstractFloat
    m = zeros(T,size(x,1))
    running_mean!(m, x)
    return m
end


#Update running mean with a nth data point where n is the running index
"""
    update_running_mean!(m, x, n)

Update the mean, `m`, of some set of `n-1` vectors to be the mean of the set of `n` vectors where `x` is the ``n^th`` vector.
* `m` and `x` must be vectors of equal length.
* Typically used when the mean of a part of a dataset has been previously computed and needs to be updated with a new data point (vector).
"""
function update_running_mean!(mean::AbstractVector{T}, data::AbstractVector{T}, n::Int) where T<:AbstractFloat
    k = 1/n
    @inbounds @turbo for i ∈ eachindex(mean)
        temp = (data[i] - mean[i])*k
        mean[i] += temp
    end
end



#Running mean and variance
"""
    running_meanvar!(m, v, x)

Compute (in-place) the mean, `m`, and variance along each dimension, `v`, of a set of vectors, `x`.
* `x` must be a matrix of Floats, with each column of `x` corresponding to a vector.
* `m` must be a vector of Floats of appropriate length (equal to the number of rows in `x`).
* `v` must be a vector of Floats of appropriate length (equal to the number of rows in `x`).
"""
function running_meanvar!(m::AbstractVector{T}, v::AbstractVector{T}, x::AbstractMatrix{T}) where T<:AbstractFloat
    k = zero(T)
    fill!(m,zero(T))
    fill!(v,zero(T))
    @inbounds for j ∈ axes(x,2)
        k = 1/j
        @inbounds for i ∈ axes(x,1)
            temp = (x[i,j] - m[i])
            m[i] += temp*k
            v[i] += temp*(x[i,j] - m[i])
        end
    end
    N = 1/(size(x,2)-1)
    @turbo for i ∈ eachindex(v)
        v[i] *= N
    end
end

"""
    running_meanvar(x)

Compute the mean and variance along each dimension of a set of vectors, `x`.
* `x` must be a matrix of Floats, with each column of `x` corresponding to a vector.
"""
function running_meanvar(x::AbstractMatrix{T}) where T<:AbstractFloat
    m = zeros(T,size(x,1))
    v = zeros(T,size(x,1))
    running_meanvar!(m,v,x)
    return m, v
end


#Update running mean and variance with a nth data point where n is the running index
"""
    update_running_meanvar!(m, v, x, n)

Update the mean, `m`, and variance along each dimension, `v`, of some set of `n-1` vectors to be the mean and variance of the set of `n` vectors where `x` is the ``n^th`` vector (for `n>=3`).
* `m`, `v` and `x` must be vectors of equal length.
* Typically used when the mean and variance of a part of a dataset has been previously computed and needs to be updated with a new data point (vector).

!!! note
    `n` must be 3 or greater.
    [`running_meanvar()`](@ref) or [`running_meanvar!()`](@ref) can be used to obtain an initial estimate of `m` and `v` from at least two vectors.
"""
function update_running_meanvar!(m::AbstractVector{T}, v::AbstractVector{T}, x::AbstractVector{T}, n::Int) where T<:AbstractFloat
    n >=3 || error("n must be greater than 2. Use running_meanvar() to obtain an initial estimate of mean and variance from at least two vectors before using update_running_meanvar() to update the estimates.")
    k = 1/n
    k1 = 1/(n-1)
    @inbounds for i ∈ eachindex(m,v,x)
        temp = (x[i] - m[i])
        m[i] += temp*k
        v[i] *= (n-2)
        v[i] += temp*(x[i] - m[i])
        v[i] *= k1
    end
end



#running mean and covariance
"""
    running_meancov!(m, C, x)

Compute (in-place) the mean, `m`, and covariance matrix, `C`, of a set of vectors, `x`.
* `x` must be a matrix of Floats, with each column of `x` corresponding to a vector.
* `m` must be a vector of Floats of appropriate length (equal to the number of rows in `x`).
* `C` must be a square matrix of Floats of appropriate size (side equal to the number of rows in `x`).
"""
function running_meancov!(m::AbstractVector{T}, C::AbstractMatrix{T}, x::AbstractMatrix{T}) where T<:AbstractFloat
    k = zero(T)
    temp = Vector{T}(undef,length(m))
    fill!(m,zero(T))
    fill!(C,zero(T))
    @inbounds for n ∈ axes(x,2)
        k = 1/n
        @turbo for i ∈ axes(x,1)
            temp[i] = (x[i,n] - m[i])
            m[i] += temp[i]*k
        end
        @turbo for i ∈ axes(x,1), j ∈ axes(x,1)
            C[j,i] += (x[j,n] - m[j])*temp[i]
        end
    end
    N = 1/(size(x,2)-1)
    @turbo for i ∈ eachindex(C)
        C[i] *= N
    end
    C += C'
    C /= 2
end


"""
    running_meancov(x)

Compute the mean and covariance matrix a set of vectors, `x`.
* `x` must be a matrix of Floats, with each column of `x` corresponding to a vector.
"""
function running_meancov(x::AbstractMatrix{T}) where T<:AbstractFloat
    m = Vector{T}(undef,size(x,1))
    C = Matrix{T}(undef,size(x,1),size(x,1))
    running_meancov!(m,C,x)
    return m, C
end


#Update running mean and covariance with a nth data point where n is the running index
"""
    update_running_meancov!(m, C, x, n)

Update the mean, `m`, and covariance, `C`, of some set of `n-1` vectors to be the mean and variance of the set of `n` vectors where `x` is the ``n^th`` vector (for `n>=3`).
* `m` and `x` must be vectors of equal length.
* `C` must be a square matrix of side equal to the length of `x`.
* Typically used when the mean and covariance of a part of a dataset has been previously computed and needs to be updated with a new data point (vector).

!!! note
    `n` must be 3 or greater.
    [`running_meancov()`](@ref) or [`running_meanvcov!()`](@ref) can be used to obtain an initial estimate of `m` and `v` from at least two vectors.
"""
function update_running_meancov!(m::AbstractVector{T}, C::AbstractMatrix{T}, x::AbstractVector{T}, n::Int) where T<:AbstractFloat
    n >=3 || error("n must be greater than 2. Use running_meanvar() to obtain an initial estimate of mean and variance from at least two vectors before using update_running_meanvar() to update the estimates.")
    k = 1/n
    k1 = 1/(n-1)
    temp = Vector{T}(undef,length(m))
    @turbo for i ∈ eachindex(x)
        temp[i] = (x[i] - m[i])
        m[i] += temp[i]*k
    end
    @turbo for i ∈ eachindex(x), j ∈ eachindex(x)
        C[j,i] *= (n-2)
        C[j,i] += (x[j] - m[j])*temp[i]
        C[j,i] *= k1
    end
    C += C'
    C /= 2
end