#L1 Norm of real vectors
"""
    l1norm(a)

Compute the l1 norm of a real valued vector `a`.
"""
function l1norm(a::AbstractVector{T}) where {T}
    s = zero(T)
    @turbo for i ∈ eachindex(a)
        s += abs(a[i])
    end
    return s
end

#L1 distance between real vectors
"""
    l1dist(a,b)

Compute the l1 distance between two real vectors `a` and `b`. The lengths of `a` and `b` must match.
"""
 function l1dist(a::AbstractVector{T}, b::AbstractVector{T}) where {T}
    s = zero(T)
    @turbo for i ∈ eachindex(a,b)
        t = a[i] - b[i]
        s += abs(t)
    end
    return s
 end