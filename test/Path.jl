using Test: @test

using Nucleus

include("_.jl")

# ---- #

const PK = pkgdir(Nucleus)

const JL = joinpath(PK, "test", "Path.jl")

# ---- #

for (pa, re) in ((JL, true), ("nonexistent.file", false))

    @test Nucleus.Path.is_path(pa, 2) === re

end

# ---- #

for re in ("Path.jl",)

    @test Nucleus.Path.text(JL) === re

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

for pa in (TE,)

    Nucleus.Path.rea(pa)

end
