using Test: @test

using Nucleus

# ---- #

for (st, re) in ((" A  B   ", "A B"),)

    @test Nucleus.Tex.text_strip(st) === re

end

# ---- #

const S1 = " less  is   more    "

const S2 = "    DNA   RNA  protein "

# ---- #

for (st, re) in ((S1, "_less__is___more____"), (S2, "____dna___rna__protein_"))

    @test Nucleus.Tex.text_low(st) === re

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
    (S1, " less  is   more    "),
    (S2, "    DNA   RNA  protein "),
    ("this_is_a_pen.", "This is a pen."),
)

    @test Nucleus.Tex.text_title(st) === re

end

# ---- #

# 73.346 ns (6 allocations: 200 bytes)
# 76.132 ns (6 allocations: 200 bytes)
# 73.002 ns (6 allocations: 208 bytes)
# 80.068 ns (7 allocations: 232 bytes)
# 80.905 ns (7 allocations: 232 bytes)
# 75.980 ns (6 allocations: 208 bytes)

for (s1, s2) in (
    ("sex", "sexes"),
    ("bus", "buses"),
    ("hero", "heroes"),
    ("city", "cities"),
    ("index", "indices"),
    ("apple", "apples"),
)

    @test Nucleus.Tex.text_count(1, s1) === "1 $s1"

    @test Nucleus.Tex.text_count(2, s1) === "2 $s2"

    #@btime Nucleus.Tex.text_count(2, $s1)

end
