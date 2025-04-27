using Random: shuffle

using Test: @test

using Nucleus

include("_.jl")

# ---- #

# 8.959 ns (2 allocations: 80 bytes)
# 9.009 ns (2 allocations: 96 bytes)
# 1.708 ns (0 allocations: 0 bytes)

const UM = 5

for (um, re) in ((1, [1, 5]), (2, [1, 2, 4, 5]), (3, 1:5))

    @test is_egal(Nucleus.Extreme.index(UM, um), re)

    #@btime Nucleus.Extreme.index(UM, $um)

end

# ---- #

# 592.461 ns (8 allocations: 704 bytes)
# 595.506 ns (8 allocations: 736 bytes)
# 592.927 ns (6 allocations: 816 bytes)

const S1_ = map(up -> "$up$(lowercase(up))", 'A':'Z')

const S2_ = shuffle(S1_)

for (um, re) in ((1, ["Aa", "Zz"]), (2, ["Aa", "Bb", "Yy", "Zz"]), (14, S1_))

    @test is_egal(S2_[Nucleus.Extreme.index(S2_, um)], re)

    #@btime Nucleus.Extreme.index(S2_, $um)

end
