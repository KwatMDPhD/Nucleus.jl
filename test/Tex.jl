using Test: @test

using Nucleus

# ---- #

for (te, re) in ((" a  b   ", "a b"),)

    @test Nucleus.Tex.update_space(te) === re

end

# ---- #

const T1 = " less  is   more    "

const T2 = "    DNA   RNA  protein "

# ---- #

for (te, re) in ((T1, "_less__is___more____"), (T2, "____dna___rna__protein_"))

    @test Nucleus.Tex.make_low(te) === re

end

# ---- #

for (te, re) in (
    ("i'M", "I'm"),
    ("you'RE", "You're"),
    ("it'S", "It's"),
    ("we'VE", "We've"),
    ("i'D", "I'd"),
    ("1ST", "1st"),
    ("2ND", "2nd"),
    ("3RD", "3rd"),
    ("4TH", "4th"),
    (T1, " Less  Is   More    "),
    (T2, "    DNA   RNA  Protein "),
    ("this_is_a_pen.", "This Is a Pen."),
)

    @test Nucleus.Tex.make_title(te) === re

end

# ---- #

# 117.677 ns (6 allocations: 200 bytes)
# 122.937 ns (6 allocations: 200 bytes)
# 116.522 ns (6 allocations: 208 bytes)
# 133.762 ns (7 allocations: 240 bytes)
# 129.907 ns (7 allocations: 232 bytes)
# 138.600 ns (7 allocations: 232 bytes)
# 139.302 ns (7 allocations: 240 bytes)
# 125.928 ns (6 allocations: 200 bytes)

for (n1, n2) in (
    ("sex", "sexes"),
    ("bus", "buses"),
    ("hero", "heroes"),
    ("country", "countries"),
    ("city", "cities"),
    ("index", "indices"),
    ("vertex", "vertices"),
    ("edge", "edges"),
)

    @test Nucleus.Tex.make_count(1, n1) === "1 $n1"

    @test Nucleus.Tex.make_count(2, n1) === "2 $n2"

    #@btime Nucleus.Tex.make_count(2, $n1)

end
