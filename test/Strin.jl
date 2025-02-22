using Test: @test

using Nucleus

# ---- #

for st in (
    "",
    " ",
    "α",
    "π",
    " ",
    "!",
    "\"",
    "#",
    "%",
    "&",
    "'",
    "(",
    ")",
    "*",
    "+",
    ",",
    "-",
    ".",
    "/",
    ":",
    ";",
    "<",
    "=",
    ">",
    "?",
    "@",
    "[",
    "]",
    "^",
    "_",
    "`",
    "{",
    "|",
    "}",
    "~",
)

    @test Nucleus.Strin.is_bad(st)

    @test Nucleus.Strin.is_bad(st^2)

    @test !Nucleus.Strin.is_bad("a$st")

    @test !Nucleus.Strin.is_bad("$(st)b")

    @test !Nucleus.Strin.is_bad("a$(st)b")

end

# ---- #

for (st, re) in (("a/b", "a_b"),)

    @test Nucleus.Strin.update_slash(st) === re

end

# ---- #

for (st, re) in ((" a  b   ", "a b"),)

    @test Nucleus.Strin.update_space(st) === re

end

# ---- #

# 45.328 ns (2 allocations: 256 bytes)
# 429.226 ns (3 allocations: 1.23 KiB)
# 63.776 ns (2 allocations: 256 bytes)
# 428.603 ns (3 allocations: 1.23 KiB)
# 429.020 ns (3 allocations: 1.23 KiB)
# 429.231 ns (3 allocations: 1.23 KiB)

const DE = '.'

const S1 = join('a':'z', DE)

for (id, re) in ((1, "a"), (2, "b"), (26, "z"))

    @test Nucleus.Strin.ge(S1, id, DE) == re

    #@btime Nucleus.Strin.ge(S1, $id, DE)

    #@btime split(S1, DE)[$id]

end

# ---- #

const S2 = "a b c"

# ---- #

for (st, re) in ((S2, "a"),)

    @test Nucleus.Strin.get_1(st) == re

end

# ---- #

for (st, re) in ((S2, "b c"),)

    @test Nucleus.Strin.get_not_1(st) == re

end

# ---- #

for (st, re) in ((S2, "c"),)

    @test Nucleus.Strin.get_end(st) == re

end

# ---- #

for (st, re) in ((S2, "a b"),)

    @test Nucleus.Strin.get_not_end(st) == re

end
