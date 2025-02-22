using Random: randstring

using Test: @test

using Nucleus

# ---- #

@test length(
    Nucleus.Pai.make(
        Nucleus.Table.rea(pkgdir(Nucleus, "data", "Table", "1.tsv.gz")),
        ["hgnc_id"],
        "symbol",
    ),
) === 43840

# ---- #

const DI = Dict(ch^2 => uppercase(ch^2) for ch in 'a':'z')

# ---- #

# 26.564 ns (0 allocations: 0 bytes)
# 26.564 ns (0 allocations: 0 bytes)
# 19.163 ns (1 allocation: 24 bytes)

for (ke, re) in (("aa", "AA"), ("zz", "ZZ"), ("??", "_??"))

    @test Nucleus.Pai.ge(DI, ke) === re

    #@btime Nucleus.Pai.ge(DI, $ke)

end

# ---- #

Nucleus.Pai.text(
    map(ke -> Nucleus.Pai.ge(DI, ke), map(_ -> randstring('a':'b', 2), 1:10000)),
)
