import Distances.pairwise!
import Distances.pairwise
import Distances.colwise!
import Distances.colwise
import Distances.evaluate

## Generic distance evaluation
#define Abstract type Distance
abstract type Distance end
struct sql2 <: Distance end
struct l2 <: Distance end
struct l1 <: Distance end
evaluate(::sql2, a::AbstractVector{T}, b::AbstractVector{T}) where {T} = sql2dist(a,b)
evaluate(::l2, a::AbstractVector{T}, b::AbstractVector{T}) where {T} = l2dist(a,b)
evaluate(::l1, a::AbstractVector{T}, b::AbstractVector{T}) where {T} = l1dist(a,b)

#Columnwise distances
function colwise!(d::AbstractVector{<:AbstractFloat}, dm::Distance, x::AbstractMatrix{T}, y::AbstractMatrix{T}) where {T}
    @inbounds @views Threads.@threads for i ∈ axes(y,2)
        d[i] = evaluate(dm, x[:,i], y[:,i])
    end
end

function colwise!(d::AbstractVector{<:AbstractFloat}, dm::Distance, x::AbstractVector{T}, y::AbstractMatrix{T}) where {T}
    @inbounds @views Threads.@threads for i ∈ axes(y,2)
        d[i] = evaluate(dm,x,y[:,i])
    end
end

function colwise(dm::Distance, x::AbstractVecOrMat{T}, y::AbstractMatrix{T}) where {T}
    d = Vector{T}(undef,size(y,2))
    colwise!(d,dm,x,y)
    return d
end


#Pairwise distances
function pairwise!(d::AbstractVector{<:AbstractFloat}, dm::Distance, x::AbstractVector{T}, y::AbstractMatrix{T}) where {T}
    @inbounds @views Threads.@threads for i ∈ axes(y,2)
        d[i] = evaluate(dm, x, y[:,i])
    end
end

pairwise!(d::AbstractVector{<:AbstractFloat}, dm::Distance, x::AbstractMatrix{T}, y::AbstractVector{T}) where {T} = pairwise!(d,dm,y,x)

function pairwise!(d::AbstractMatrix{<:AbstractFloat}, dm::Distance, x::AbstractMatrix{T}, y::AbstractMatrix{T}) where {T}
    @inbounds @views Threads.@threads for i ∈ axes(x,2)
        for j ∈ axes(y,2)
            d[i,j] = evaluate(dm, x[:,i], y[:,j])
        end
    end
end

function pairwise(dm::Distance, x::AbstractVector{T}, y::AbstractMatrix{T}) where {T}
    d = Vector{T}(undef,size(y,2))
    pairwise!(d,dm,x,y)
    return d
end

pairwise(dm::Distance, x::AbstractMatrix{T}, y::AbstractVector{T}) where {T} = pairwise(dm,y,x)

function pairwise(dm::Distance, x::AbstractMatrix{T}, y::AbstractMatrix{T}) where {T}
    d = Matrix{T}(undef,size(x,2),size(y,2))
    pairwise!(d,dm,x,y)
    return d
end