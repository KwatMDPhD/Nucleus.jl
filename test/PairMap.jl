using Test: @test

using Nucleus

# ---- #

# 36.422 ns (6 allocations: 224 bytes)
# 13.041 μs (9 allocations: 138.19 KiB)
# 7.458 μs (9 allocations: 129.52 KiB)

const FU = Nucleus.PairMetric.make_mean_difference

const UM = 10000

const R1_ = rand(Bool, UM)

const R2_ = randn(UM)

for (bo_, nu_, re) in (
    ([false, true, false, true], [1, 2, 1, 2], 1.0),
    (R1_, R2_, nothing),
    (convert(BitVector, R1_), R2_, nothing),
)

    @test isnothing(re) ||
          Nucleus.PairMap.make(FU, bo_, nu_) ===
          -Nucleus.PairMap.make(FU, map(!, bo_), nu_) ===
          re

    #@btime Nucleus.PairMap.make(FU, $bo_, $nu_)

end
