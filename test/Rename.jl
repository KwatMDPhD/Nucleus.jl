using Test: @test

using Nucleus

# ---- #

# 16.867 ns (0 allocations: 0 bytes)
# 16.867 ns (0 allocations: 0 bytes)
# 12.137 ns (1 allocation: 24 bytes)

const DI = Dict(st => lowercase(st) for st in ("$up$up" for up in 'A':'Z'))

for (st, re) in (("AA", "aa"), ("ZZ", "zz"), ("??", "_??"))

    @test Nucleus.Rename.ge(DI, st) === re

    @btime Nucleus.Rename.ge(DI, $st)

end

# ---- #

for st_ in (("_Aa", "_Bb"), ("_Cc", "Dd"), ("Ee", "Ff"))

    Nucleus.Rename.lo(st_)

end
