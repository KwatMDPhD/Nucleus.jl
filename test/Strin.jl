using Test: @test

using Nucleus

# ---- #

for st in ("", " ", "+", "-", ".", "_")

    @test Nucleus.Strin.is_bad(st)

    @test Nucleus.Strin.is_bad(st^2)

    @test !Nucleus.Strin.is_bad("A$st")

end

# ---- #

const AZ = join('A':'Z', ' ')

# ---- #

for (id, re) in ((1, "A"), (2, "B"), (26, "Z"))

    @test Nucleus.Strin.ge(AZ, id) == re

end

# ---- #

for (st, re) in ((AZ, "A"),)

    @test Nucleus.Strin.get_1(st) == re

end

# ---- #

for (st, re) in ((AZ, AZ[3:end]),)

    @test Nucleus.Strin.get_not_1(st) == re

end

# ---- #

for (st, re) in ((AZ, "Z"),)

    @test Nucleus.Strin.get_end(st) == re

end

# ---- #

for (st, re) in ((AZ, AZ[1:(end - 2)]),)

    @test Nucleus.Strin.get_not_end(st) == re

end

# ---- #

for (um, re) in ((1, "A..."), (2, "A ..."), (51, AZ), (52, AZ))

    @test Nucleus.Strin.make_short(AZ, um) === re

end
