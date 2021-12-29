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

#computes Mahalanobis distance (x-y)'A(x-y)
"""
    mahaldist(x,y,A)

Compute the Mahalanobis distance between two real vectors `x` and `y` given a square matrix `A`. Mahalanobis distance is given by ``(x-y)'A(x-y)``. Dimensions of `x`, `y` and `A` must match.
"""
function mahaldist(x::AbstractVector{T}, y::AbstractVector{T}, A::AbstractMatrix{T}) where {T}
    s = zero(T)
    @turbo for i ∈ eachindex(x,y), j ∈ eachindex(x,y)
        Ti = x[i] - y[i]
        Tj = x[j] - y[j]
        s += Ti*Tj*A[j,i]
    end
    return s
end