using Test: @test

using Nucleus

include("_.jl")

# ---- #

for (nu_, re) in (([1, 2, 3], [-1, 0, 1]), ([1, 2, 3.0], [-1, 0, 1.0]))

    Nucleus.Normalization.update_0_clamp!(nu_)

    @test is_egal(nu_, re)

end

# ---- #

for (nu_, re) in (
    ([-1, 2, 3], [0, 0.5, 1]),
    ([-1, -1, 2, 3], [0, 0, 0.6000000000000001, 1]),
    ([-1, 2, 2, 3], [0, 0.5, 0.5, 1]),
    ([-1, 2, 3, 3], [0, 0.4, 1, 1]),
)

    @test is_egal(Nucleus.Normalization.make_125254_01(nu_), re)

end
