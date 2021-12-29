#computes Quadratic term - x'Ax 
function xAx(x::AbstractVector{T}, A::AbstractMatrix{T}) where {T}
    s = zero(T)
    @turbo for i ∈ eachindex(x), j ∈ eachindex(x)
        s += x[i]*x[j]*A[j,i]
    end
    return s
end

#computes Mahalanobis distance (x-y)'A(x-y)
function mahaldist(x::AbstractVector{T}, y::AbstractVector{T}, A::AbstractMatrix{T}) where {T}
    s = zero(T)
    @turbo for i ∈ eachindex(x,y), j ∈ eachindex(x,y)
        Ti = x[i] - y[i]
        Tj = x[j] - y[j]
        s += Ti*Tj*A[j,i]
    end
    return s
end