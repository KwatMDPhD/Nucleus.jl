using Test: @test

using Nucleus

# ---- #

const S1 = "1234567890"

for (um, re) in ((1, "1..."), (2, "12..."), (11, S1))

    @test Nucleus.Tex.make_short(S1, um) === re

end

# ---- #

const S2 = " less  is   more    "

const S3 = "    DNA   RNA  protein "

# ---- #

for (st, re) in ((S2, "_less__is___more____"), (S3, "____dna___rna__protein_"))

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
    (S2, " Less  Is   More    "),
    (S3, "    DNA   RNA  Protein "),
)

    @test Nucleus.Tex.make_title(st) === re

end

# ---- #

# 117.858 ns (6 allocations: 200 bytes)
# 122.376 ns (6 allocations: 200 bytes)
# 116.266 ns (6 allocations: 208 bytes)
# 133.087 ns (7 allocations: 240 bytes)
# 128.988 ns (7 allocations: 232 bytes)
# 138.028 ns (7 allocations: 232 bytes)
# 138.648 ns (7 allocations: 240 bytes)
# 125.419 ns (6 allocations: 200 bytes)

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

# ---- #

for (st_, re) in ((('A', "Bb", "Cc"), "A · Bb · Cc"),)

    @test Nucleus.Tex.make_chain(st_) === re

end
