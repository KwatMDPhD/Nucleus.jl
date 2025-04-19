using Colors: RGB

using Test: @test

using Nucleus

# ---- #

const R1 = RGB(1, 0, 0.0)

const R2 = RGB(0, 0, 1.0)

for (st_, re_) in ((
    ("#ff0000", "#0000ff"),
    ((1, RGB(1, 0, 0)), (2, RGB(0, 0, 1)), (-0.1, R1), (0.0, R1), (1.0, R2), (1.1, R2)),
),)

    co = Nucleus.ColorScheme.make(st_)

    for (nu, re) in re_

        @test co[nu] === re

    end

end
