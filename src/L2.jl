#Dot product using LoopVectorization (real ⋅ real)
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
function l2inner(a::AbstractVector{T}) where {T}
    s = zero(T)
    @turbo for i ∈ eachindex(a)
        s += a[i] * a[i]
    end
    return s
end

sql2norm(a::AbstractVector{T}) where {T} = l2inner(a)

l2norm(a::AbstractVector{T}) where {T} = sqrt(l2inner(a))

#L2 Distance square using LoopVectorization (real)
function sql2dist(a::AbstractVector{T}, b::AbstractVector{T}) where {T}
    s = zero(T)
    @turbo for i ∈ eachindex(a,b)
        t = a[i] - b[i]
        s += t * t
    end
    return s
end

l2dist(a::AbstractVector{T}, b::AbstractVector{T}) where {T} = sqrt(sql2dist(a,b))


#Vector Multiplication (in place)
function mulavx!(a::AbstractVector{T}, b::AbstractVector{T}) where {T}
    @turbo for i ∈ eachindex(a,b)
        a[i] *= b[i]
    end
end

#computes Quadratic term - x'Ax 
function xAxavx(x::AbstractVector{T}, A::AbstractMatrix{T}) where {T}
    s = zero(T)
    @turbo for i ∈ eachindex(x), j ∈ eachindex(x)
        s += x[i]*x[j]*A[j,i]
    end
    return s
end

#computes Mahalanobis distance (x-y)'A(x-y)
function mahalavx(x::AbstractVector{T}, y::AbstractVector{T}, A::AbstractMatrix{T}) where {T}
    s = zero(T)
    @turbo for i ∈ eachindex(x,y), j ∈ eachindex(x,y)
        Ti = x[i] - y[i]
        Tj = x[j] - y[j]
        s += Ti*Tj*A[j,i]
    end
    return s
end