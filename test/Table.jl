using DataFrames: DataFrame

using Test: @test

using Nucleus

# ---- #

for (n2, n1_, n2_, A, re) in ((
    "C1",
    ["R1", "R2"],
    ["C2", "C3", "C4"],
    [
        1 3 5
        2 4 6
    ],
    DataFrame("C1" => ["R1", "R2"], "C2" => [1, 2], "C3" => [3, 4], "C4" => [5, 6]),
),)

    @test Nucleus.Table.make(n2, n1_, n2_, A) == re

end

# ---- #

const DI = pkgdir(Nucleus, "data", "Table")

const TS = joinpath(tempdir(), "_.tsv")

# ---- #

for fi in (joinpath(DI, "titanic.tsv"), joinpath(DI, "enst_gene.tsv.gz"))

    a1 = Nucleus.Table.rea(fi)

    Nucleus.Table.writ(TS, a1)

    a2 = Nucleus.Table.rea(TS)

    @test all(id -> isequal(a1[!, id], a2[!, id]), axes(a1, 2))

end

# ---- #

for (fi, sh) in ((joinpath(DI, "12859_2019_2886_MOESM2_ESM.xlsx"), "HumanSpecific Genes"),)

    a1 = Nucleus.Table.rea(fi, sh)

    Nucleus.Table.writ(TS, a1)

    a2 = Nucleus.Table.rea(TS)

    @info "" a1 a2

end
