using Test: @test

using Nucleus

include("_.jl")

# ---- #

const HT = joinpath(TE, "_.html")

for (sr_, sc, re) in ((
    ("Sr 1", "Sr 2"),
    """
    Sc 1
    Sc 2""",
    14,
),)

    Nucleus.HTM.writ(HT, sr_, sc)

    @test count(==('\n'), read(HT, String)) === re

end
