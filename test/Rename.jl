using Test: @test

using Nucleus

# ---- #

const DI = Dict("$(lowercase(up))$up" => "$up$(lowercase(up))" for up in 'A':'Z')

for (st, re) in (("aA", "Aa"), ("zZ", "Zz"), ("??", "_??"))

    @test Nucleus.Rename.ge(DI, st) === re

end

# ---- #

for st_ in (("_aA", "_bB"), ("_cC", "Dd"), ("Ee", "Ff"))

    Nucleus.Rename.lo(st_)

end
