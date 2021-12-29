#Dot product using LoopVectorization (real ⋅ real)
"""
    l2inner(a,b)

Computes the inner product in the l2 vector space (dot product) between Real or Complex vectors `a` and `b`. The lenghts of `a` and `b` must match.

See also [`l2norm`](@ref), [`l2dist`](@ref), [`sql2norm`](@ref), [`sql2dist`](@ref).

# Example
```jldoctest
a = [1,2,3]
b = [2,0,4]
l2inner(a,b)

# output

14
```
"""
function l2inner(a::AbstractVector{T}, b::AbstractVector{T}) where {T}
    s = zero(T)
    @turbo for i ∈ eachindex(a,b)
        s += a[i] * b[i]
    end
    return s
end

#Dot product using LoopVectorization (real ⋅ complex)
function l2inner(a::AbstractVector{T}, cb::AbstractVector{Complex{T}}) where {T}
    re = zero(T)
    im = zero(T)
    b = reinterpret(reshape, T, cb)
    @turbo for i ∈ eachindex(a)
        re += a[i] * b[1,i]
        im += a[i] * b[2,i]
    end
    return Complex(re, im)
end

#Dot product using LoopVectorization (real ⋅ complex)
function l2inner(ca::AbstractVector{Complex{T}}, b::AbstractVector{T}) where {T}
    re = zero(T)
    im = zero(T)
    a = reinterpret(reshape, T, ca)
    @turbo for i ∈ eachindex(b)
        re += a[1,i] * b[i]
        im += - (a[2,i] * b[i])
    end
    return Complex(re, im)
end

#Dot product using LoopVectorization (complex ⋅ complex)
function l2inner(ca::AbstractVector{Complex{T}}, cb::AbstractVector{Complex{T}}) where {T}
    re = zero(T)
    im = zero(T)
    a = reinterpret(reshape, T, ca)
    b = reinterpret(reshape, T, cb)
    @turbo for i ∈ axes(a,2) #Conjugate(a) × b
        re += (a[1,i] * b[1,i]) + (a[2,i] * b[2,i])
        im += (a[1,i] * b[2,i]) - (a[2,i] * b[1,i])
    end
    return Complex(re, im)
end


#L2 Norm square using LoopVectorization (real)
"""
    l2inner(a)

Computes the inner product in the l2 vector space (dot product) of the Real or Complex vectors `a` with itself. i.e., the Squared l2 norm of `a`. This is identical to calling `sql2norm(a)`.
"""
function l2inner(a::AbstractVector{T}) where {T}
    s = zero(T)
    @turbo for i ∈ eachindex(a)
        s += a[i] * a[i]
    end
    return s
end

"""
    sql2norm(a)

Compute the square of the l2 norm of a real or complex vector `a`. This is identical to calling `l2inner(a)`.
"""
sql2norm(a::AbstractVector{T}) where {T} = l2inner(a)

"""
    l2norm(a)

Compute the l2 norm of a real valued vector `a`.
"""
l2norm(a::AbstractVector{T}) where {T} = sqrt(l2inner(a))

#L2 Distance square using LoopVectorization (real)
"""
    sql2dist(a,b)

Compute the square of the l2 distance between two real vectors `a` and `b`. The lengths of `a` and `b` must match.
"""
function sql2dist(a::AbstractVector{T}, b::AbstractVector{T}) where {T}
    s = zero(T)
    @turbo for i ∈ eachindex(a,b)
        t = a[i] - b[i]
        s += t * t
    end
    return s
end

"""
    l2dist(a,b)

Compute the l2 distance between two real vectors `a` and `b`. The lengths of `a` and `b` must match.
"""
l2dist(a::AbstractVector{T}, b::AbstractVector{T}) where {T} = sqrt(sql2dist(a,b))


#Vector Multiplication (in place)
function mulavx!(a::AbstractVector{T}, b::AbstractVector{T}) where {T}
    @turbo for i ∈ eachindex(a,b)
        a[i] *= b[i]
    end
end