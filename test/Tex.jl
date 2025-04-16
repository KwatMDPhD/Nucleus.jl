using Test: @test

using Nucleus

# ---- #

for (st, re) in ((" A  B   ", "A B"),)

    @test Nucleus.Tex.update_space(st) === re

end

# ---- #

const S1 = " less  is   more    "

const S2 = "    DNA   RNA  protein "

# ---- #

for (st, re) in ((S1, "_less__is___more____"), (S2, "____dna___rna__protein_"))

    @test Nucleus.Tex.make_low(st) === re

end

# ---- #

for (st, re) in (
    ("i'M", "I'm"),
    ("you'RE", "You're"),
    ("it'S", "It's"),
    ("we'VE", "We've"),
    ("i'D", "I'd"),
    ("1ST", "1st"),
    ("2ND", "2nd"),
    ("3RD", "3rd"),
    ("4TH", "4th"),
    (S1, " Less  Is   More    "),
    (S2, "    DNA   RNA  Protein "),
    ("this_is_a_pen.", "This Is a Pen."),
)

    @test Nucleus.Tex.make_title(st) === re

end

# ---- #

# 73.698 ns (6 allocations: 200 bytes)
# 77.320 ns (6 allocations: 200 bytes)
# 73.817 ns (6 allocations: 208 bytes)
# 82.988 ns (7 allocations: 240 bytes)
# 79.498 ns (7 allocations: 232 bytes)
# 84.414 ns (7 allocations: 232 bytes)
# 85.234 ns (7 allocations: 240 bytes)
# 79.029 ns (6 allocations: 200 bytes)

for (s1, s2) in (
    ("sex", "sexes"),
    ("bus", "buses"),
    ("hero", "heroes"),
    ("country", "countries"),
    ("city", "cities"),
    ("index", "indices"),
    ("vertex", "vertices"),
    ("edge", "edges"),
)

    @test Nucleus.Tex.make_count(1, s1) === "1 $s1"

    @test Nucleus.Tex.make_count(2, s1) === "2 $s2"

    #@btime Nucleus.Tex.make_count(2, $s1)

end
