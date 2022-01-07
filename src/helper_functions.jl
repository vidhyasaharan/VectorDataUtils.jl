#get cumulative distribution (discrete) from scaled/unnormalised probability distribution (discrete)
function pdist2cdist(pdist::AbstractVector{T}) where {T}
    cdist = Vector{T}(undef,length(pdist))
    cdist[1] = pdist[1]
    @views for i ∈ 2:length(pdist)
        cdist[i] = cdist[i-1] + pdist[i]
    end
    K = 1/cdist[end]
    @turbo for i ∈ eachindex(cdist)
        cdist[i] *= K
    end
    return cdist
end


# Find index of closest element of data array to input x (same as argmin(abs.(data.-x)) but faster)
function findclosest(x::T, data::AbstractVector{T}) where T<:Real
    d = zero(T)
    mindx::Int = 1
    mmag::T = Inf
    @inbounds @views for i ∈ eachindex(data)
        d = abs(data[i] - x)
        if(d<mmag)
            mmag = d
            mindx = i
        end 
    end
    return mindx
end
