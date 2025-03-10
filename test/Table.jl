using DataFrames: DataFrame

using Test: @test

using Nucleus

include("_.jl")

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

const DA = pkgdir(Nucleus, "data", "Table")

const GZ = joinpath(DA, "1.tsv.gz")

# ---- #

for (an, c1_, c2, re) in ((Nucleus.Table.rea(GZ), ["hgnc_id"], "symbol", 43840),)

    @test length(Nucleus.Table.make_dictionary(an, c1_, c2)) === re

end

# ---- #

# TODO: Loop for writ.

const TS = joinpath(TE, "_.tsv")

# ---- #

for cs in (joinpath(DA, "1.tsv"), GZ)

    a1 = Nucleus.Table.rea(cs)

    Nucleus.Table.writ(TS, a1)

    a2 = Nucleus.Table.rea(TS)

    @test all(id -> isequal(a1[!, id], a2[!, id]), axes(a1, 2))

end

# ---- #

for (xl, sh) in ((joinpath(DA, "1.xlsx"), "HumanSpecific Genes"),)

    a1 = Nucleus.Table.rea(xl, sh)

    Nucleus.Table.writ(TS, a1)

    a2 = Nucleus.Table.rea(TS)

    @info "TODO" a1 a2

end
