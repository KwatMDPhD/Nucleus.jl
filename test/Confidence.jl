using Random: seed!

using Test: @test

using Nucleus

# ---- #

# 29.941 ns (0 allocations: 0 bytes)
# 53.173 ns (0 allocations: 0 bytes)
# 297.297 ns (0 allocations: 0 bytes)
# 2.347 μs (0 allocations: 0 bytes)
# 291.822 ns (0 allocations: 0 bytes)
# 291.665 ns (0 allocations: 0 bytes)
# 291.665 ns (0 allocations: 0 bytes)
# 291.822 ns (0 allocations: 0 bytes)
# 290.590 ns (0 allocations: 0 bytes)

const FR = 0.95

for (um, fr, re) in (
    (10, FR, 0.6597957136428491),
    (100, FR, 0.18754776361269151),
    (1000, FR, 0.061731275423233714),
    (10000, FR, 0.019648279269395462),
    (1000, 0, 0.0),
    (1000, 0.001, 3.9474552118205106e-5),
    (1000, 0.1, 0.003957845794082521),
    (1000, 0.9, 0.05180651944483268),
    (1000, 1, Inf),
)

    seed!(20240904)

    nu_ = randn(um)

    @test Nucleus.Confidence.make(nu_, fr) === re

    #@btime Nucleus.Confidence.make($nu_, $fr)

end
