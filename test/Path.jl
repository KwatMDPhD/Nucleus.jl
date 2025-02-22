using Test: @test

using Nucleus

# ---- #

const FI = joinpath(pwd(), "Path.jl")

# ---- #

const DI = pkgdir(Nucleus)

for (di, re) in
    ((dirname(DI), "Nucleus.jl/test/Path.jl"), (DI, "test/Path.jl"), (pwd(), "Path.jl"))

    @test Nucleus.Path.text(FI, di) == re

end

# ---- #

for (pa, re) in ((FI, true), ("nonexistent.file", false))

    @test Nucleus.Path.is_path(pa, 2) === re

end

# ---- #

for pa in (homedir(),)

    Nucleus.Path.rea(pa)

end
