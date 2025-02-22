using Colors: RGB

using Test: @test

using Nucleus

# ---- #

const C1 = RGB(1, 0, 0.0)

const C2 = RGB(0, 0, 1.0)

for (co_, re_) in ((
    Nucleus.ColorScheme.BR_,
    ((1, RGB(0, 0, 1)), (0.0, C2), (-0.1, C2), (3, RGB(1, 0, 0)), (1.0, C1), (1.1, C1)),
),)

    ol = Nucleus.ColorScheme.make(co_)

    @test lastindex(ol) === lastindex(co_)

    for (id, re) in re_

        @test ol[id] === re

    end

end
