using Test: @test

using Nucleus

# ---- #

for (nu_, re) in (([1, 2, 3], [-1, 0, 1]), ([1, 2, 3.0], [-1, 0, 1.0]))

    co = copy(nu_)

    Nucleus.Normalization.update_0_clamp!(co)

    @test eltype(co) == eltype(re)

    @test co == re

end

# ---- #

for (n1_, re) in (
    ([-1, 2, 3.0], [0, 0.5, 1]),
    ([-1, -1, 2, 3.0], [0, 0, 0.6000000000000001, 1]),
    ([-1, 2, 2, 3.0], [0, 0.5, 0.5, 1]),
    ([-1, 2, 3, 3.0], [0, 0.4, 1, 1]),
)

    n2_ = Nucleus.Normalization.make_125254_01(n1_)

    @test eltype(n2_) == eltype(re)

    @test n2_ == re

end
