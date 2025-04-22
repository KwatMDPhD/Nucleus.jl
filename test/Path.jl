using Test: @test

using Nucleus

include("_.jl")

# ---- #

const JL = pkgdir(Nucleus, "test", "Path.jl")

# ---- #

for (st, re) in ((JL, true), ("nonexistent.file", false))

    @test Nucleus.Path.is_path(st, 2) === re

end

# ---- #

for re in ("Path.jl",)

    @test Nucleus.Path.text(JL) === re

end

# ---- #

for (di, re) in ((pkgdir(Nucleus), "test/Path.jl"),)

    @test Nucleus.Path.text(JL, di) === re

end

# ---- #

for pa in (TE,)

    Nucleus.Path.rea(pa)

end
