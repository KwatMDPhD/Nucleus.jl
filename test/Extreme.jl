using Random: shuffle

using Test: @test

using Nucleus

include("_.jl")

# ---- #

for (um, re) in ((1, [1, 5]), (2, [1, 2, 4, 5]), (3, 1:5))

    @test is_egal(Nucleus.Extreme.index(5, um), re)

end

# ---- #

# 800.933 ns (8 allocations: 704 bytes)
# 602.201 ns (8 allocations: 736 bytes)
# 668.284 ns (6 allocations: 816 bytes)

const AN_ = map(text, 'A':'Z')

for (um, re) in ((1, ["Aa", "Zz"]), (2, ["Aa", "Bb", "Yy", "Zz"]), (14, AN_))

    an_ = shuffle(AN_)

    @test is_egal(an_[Nucleus.Extreme.index(an_, um)], re)

    #@btime Nucleus.Extreme.index($an_, $um)

end
