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

const CO = "red"

# ---- #

for (co, re) in ((CO, RE), ("#f00", RE), ("#ff0000", RE))

    @test Nucleus.Color.make(co) === re

end

# ---- #

for (co, fr, re) in ((CO, 0, "#ff000000"), (CO, 0.5, "#ff000080"))

    @test Nucleus.Color.make(co, fr) === re

end
