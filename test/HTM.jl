using Test: @test

using Nucleus

# ---- #

const HT = joinpath(tempdir(), "_.html")

for (sr_, id, sc, re) in ((
    ("SRC 1", "SRC 2"),
    "",
    """
    SCRIPT LINE 1
    SCRIPT LINE 2""",
    14,
),)

    Nucleus.HTM.writ(HT, sr_, id, sc)

    @test count(==('\n'), read(HT, String)) === re

end
