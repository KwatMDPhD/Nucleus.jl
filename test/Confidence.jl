using Random: seed!

using Test: @test

using Nucleus

# ---- #

# 15.155 ns (0 allocations: 0 bytes)
# 27.931 ns (0 allocations: 0 bytes)
# 188.876 ns (0 allocations: 0 bytes)
# 1.567 μs (0 allocations: 0 bytes)

for (um, re) in (
    (10, 0.6597957136428491),
    (100, 0.18754776361269151),
    (1000, 0.061731275423233714),
    (10000, 0.019648279269395462),
)

    seed!(20240904)

    ra_ = randn(um)

    @test Nucleus.Confidence.make(ra_) === re

    @btime Nucleus.Confidence.make($ra_)

end

# ---- #

seed!(20250421)

const RA_ = randn(1000)

for (pr, re) in
    ((0, 0.0), (0.05, 0.0019629982115993367), (0.95, 0.061355501313357), (1, Inf))

    @test Nucleus.Confidence.make(RA_, pr) === re

end
