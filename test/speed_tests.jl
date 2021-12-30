using BenchmarkTools
using VectorDataUtils


#Non vectorised Lp norms and metrics

l2inner_alt(x,y) = sum(x.*y)
# sql2norm_alt(x) = sum(x.*x)
l2norm_alt(x) = sqrt(sum(x.*x))
sql2dist_alt(x,y) = sum((x-y).*(x-y))
l2dist_alt(x,y) = sqrt(sql2dist(x,y))
l1norm_alt(x) = sum(abs.(x))
l1dist_alt(x,y) = sum(abs.(x-y))

function sql2norm_alt(a::AbstractVector{T}) where {T}
    s = zero(T)
    @simd for i ∈ eachindex(a)
        s += a[i] * a[i]
    end
    return s
end



function return_alt(f1::Function)
    f2_sym = Symbol(String(Symbol(f1))*"_alt")
    f2 = getfield(Main,f2_sym)
    return f2
end



f1 = l1norm

ndim = 15
Ftype = Float32
x = randn(Ftype,ndim)
y = randn(Ftype,ndim)
ip = (x,)


f2 = return_alt(f1)
m1 = median(@benchmark f1(ip...))
m2 = median(@benchmark f2(ip...))
f1(ip...) ≈ f2(ip...)
judge(m1,m2)

function fmatch(f1::Function,ip)
    f2 = return_alt(f1)
    return f1(ip...) ≈ f2(ip...)
end

function fcomp(f1::Function,ip)
    f2 = return_alt(f1)
    b1 = @benchmarkable f1(ip...)
    b2 = @benchmarkable f2(ip...)
    tune!(b1)
    tune!(b2)
    t1 = run(b1)
    t2 = run(b2)
    m1 = median(t1)
    m2 = median(t2)
    return m1,m2
end

function bench_median(f::Function,ip)
    b1 = @benchmark f(ip...)
    return median(b1)
end