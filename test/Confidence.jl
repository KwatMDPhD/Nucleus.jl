using Random: seed!

using Test: @test

using Nucleus

# ---- #

# 29.983 ns (0 allocations: 0 bytes)
# 54.018 ns (0 allocations: 0 bytes)
# 297.571 ns (0 allocations: 0 bytes)
# 2.352 μs (0 allocations: 0 bytes)

for (um, re) in (
    (10, 0.6597957136428491),
    (100, 0.18754776361269151),
    (1000, 0.061731275423233714),
    (10000, 0.019648279269395462),
)

    seed!(20240904)

    nu_ = randn(um)

    @test Nucleus.Confidence.make(nu_) === re

    #@btime Nucleus.Confidence.make($nu_)

end

# ---- #

# 2.343 μs (0 allocations: 0 bytes)
# 291.668 ns (0 allocations: 0 bytes)
# 291.664 ns (0 allocations: 0 bytes)
# 291.974 ns (0 allocations: 0 bytes)
# 2.338 μs (0 allocations: 0 bytes)

seed!(20240904)

const NU_ = randn(1000)

for (fr, re) in (
    (0, 0.0),
    (0.001, 3.9474552118205106e-5),
    (0.1, 0.003957845794082521),
    (0.9, 0.05180651944483268),
    (1, Inf),
)

    @test Nucleus.Confidence.make(NU_, fr) === re

    #@btime Nucleus.Confidence.make(NU_, $fr)

end
