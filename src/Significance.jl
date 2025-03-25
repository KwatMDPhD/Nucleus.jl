module Significance

using MultipleTesting: BenjaminiHochberg, adjust

using ..Nucleus

function make(u1::Integer, u2)

    (iszero(u1) ? 1 : u1) / u2

end

function make(eq, nu_, ra_)

    pv_ = map(nu -> make(count(eq(nu), ra_), lastindex(ra_)), nu_)

    pv_, adjust(pv_, BenjaminiHochberg())

end

function make(nu_, ra_)

    i1_ = findall(<(0), nu_)

    i2_ = findall(>=(0), nu_)

    r1_, r2_ = Nucleus.Numbe.ge(ra_)

    p1_, q1_ = isempty(i1_) ? (Float64[], Float64[]) : make(<=, nu_[i1_], r1_)

    p2_, q2_ = isempty(i2_) ? (Float64[], Float64[]) : make(>=, nu_[i2_], r2_)

    vcat(i1_, i2_), vcat(p1_, p2_), vcat(q1_, q2_)

end

end
