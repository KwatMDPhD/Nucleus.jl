using Colors: RGB

using Test: @test

using Nucleus

# ---- #

const H8 = "#ff0000ff"

# ---- #

for (co, re) in ((RGB(1, 0, 0), H8),)

    @test Nucleus.Color.make(co) === re

end

# ---- #

const H6 = "#ff0000"

# ---- #

for (st, re) in ((H6, H8),)

    @test Nucleus.Color.make(st) === re

end

# ---- #

for (st, pr, re) in ((H6, 0, "#ff000000"), (H6, 0.5, "#ff000080"))

    @test Nucleus.Color.make(st, pr) === re

end
