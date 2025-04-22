using Test: @test

using Nucleus

# ---- #

const DI = Dict(st => lowercase(st) for st in ("$up$up" for up in 'A':'Z'))

for (st, re) in (("AA", "aa"), ("ZZ", "zz"), ("??", "_??"))

    @test Nucleus.Rename.ge(DI, st) === re

end

# ---- #

for st_ in (("_Aa", "_Bb"), ("_Cc", "Dd"), ("Ee", "Ff"))

    Nucleus.Rename.lo(st_)

end
