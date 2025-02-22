module Significance

using MultipleTesting: BenjaminiHochberg, adjust

function make(u1, u2)

    (iszero(u2) ? 1 : u2) / u1

end

function make(eq, n1_, n2_)

    if isempty(n2_)

        return Float64[], Float64[]

    end

    pv_ = map(nu -> make(lastindex(n1_), count(eq(nu), n1_)), n2_)

    pv_, adjust(pv_, BenjaminiHochberg())

end

end
