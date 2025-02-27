using Test: @test

using Nucleus

# ---- #

for (nu, ex, re) in (
    (0, 0, 1),
    (0, 1, 0),
    (0, 2, 0),
    (2, 0, 1),
    (2, 1, 2),
    (2, 2, 4),
    (2.0, 0, 1.0),
    (2.0, 1, 2.0),
    (2.0, 2, 4.0),
)

    @test Nucleus.Numbe.make_exponential(nu, ex) === re

end

# ---- #

for (nu, re) in ((pi, "3.1"), (MathConstants.golden, "1.6"))

    @test Nucleus.Numbe.text(nu) === re

end
