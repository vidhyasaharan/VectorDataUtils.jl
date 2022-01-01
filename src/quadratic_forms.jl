#Generate a random positive definite matrix
"""
    randposdefmatrix(D)

Generate a random ``DxD`` positive definite matrix. Use `randposdefmatrix(Float64,D)` or `randposdefmatrix(Float32,D)` to specify Float data type.
"""
function randposdefmatrix(Ftype::DataType, ndim::Int)
    a = randn(Ftype,ndim,ndim)
    A = a*a' + LinearAlgebra.I(ndim)
    return A
end

randposdefmatrix(ndim::Int) = randposdefmatrix(Float64,ndim)

#computes Quadratic term - x'Ax
"""
    xAx(x,A)

Compute the scalar quadratic term x'Ax given a real vector `x` and a square matrix `A`. The dimensions of `x` and `A` must match.
"""
function xAx(x::AbstractVector{T}, A::AbstractMatrix{T}) where {T}
    s = zero(T)
    @turbo for i ∈ eachindex(x), j ∈ eachindex(x)
        s += x[i]*x[j]*A[j,i]
    end
    return s
end

#computes Square Mahalanobis distance (x-y)'A(x-y)
"""
    sqmahaldist(x,y,A)

Compute the square of the Mahalanobis distance between two real vectors `x` and `y` given a positive semidefinite matrix `A`. Dimensions of `x`, `y` and `A` must match. Square of the Mahalanobis distance is given by ``(x-y)'A(x-y)``.
"""
function sqmahaldist(x::AbstractVector{T}, y::AbstractVector{T}, A::AbstractMatrix{T}) where {T}
    s = zero(T)
    @turbo for i ∈ eachindex(x,y), j ∈ eachindex(x,y)
        Ti = x[i] - y[i]
        Tj = x[j] - y[j]
        s += Ti*Tj*A[j,i]
    end
    return s
end


"""
    mahaldist(x,y,A)

Compute the Mahalanobis distance between two real vectors `x` and `y` given a positive semidefinite matrix `A`. Dimensions of `x`, `y` and `A` must match. Mahalanobis distance is given by ``sqrt((x-y)'A(x-y))``.
"""
mahaldist(x::AbstractVector{T}, y::AbstractVector{T}, A::AbstractMatrix{T}) where {T} = sqrt(sqmahaldist(x,y,A))