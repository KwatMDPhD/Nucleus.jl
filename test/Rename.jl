using Test: @test

using Nucleus

include("_.jl")

# ---- #

const DI = Dict("$(lowercase(ch))$ch" => text(ch) for ch in 'A':'Z')

for (st, re) in (("aA", "Aa"), ("zZ", "Zz"), ("??", "_??"))

    @test Nucleus.Rename.ge(DI, st) === re

end

# ---- #

for st_ in (("_aA", "_bB"), ("_cC", "Dd"), ("Ee", "Ff"))

    Nucleus.Rename.lo(st_)

end
