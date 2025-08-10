using DataFrames: DataFrame

using Test: @test

using Nucleus

include("_.jl")

# ---- #

const A = DataFrame("Co 1" => ["Ro 1", "Ro 2"], "Co 2" => 1:2, "Co 3" => 3:4, "Co 4" => 5:6)

const ST = "Co 1"

const S1_ = ["Ro 1", "Ro 2"]

const S2_ = ["Co 2", "Co 3", "Co 4"]

const I = [
    1 3 5
    2 4 6
]

# ---- #

for (st, s1_, s2_, A, re) in ((ST, S1_, S2_, I, A),)

    @test is_egal(Nucleus.Table.make(st, s1_, s2_, A), re)

end

# ---- #

for (A1, r1, r2, r3, r4) in ((A, ST, S1_, S2_, I),)

    st, s1_, s2_, A2 = Nucleus.Table.ge(A1)

    @test st === r1

    @test is_egal(s1_, r2)

    @test is_egal(s2_, r3)

    @test is_egal(A2, r4)

end

# ---- #

const DA = pkgdir(Nucleus, "data", "Table")

const GZ = joinpath(DA, "_.tsv.gz")

# ---- #

for (A, st_, st, re) in ((Nucleus.Table.rea(GZ), ["hgnc_id"], "symbol", 43840),)

    @test length(Nucleus.Table.make_dictionary(A, st_, st)) === re

end

# ---- #

function writ(A)

    ts = joinpath(TE, "_.tsv")

    Nucleus.Table.writ(ts, A)

    Nucleus.Table.rea(ts)

end

# ---- #

for fi in (joinpath(DA, "_.tsv"), GZ)

    A1 = Nucleus.Table.rea(fi)

    A2 = writ(A1)

    @test all(nd -> isequal(A1[!, nd], A2[!, nd]), axes(A1, 2))

end

# ---- #

for (xl, sh) in ((joinpath(DA, "_.xlsx"), "HumanSpecific Genes"),)

    A1 = Nucleus.Table.rea(xl, sh)

    A2 = writ(A1)

    @warn "TODO" A1 A2

end

# ---- #
# TODO

Nucleus.Table.writ
