module Normalization

using ..Nucleus

function update_0_clamp!(nu_, st = 3)

    if allequal(nu_)

        @warn "All $(nu_[1])."

        fill!(nu_, 0)

    else

        clamp!(Nucleus.RangeNormalization.update_0!(nu_), -st, st)

    end

end

function make_125254_01(nu_)

    Nucleus.RangeNormalization.update_01!(Nucleus.RankNormalization.make_125254(nu_))

end

end
