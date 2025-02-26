using Colors: RGB

using Test: @test

using Nucleus

# ---- #

const CO = Nucleus.ColorScheme.make(Nucleus.ColorScheme.BR_)

const C1 = RGB(1, 0, 0.0)

const C2 = RGB(0, 0, 1.0)

for (id, re) in
    ((1, RGB(0, 0, 1)), (0.0, C2), (-0.1, C2), (3, RGB(1, 0, 0)), (1.0, C1), (1.1, C1))

    @test CO[id] === re

end
