using Test: @test

using Nucleus

include("_.jl")

# ---- #

# 38.643 ns (4 allocations: 256 bytes)
# 198.708 μs (32 allocations: 1.59 MiB)

for (nu_, re) in (([-2, 1, 0, -1, 2], ([-2, -1], [1, 0, 2])), (randn(100000), nothing))

    @test isnothing(re) || is_egal(Nucleus.Numbe.ge(nu_), re)

    #@btime Nucleus.Numbe.ge($nu_)

end

# ---- #

const NU = 0.00055555

# ---- #

for (nu, re) in ((pi, "3.1"), (MathConstants.golden, "1.6"), (NU, "0.00056"))

    @test Nucleus.Numbe.text_2(nu) === re

end

# ---- #

for (nu, re) in ((pi, "3.142"), (MathConstants.golden, "1.618"), (NU, "0.0005556"))

    @test Nucleus.Numbe.text_4(nu) === re

end
