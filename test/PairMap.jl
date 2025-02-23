using Test: @test

using Nucleus

# ---- #

# 54.738 ns (7 allocations: 256 bytes)
# 12.375 μs (9 allocations: 79.77 KiB)
# 31.500 μs (9 allocations: 88.31 KiB)

const NU_ = randn(10000)

const BO_ = convert(BitVector, rand(0:1, lastindex(NU_)))

for (bo_, nu_, re) in (
    (BitVector((0, 1, 0, 1)), [1, 2, 1, 2], 1.0),
    (BO_, NU_, nothing),
    (convert(Vector{Bool}, BO_), NU_, nothing),
)

    fu = Nucleus.PairMetric.make_mean_difference

    @test isnothing(re) ||
          Nucleus.PairMap.make(fu, bo_, nu_) ===
          -Nucleus.PairMap.make(fu, map(!, bo_), nu_) ===
          re

    #@btime Nucleus.PairMap.make($fu, $bo_, $nu_)

end
