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

# 92.875 ns (11 allocations: 512 bytes)
# 98.075 ns (11 allocations: 512 bytes)
# 22.230 ms (19 allocations: 48.41 KiB)

const PV_ = [0.4, 0.6, 0.6, 0.7]

const QV_ = [0.7, 0.7, 0.7, 0.7]

for (eq, nu_, ra_, r1, r2) in (
    (<=, NU_, RA_, PV_, QV_),
    (>=, NU_, RA_, reverse(PV_), QV_),
    (<=, randn(1000), randn(100000), nothing, nothing),
)

    pv_, qv_ = Nucleus.Significance.make(eq, nu_, ra_)

    #@btime Nucleus.Significance.make($eq, $nu_, $ra_)

    @test isnothing(r1) || is_egal(pv_, r1)

    @test isnothing(r2) || is_egal(qv_, r2)

end

# ---- #

# 290.736 ns (42 allocations: 1.67 KiB)
# 11.265 ms (95 allocations: 1.82 MiB)

for (nu_, ra_, r1, r2, r3) in (
    (NU_, RA_, 1:4, [1, 1, 1, 2 / 3], [1, 1, 1, 1.0]),
    (randn(1000), randn(100000), nothing, nothing, nothing),
)

    in_, pv_, qv_ = Nucleus.Significance.make(nu_, ra_)

    #@btime Nucleus.Significance.make($nu_, $ra_)

    @test isnothing(r1) || is_egal(in_, r1)

    @test isnothing(r2) || is_egal(pv_, r2)

    @test isnothing(r3) || is_egal(qv_, r3)

end
