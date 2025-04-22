using Test: @test

using Nucleus

# ---- #

for st in ("", " ", ".", "_")

    @test Nucleus.Strin.is_bad(st)

    @test Nucleus.Strin.is_bad("$st$st")

    @test !Nucleus.Strin.is_bad("A$st")

end

# ---- #

const AZ = join('A':'Z', ' ')

# ---- #

for (id, re) in ((1, "A"), (2, "B"), (26, "Z"))

    @test Nucleus.Strin.ge(AZ, id) == re

end

# ---- #

for re in ("A",)

    @test Nucleus.Strin.get_1(AZ) == re

end

# ---- #

for re in (AZ[3:end],)

    @test Nucleus.Strin.get_not_1(AZ) == re

end

# ---- #

for re in ("Z",)

    @test Nucleus.Strin.get_end(AZ) == re

end

# ---- #

for re in (AZ[1:(end - 2)],)

    @test Nucleus.Strin.get_not_end(AZ) == re

end

# ---- #

for (um, re) in ((1, "A..."), (2, "A ..."), (51, AZ), (52, AZ))

    @test Nucleus.Strin.make_short(AZ, um) === re

end
