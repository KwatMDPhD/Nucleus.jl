using Colors: RGB

using Test: @test

using Nucleus

# ---- #

const RE = "#ff0000ff"

# ---- #

for (co, re) in ((RGB(1, 0, 0), RE),)

    @test Nucleus.Color.make(co) === re

end

# ---- #

const ST = "red"

for (st, ar_, re) in
    (("#ff0000", (), RE), (ST, (), RE), (ST, (0,), "#ff000000"), (ST, (0.5,), "#ff000080"))

    @test Nucleus.Color.make(st, ar_...) === re

end
