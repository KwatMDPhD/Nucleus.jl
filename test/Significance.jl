using Test: @test

using Nucleus

include("_.jl")

# ---- #

for (um, re) in ((0, 0.1), (1, 0.1), (2, 0.2))

    @test Nucleus.Significance.make(um, 10) === re

end

# ---- #

const NU_ = [-1, -0.0, 0, 1]

const RA_ = [-4, -3, -2, -1, -0.0, 0, 1, 2, 3, 4]

# ---- #

# 146.084 ns (11 allocations: 512 bytes)
# 154.131 ns (11 allocations: 512 bytes)
# 31.071 ms (19 allocations: 47.66 KiB)

const PV_ = [0.4, 0.6, 0.6, 0.7]

const QV_ = [0.7, 0.7, 0.7, 0.7]

for (eq, nu_, ra_, re) in (
    (<=, NU_, RA_, (PV_, QV_)),
    (>=, NU_, RA_, (reverse(PV_), QV_)),
    (<=, randn(1000), randn(100000), nothing),
)

    @test isnothing(re) || is_egal(Nucleus.Significance.make(eq, nu_, ra_), re)

    #@btime Nucleus.Significance.make($eq, $nu_, $ra_)

end

# ---- #

# 435.187 ns (42 allocations: 1.67 KiB)
# 15.753 ms (95 allocations: 1.67 MiB)

for (nu_, ra_, re) in (
    (NU_, RA_, ([1, 2, 3, 4], [1, 1, 1, 2 / 3], [1, 1, 1, 1.0])),
    (randn(1000), randn(100000), nothing),
)

    @test isnothing(re) || is_egal(Nucleus.Significance.make(nu_, ra_), re)

    #@btime Nucleus.Significance.make($nu_, $ra_)

end
