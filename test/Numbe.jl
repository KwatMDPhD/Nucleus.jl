using Test: @test

using Nucleus

include("_.jl")

# ---- #

# 38.390 ns (4 allocations: 256 bytes)
# 197.292 μs (32 allocations: 1.59 MiB)

for (nu_, re) in (([-2, 1, 0, -1, 2], ([-2, -1], [1, 0, 2])), (randn(100000), nothing))

    @test isnothing(re) || is_egal(Nucleus.Numbe.ge(nu_), re)

    #@btime Nucleus.Numbe.ge($nu_)

end

# ---- #

for (nu, re) in ((pi, "3.1"), (MathConstants.golden, "1.6"))

    @test Nucleus.Numbe.text(nu) === re

end
