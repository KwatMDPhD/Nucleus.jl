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

# ---- #

for (st, re) in ((ST, RE), ("#ff0000", RE))

    @test Nucleus.Color.make(st) === re

end

# ---- #

for (st, pr, re) in ((ST, 0, "#ff000000"), (ST, 0.5, "#ff000080"))

    @test Nucleus.Color.make(st, pr) === re

end
