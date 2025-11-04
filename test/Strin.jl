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

for (nd, re) in ((1, "A"), (2, "B"), (26, "Z"))

    @test Nucleus.Strin.ge(ST, nd) == re

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

for (st, re) in (("1 A 2 a 3 . _", "Aa"), (ST, join('A':'Z')))

    @test Nucleus.Strin.text_letter(st) === re

end

# ---- #

for (um, re) in ((1, "A..."), (2, "A\t..."), (51, ST), (52, ST))

    @test Nucleus.Strin.text_limit(ST, um) === re

end
