using Random: randstring

using Test: @test

using Nucleus

# ---- #

const DI = Dict(ch^2 => uppercase(ch^2) for ch in 'a':'z')

# ---- #

# 26.564 ns (0 allocations: 0 bytes)
# 26.564 ns (0 allocations: 0 bytes)
# 19.289 ns (1 allocation: 24 bytes)

for (ke, re) in (("aa", "AA"), ("zz", "ZZ"), ("??", "_??"))

    @test Nucleus.Rename.ge(DI, ke) === re

    #@btime Nucleus.Rename.ge(DI, $ke)

end

# ---- #

for na_ in (
    ("Good", "_Bad"),
    map(ke -> Nucleus.Rename.ge(DI, ke), map(_ -> randstring('a':'b', 2), 1:10000)),
)

    Nucleus.Rename.text(na_)

end
