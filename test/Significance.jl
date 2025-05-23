using Test: @test

using Nucleus

include("_.jl")

# ---- #

const PV = 0.1

for (um, re) in ((0, PV), (1, PV), (2, 0.2))

    @test Nucleus.Significance.make(um, 10) === re

end

# ---- #

const N1_ = [-4, -3, -2, -1, -0.0, 0, 1, 2, 3, 4]

const R1_ = randn(1000)

const R2_ = randn(100000)

# ---- #

# 91.824 ns (11 allocations: 512 bytes)
# 95.697 ns (11 allocations: 512 bytes)
# 22.227 ms (19 allocations: 48.41 KiB)

const N2_ = [-1, -0.0, 0, 1]

const PV_ = [0.4, 0.6, 0.6, 0.7]

const QV_ = fill(0.7, 4)

for (eq, nu_, ra_, r1, r2) in (
    (<=, N2_, N1_, PV_, QV_),
    (>=, N2_, N1_, reverse(PV_), QV_),
    (<=, R1_, R2_, nothing, nothing),
)

    pv_, qv_ = Nucleus.Significance.make(eq, nu_, ra_)

    #@btime Nucleus.Significance.make($eq, $nu_, $ra_)

    @test isnothing(r1) || is_egal(pv_, r1)

    @test isnothing(r2) || is_egal(qv_, r2)

end

# ---- #

# 364.229 ns (44 allocations: 2.28 KiB)
# 11.272 ms (95 allocations: 1.82 MiB)

for (nu_, ra_, r1, r2, r3) in (
    (
        [-0.0, 0, -1, 1, -2, 2, -3, 3, -4, 4],
        N1_,
        [3, 5, 7, 9, 1, 2, 4, 6, 8, 10],
        [1, 0.75, 0.5, 0.25, 1, 1, 2 / 3, 0.5, 1 / 3, 1 / 6],
        ones(10),
    ),
    (R1_, R2_, nothing, nothing, nothing),
)

    in_, pv_, qv_ = Nucleus.Significance.make(nu_, ra_)

    #@btime Nucleus.Significance.make($nu_, $ra_)

    @test isnothing(r1) || is_egal(in_, r1)

    @test isnothing(r2) || is_egal(pv_, r2)

    @test isnothing(r3) || is_egal(qv_, r3)

end
