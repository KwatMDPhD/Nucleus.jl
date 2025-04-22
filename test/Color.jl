using Colors: RGB

using Test: @test

using Nucleus

# ---- #

const H8 = "#ff0000ff"

# ---- #

for co in (RGB(1, 0, 0), RGB(1, 0, 0.0))

    @test Nucleus.Color.make(co) === H8

end

# ---- #

const H6 = "#ff0000"

# ---- #

for st in ("red", H6)

    @test Nucleus.Color.make(st) === H8

end

# ---- #

for (st, pr, re) in ((H6, 0, "#ff000000"), (H6, 0.5, "#ff000080"))

    @test Nucleus.Color.make(st, pr) === re

end
