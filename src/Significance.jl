module Significance

using MultipleTesting: BenjaminiHochberg, adjust

using ..Nucleus

# TODO: Go Bayesian

function make(fu, nu_, ra_)

    u1 = inv(lastindex(ra_))

    pv_ = map(nu_) do nu

        u2 = count(fu(nu), ra_)

        if iszero(u2)

            u2 = 1

        end

        u1 * u2

    end

    pv_, adjust(pv_, BenjaminiHochberg())

end

function make(fu, nu_, in_, ra_)

    if isempty(in_)

        Float64[], Float64[]

    elseif isempty(ra_)

        um = lastindex(in_)

        fill(NaN, um), fill(NaN, um)

    else

        make(fu, nu_[in_], ra_)

    end

end

function make(nu_, ra_)

    i1_ = findall(<(0), nu_)

    i2_ = findall(>=(0), nu_)

    r1_, r2_ = Nucleus.Numbe.ge(ra_)

    p1_, q1_ = make(<=, nu_, i1_, r1_)

    p2_, q2_ = make(>=, nu_, i2_, r2_)

    vcat(i1_, i2_), vcat(p1_, p2_), vcat(q1_, q2_)

end

end
