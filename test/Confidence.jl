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

    #@btime Nucleus.Confidence.make($ra_)

end

# ---- #

# 185.419 ns (0 allocations: 0 bytes)
# 185.295 ns (0 allocations: 0 bytes)
# 185.297 ns (0 allocations: 0 bytes)
# 185.605 ns (0 allocations: 0 bytes)
# 185.544 ns (0 allocations: 0 bytes)

seed!(20240904)

const RA_ = randn(1000)

for (pr, re) in (
    (0, 0.0),
    (0.001, 3.9474552118205106e-5),
    (0.1, 0.003957845794082521),
    (0.9, 0.05180651944483268),
    (1, Inf),
)

    @test Nucleus.Confidence.make(RA_, pr) === re

    #@btime Nucleus.Confidence.make(RA_, $pr)

end
