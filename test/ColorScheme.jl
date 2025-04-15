using Colors: RGB

using Test: @test

using Nucleus

# ---- #

const CO = Nucleus.ColorScheme.make(("#ff0000", "#0000ff"))

const R1 = RGB(1, 0, 0.0)

const R2 = RGB(0, 0, 1.0)

for (nu, re) in
    ((1, RGB(1, 0, 0)), (2, RGB(0, 0, 1)), (-0.1, R1), (0.0, R1), (1.0, R2), (1.1, R2))

    @test CO[nu] === re

end
