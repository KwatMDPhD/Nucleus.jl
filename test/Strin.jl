using Test: @test

using Nucleus

# ---- #

for st in ("", " ", ".", "_")

    @test Nucleus.Strin.is_bad(st)

    @test Nucleus.Strin.is_bad("$st$st")

    @test !Nucleus.Strin.is_bad("Aa$st")

end

# ---- #

const ST = join('A':'Z', '\t')

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

for (um, re) in ((1, "A..."), (2, "A\t..."), (51, ST), (52, ST))

    @test Nucleus.Strin.text(ST, um) === re

end

# ---- #

for (an_, re) in ((1:3, "1 · 2 · 3"),)

    @test Nucleus.Strin.text(an_) === re

end
