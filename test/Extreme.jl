using Random: shuffle!

using Test: @test

using Nucleus

include("_.jl")

# ---- #

# 9.425 ns (2 allocations: 80 bytes)
# 9.500 ns (2 allocations: 96 bytes)
# 1.916 ns (0 allocations: 0 bytes)

for (u1, u2, re) in ((5, 1, [1, 5]), (5, 2, [1, 2, 4, 5]), (5, 3, 1:5))

    @test is_egal(Nucleus.Extreme.index(u1, u2), re)

    #@btime Nucleus.Extreme.index($u1, $u2)

end

# ---- #

# 615.844 ns (8 allocations: 704 bytes)
# 549.465 ns (8 allocations: 736 bytes)
# 539.888 ns (6 allocations: 816 bytes)

const ST_ = map(ch -> "$ch$(lowercase(ch))", 'A':'Z')

const SH_ = shuffle!(copy(ST_))

for (an_, um, re) in
    ((SH_, 1, ["Aa", "Zz"]), (SH_, 2, ["Aa", "Bb", "Yy", "Zz"]), (SH_, 14, ST_))

    @test is_egal(an_[Nucleus.Extreme.index(an_, um)], re)

    #@btime Nucleus.Extreme.index($an_, $um)

end
