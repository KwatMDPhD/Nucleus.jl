using Dates: Date

using Test: @test

using Nucleus

# ---- #

for (st, re) in (("2024 10 28", Date("2024-10-28")),)

    @test Nucleus.Time.make("2024 10 28") === re

end
