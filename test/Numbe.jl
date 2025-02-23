using Test: @test

using Nucleus

# ---- #

for (nu, re) in ((pi, "3.1"), (MathConstants.golden, "1.6"))

    @test Nucleus.Numbe.text(nu) === re

end
