using Test: @test

using Nucleus

# ---- #

# 33.199 ns (7 allocations: 256 bytes)
# 7.448 μs (9 allocations: 129.52 KiB)
# 12.833 μs (9 allocations: 138.19 KiB)

const FU = Nucleus.PairMetric.make_mean_difference

const UM = 10000

const R1_ = convert(BitVector, rand(0:1, UM))

const R2_ = randn(UM)

for (bo_, nu_, re) in (
    (BitVector((0, 1, 0, 1)), [1, 2, 1, 2], 1.0),
    (R1_, R2_, nothing),
    (convert(Vector{Bool}, R1_), R2_, nothing),
)

    @test isnothing(re) ||
          Nucleus.PairMap.make(FU, bo_, nu_) ===
          -Nucleus.PairMap.make(FU, map(!, bo_), nu_) ===
          re

    #@btime Nucleus.PairMap.make(FU, $bo_, $nu_)

end
