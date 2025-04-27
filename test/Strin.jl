using Test: @test

using Nucleus

# ---- #

for st in ("", " ", ".", "_")

    @test Nucleus.Strin.is_bad(st)

    @test Nucleus.Strin.is_bad("$st$st")

    @test !Nucleus.Strin.is_bad("A$st")

end

# ---- #

const ST = join('A':'Z', ' ')

# ---- #

for (id, re) in ((1, "A"), (2, "B"), (26, "Z"))

    @test Nucleus.Strin.ge(ST, id) == re

end

# ---- #

for re in ("A",)

    @test Nucleus.Strin.get_1(ST) == re

end

# ---- #

for re in (ST[3:end],)

    @test Nucleus.Strin.get_not_1(ST) == re

end

# ---- #

for re in ("Z",)

    @test Nucleus.Strin.get_end(ST) == re

end

# ---- #

for re in (ST[1:(end - 2)],)

    @test Nucleus.Strin.get_not_end(ST) == re

end

# ---- #

for (um, re) in ((1, "A..."), (2, "A ..."), (51, ST), (52, ST))

    @test Nucleus.Strin.make_short(ST, um) === re

end
