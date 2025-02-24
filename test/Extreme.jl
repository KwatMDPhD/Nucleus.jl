using Random: shuffle!

using Test: @test

using Nucleus

# ---- #

# 14.264 ns (2 allocations: 80 bytes)
# 14.640 ns (2 allocations: 96 bytes)
# 2.708 ns (0 allocations: 0 bytes)

for (u1, u2, re) in ((5, 1, [1, 5]), (5, 2, [1, 2, 4, 5]), (5, 3, 1:5))

    @test Nucleus.Extreme.index(u1, u2) == re

    #@btime Nucleus.Extreme.index($u1, $u2)

end

# ---- #

# 197.440 ns (8 allocations: 704 bytes)
# 201.957 ns (8 allocations: 736 bytes)
# 197.845 ns (6 allocations: 816 bytes)

const CH_ = 'a':'z'

const SH_ = shuffle!(collect(CH_))

for (an_, um, re) in ((SH_, 1, ['a', 'z']), (SH_, 2, ['a', 'b', 'y', 'z']), (SH_, 13, CH_))

    @test an_[Nucleus.Extreme.index(an_, um)] == re

    #@btime Nucleus.Extreme.index($an_, $um)

end
