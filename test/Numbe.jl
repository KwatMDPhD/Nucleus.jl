using Test: @test

using Nucleus

include("_.jl")

# ---- #

# 26.942 ns (4 allocations: 256 bytes)
# 137.500 μs (32 allocations: 1.73 MiB)

for (nu_, r1, r2) in
    (([-2, 1, 0, -1, 2], [-2, -1], [1, 0, 2]), (randn(100000), nothing, nothing))

    ne_, po_ = Nucleus.Numbe.ge(nu_)

    @btime Nucleus.Numbe.ge($nu_)

    @test isnothing(r1) || is_egal(ne_, r1)

    @test isnothing(r2) || is_egal(po_, r2)

end

# ---- #

const FL = 0.00055555

# ---- #

for (nu, re) in ((pi, "3.1"), (MathConstants.golden, "1.6"), (FL, "0.00056"))

    @test Nucleus.Numbe.text_2(nu) === re

end

# ---- #

for (nu, re) in ((pi, "3.142"), (MathConstants.golden, "1.618"), (FL, "0.0005556"))

    @test Nucleus.Numbe.text_4(nu) === re

end
