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

 