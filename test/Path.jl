using Test: @test

using Nucleus

# ---- #

const PK = pkgdir(Nucleus)

const JL = joinpath(PK, "test", "Path.jl")

# ---- #

for (pa, re) in ((JL, true), ("nonexistent.file", false))

    @test Nucleus.Path.is_path(pa, 2) === re

end

# ---- #

for (di, re) in (
    (dirname(PK), "Nucleus.jl/test/Path.jl"),
    (PK, "test/Path.jl"),
    (joinpath(PK, "test"), "Path.jl"),
)

    @test Nucleus.Path.text(JL, di) === re

end

# ---- #

for pa in (homedir(),)

    Nucleus.Path.rea(pa)

end
