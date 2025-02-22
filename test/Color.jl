using Colors: RGB

using Test: @test

using Nucleus

# ---- #

const CO = "red"

const RE = "#ff0000ff"

for (co, fr, re) in (
    (RGB(1.0, 0.0, 0.0), nothing, RE),
    (CO, nothing, RE),
    ("#f00", nothing, RE),
    ("#ff0000", nothing, RE),
    (CO, 0.0, "#ff000000"),
    (CO, 0.5, "#ff000080"),
)

    @test (isnothing(fr) ? Nucleus.Color.make(co) : Nucleus.Color.make(co, fr)) === re

end
