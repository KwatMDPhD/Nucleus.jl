using Test: @test

using Nucleus

# ---- #

# 54.247 ns (7 allocations: 256 bytes)
# 12.417 μs (9 allocations: 79.64 KiB)
# 28.833 μs (9 allocations: 88.19 KiB)

const NU_ = randn(10000)

const BO_ = convert(BitVector, rand(0:1, lastindex(NU_)))

for (bo_, nu_, re) in (
    (BitVector((0, 1, 0, 1)), [1, 2, 1, 2], 1.0),
    (BO_, NU_, nothing),
    (convert(Vector{Bool}, BO_), NU_, nothing),
)

    if !isnothing(re)

        @test Nucleus.Map.make(Nucleus.PairMetric.make_mean_difference, bo_, nu_) === re

    end

    #@btime Nucleus.Map.make(Nucleus.PairMetric.make_mean_difference, $bo_, $nu_)

end
