using DataFrames: DataFrame

using Test: @test

using Nucleus

include("_.jl")

# ---- #

for (st, s1_, s2_, A, re) in ((
    "C1",
    ["R1", "R2"],
    ["C2", "C3", "C4"],
    [
        1 3 5
        2 4 6
    ],
    DataFrame("C1" => ["R1", "R2"], "C2" => 1:2, "C3" => 3:4, "C4" => 5:6),
),)

    @test Nucleus.Table.make(st, s1_, s2_, A) == re

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

    @test all(id -> isequal(A1[!, id], A2[!, id]), axes(A1, 2))

end

# ---- #

for (xl, sh) in ((joinpath(DA, "_.xlsx"), "HumanSpecific Genes"),)

    A1 = Nucleus.Table.rea(xl, sh)

    A2 = writ(A1)

    @warn "TODO" A1 A2

end
